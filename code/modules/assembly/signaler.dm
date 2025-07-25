/obj/item/device/assembly/signaler
	name = "remote signaling device"
	desc = "Used to remotely activate devices."
	icon_state = "signaller"
	item_state = "signaler"
	drop_sound = 'sound/items/drop/component.ogg'
	pickup_sound = 'sound/items/pickup/component.ogg'
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 1000, MATERIAL_GLASS = 200)
	wires = WIRE_RECEIVE_ASSEMBLY | WIRE_PULSE_ASSEMBLY | WIRE_RADIO_PULSE | WIRE_RADIO_RECEIVE

	secured = TRUE

	var/code = 30
	var/frequency = 1457
	var/delay = 0
	var/airlock_wire
	var/obj/machinery/machine
	var/datum/wires/connected
	var/datum/radio_frequency/radio_connection
	var/deadman = FALSE

/obj/item/device/assembly/signaler/mechanics_hints(mob/user, distance, is_adjacent)
	. += ..()
	. += "Signalers can be attached to a variety of machinery to remotely activate them."
	. += "Signalers can be to individual wires within machinery; when a signal is received, it will pulse the wire much like a multitool."

/obj/item/device/assembly/signaler/antagonist_hints(mob/user, distance, is_adjacent)
	. += ..()
	. += "Signalers can be attached to a variety of machinery to do unspeakable harm or serve as fantastic diversions."

/obj/item/device/assembly/signaler/Initialize()
	. = ..()
	set_frequency(frequency)

/obj/item/device/assembly/signaler/activate()
	if(cooldown)
		return FALSE
	cooldown = 2
	addtimer(CALLBACK(src, PROC_REF(process_cooldown)), 10)

	signal()
	return TRUE

/obj/item/device/assembly/signaler/update_icon()
	if(holder)
		holder.update_icon()
	return

/obj/item/device/assembly/signaler/interact(mob/user, flag1)
	ui_interact(user)

/obj/item/device/assembly/signaler/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Signaler", "Signaler", 320, 220)
		ui.open()

/obj/item/device/assembly/signaler/ui_data(mob/user)
	var/list/data = list()

	data["frequency"] = format_frequency(frequency)
	data["code"] = code

	return data

/obj/item/device/assembly/signaler/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("freq")
			var/new_frequency = text2num(params["freq"]) * 10
			if(new_frequency < RADIO_LOW_FREQ || new_frequency > RADIO_HIGH_FREQ)
				new_frequency = sanitize_frequency(new_frequency, RADIO_LOW_FREQ, RADIO_HIGH_FREQ)
			set_frequency(new_frequency)

		if("code")
			var/new_code = text2num(params["code"])
			code = clamp(new_code, 1, 100)
			code = round(code)

		if("send")
			spawn(0)
				signal(usr)

/obj/item/device/assembly/signaler/proc/signal(var/mob/user)
	if(!radio_connection)
		return
	if(within_jamming_range(src))
		return
	var/datum/signal/signal = new
	signal.source = src
	signal.encryption = code
	signal.data["message"] = "ACTIVATE"
	if(user)
		signal.data["user"] = WEAKREF(user)
	radio_connection.post_signal(src, signal)
	return

/obj/item/device/assembly/signaler/pulse(var/radio = FALSE)
	if(connected && wires)
		connected.pulse_assembly(src)
	else if(holder)
		holder.process_activation(src, 1, 0)
	else if(machine)
		machine.do_signaler()
	else
		..(radio)
	return TRUE

/obj/item/device/assembly/signaler/receive_signal(datum/signal/signal)
	if(!signal)
		return FALSE

	if(within_jamming_range(src))
		return FALSE

	if(signal.encryption != code)
		return FALSE

	if(!(wires & WIRE_RADIO_RECEIVE))
		return FALSE

	pulse(TRUE)

	if(machine)
		var/found_user = FALSE
		if(signal.data["user"])
			var/datum/weakref/user_ref = signal.data["user"]
			var/mob/user = user_ref.resolve()
			if(user)
				found_user = TRUE
				log_signal("[key_name(user)] has sent a signal to [machine.name] ([machine.x]-[machine.y]-[machine.z])")
		if(!found_user)
			log_signal("A userless signaler has sent a signal to [machine.name] ([machine.x]-[machine.y]-[machine.z])")
		machine.audible_message("[icon2html(machine, viewers(get_turf(machine)))] [capitalize_first_letters(src.name)] beeps, \"<b>Beep beep!</b>\"")
	else if(!holder)
		audible_message("[icon2html(src, viewers(get_turf(src)))] [capitalize_first_letters(src.name)] beeps, \"<b>Beep beep!</b>\"")

/obj/item/device/assembly/signaler/proc/set_frequency(new_frequency)
	if(!frequency)
		return
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = SSradio.add_object(src, frequency, RADIO_CHAT)

//Triggers the deadmanswitch if its dropped or moved into ones backpack
/obj/item/device/assembly/signaler/dropped(mob/user)
	. = ..()
	if(deadman)
		if(!user.client)
			deadman_deactivate(user) //To deactivate the deadman if someone disconnects
		else
			deadman_trigger(user)

//Triggers the deadmanswitch if its moved between slots (i.e. from hand into the pocket)
/obj/item/device/assembly/signaler/on_slotmove(var/mob/user)
	. = ..()
	if(deadman)
		deadman_trigger(user)

/obj/item/device/assembly/signaler/process()
	//If we have disabled the deadmanswitch. stop here
	if(!deadman)
		STOP_PROCESSING(SSprocessing, src)
		return
	//That there is just a fallback in case dropped is not being called
	var/mob/M = src.loc
	if(!ismob(M))
		deadman_trigger()
	else if(prob(20))
		M.visible_message(SPAN_DANGER("\The [M]'s finger twitches a bit over \the [src]'s deadman switch!"))
	return

/obj/item/device/assembly/signaler/AltClick(mob/user)
	if(use_check_and_message(user))
		return
	to_chat(user, SPAN_NOTICE("You click \the [src]'s signal button."))
	signal(user)

/obj/item/device/assembly/signaler/proc/deadman_trigger(var/mob/user)
	if(deadman) //If its not activated, there is no point in triggering it
		if(user)
			visible_message(SPAN_DANGER("\The [user] releases \the [src]'s deadman switch!"))
		else
			visible_message(SPAN_DANGER("\The [src]'s deadman switch is released!"))
		signal()
		deadman = FALSE
		STOP_PROCESSING(SSprocessing, src)

/obj/item/device/assembly/signaler/verb/deadman_it()
	set src in usr
	set name = "Hold the deadman switch!"
	set desc = "Sends a signal if dropped or moved into a container."

	if(!deadman)
		deadman_activate(usr)
	else
		deadman_deactivate(usr)


/obj/item/device/assembly/signaler/proc/deadman_activate(var/mob/user)
	deadman = TRUE
	START_PROCESSING(SSprocessing, src)
	log_and_message_admins("is threatening to trigger a signaler deadman's switch")
	user.visible_message(SPAN_WARNING("[user] presses and holds \the [src]'s deadman switch..."))
	to_chat(user, SPAN_WARNING("You are now holding \the [src]'s deadman switch. Dropping, putting the device away, or being hit will activate the signaller."))
	to_chat(user, SPAN_NOTICE("To deactivate it, make sure to press the verb again."))

/obj/item/device/assembly/signaler/proc/deadman_deactivate(var/mob/user)
	deadman = FALSE
	STOP_PROCESSING(SSprocessing, src)
	user.visible_message(SPAN_NOTICE("\The [user] secures and releases \the [src]'s deadman switch..."))

/obj/item/device/assembly/signaler/Destroy()
	if(SSradio)
		SSradio.remove_object(src,frequency)
	frequency = 0
	return ..()

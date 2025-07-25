// Regular airbubble - folded
/obj/item/airbubble
	name = "air bubble"
	desc = "Special air bubble designed to protect people inside of it from decompressed environments. Has an integrated cooling unit to preserve a stable temperature inside. Requires a power cell to operate."
	icon = 'icons/obj/airbubble.dmi'
	icon_state = "airbubble_fact_folded"
	w_class = WEIGHT_CLASS_NORMAL
	var/used = FALSE
	var/ripped = FALSE
	var/zipped = FALSE
	var/obj/item/tank/internal_tank
	var/syndie = FALSE

/obj/item/airbubble/Destroy()
	qdel(internal_tank)
	return ..()

// Deploy the bubble and transfer all properties of it
/obj/item/airbubble/attack_self(mob/user)
	if (!isturf(user.loc))
		to_chat(user, "You're fucking stupid, the air bubble can't deploy in an enclosed space.")
		return

	user.visible_message(
		SPAN_WARNING("[user] begins deploying \the [src]."),
		SPAN_NOTICE("You begin deplyoing \the [src].")
	)
	if (!do_after(user, 0.45 SECONDS))
		return
	user.visible_message(
		SPAN_WARNING("[user] deployed \the [src].") ,
		SPAN_NOTICE("You deploy \the [src].")
	)
	var/obj/structure/closet/airbubble/R
	if(syndie)
		R = new /obj/structure/closet/airbubble/syndie(user.loc)
	else
		R = new /obj/structure/closet/airbubble(user.loc)
	if(!used)
		internal_tank = new /obj/item/tank/emergency_oxygen/engi(src)
		internal_tank.air_contents.adjust_gas(GAS_OXYGEN, (42*ONE_ATMOSPHERE)/(R_IDEAL_GAS_EQUATION*T20C))
	R.internal_tank = internal_tank
	if(!isnull(internal_tank))
		internal_tank.forceMove(R)
		internal_tank = null
	R.add_fingerprint(user)
	R.ripped = ripped
	R.zipped = zipped
	R.update_icon()
	R.desc = desc
	user.drop_from_inventory(src)
	qdel(src)

// Deployed bubble
/obj/structure/closet/airbubble
	name = "air bubble"
	desc = "Special air bubble designed to protect people inside of it from decompressed environments. Has an integrated cooling unit to preserve a stable temperature inside. Requires a power cell to operate."
	icon = 'icons/obj/airbubble.dmi'
	icon_state = "airbubble"
	open_sound = 'sound/items/zip.ogg'
	close_sound = 'sound/items/zip.ogg'
	var/item_path = /obj/item/airbubble
	var/zipped = FALSE
	density = 0
	storage_capacity = 20
	var/used = TRUE // If we have deployed it once
	var/ripped = FALSE // If it has a hole it in, vent all the air outside
	var/breakout_time = 1 // How many minutes it takes to break out of it.

	var/use_internal_tank = TRUE
	var/datum/gas_mixture/inside_air
	var/internal_tank_valve = 45 // arbitrary for now
	var/obj/item/tank/internal_tank
	var/syndie = FALSE
	var/last_shake = 0
	var/cooling = FALSE
	var/obj/item/cell/cell = null
	var/max_cooling = 12				//in degrees per second - probably don't need to mess with heat capacity here
	var/charge_consumption = 8.3		//charge per second at max_cooling
	var/thermostat = T20C
	slowdown = 0

// Examine to see tank pressure
/obj/structure/closet/airbubble/feedback_hints(mob/user, distance, is_adjacent)
	. += ..()
	if(!isnull(internal_tank))
		. += SPAN_NOTICE("\The [src] has [internal_tank] attached, that displays <b>[round(internal_tank.air_contents.return_pressure() ? internal_tank.air_contents.return_pressure() : 0)] kPa</b>.")
	else
		. += SPAN_NOTICE("\The [src] has no tank attached.")
	if (cell)
		. += "\The [src] has [cell] attached, the charge meter reads <b>[round(cell.percent())]%</b>."
	else
		. += SPAN_WARNING("[src] has no power cell installed.")

/obj/structure/closet/airbubble/can_open()
	if(zipped)
		return 0
	return 1

/obj/structure/closet/airbubble/can_close(mob/user as mob)
	if(zipped)
		return 0
	var/turf/T = get_turf(src)
	for (var/obj/O in T)
		if (O.density && O != src)
			return 0
	var/mob_num = 0
	for(var/mob/living/M in T)
		mob_num += 1
		if(mob_num > 1)
			to_chat(user, SPAN_WARNING("[src] can only fit one person."))
			return 0
	return 1

/obj/structure/closet/airbubble/dump_contents()

	for(var/obj/I in src)
		if (I != internal_tank && I != cell)
			I.forceMove(loc)

	for(var/mob/M in src)
		M.forceMove(loc)
		if(M.client)
			M.client.eye = M.client.mob
			M.client.perspective = MOB_PERSPECTIVE

/obj/structure/closet/airbubble/Initialize()
	. = ..()
	add_inside()
	START_PROCESSING(SSfast_process, src)

/obj/structure/closet/airbubble/Destroy()
	STOP_PROCESSING(SSfast_process, src)
	qdel(internal_tank)
	if(parts)
		new parts(loc)
	if (smoothing_flags)
		QUEUE_SMOOTH_NEIGHBORS(src)
	return ..()

/obj/structure/closet/airbubble/toggle(mob/user as mob)
	if(!(opened ? close(user) : open(user)))
		to_chat(user, SPAN_NOTICE("It won't budge!"))
		return
	update_icon()
	return 1

/obj/structure/closet/airbubble/open(mob/user as mob)
	if(opened)
		return 0

	if(!can_open())
		return 0

	dump_contents()

	update_icon()
	opened = 1
	playsound(loc, open_sound, 15, 1, -3)
	density = 0
	return 1

/obj/structure/closet/airbubble/close(mob/user as mob)
	if(!opened)
		return 0
	if(!can_close(user))
		return 0

	var/stored_units = 0

	if(store_misc)
		stored_units += store_misc(stored_units)
	if(store_items)
		stored_units += store_items(stored_units)
	if(store_mobs)
		stored_units += store_mobs(stored_units)

	update_icon()
	opened = 0

	playsound(loc, close_sound, 25, 0, -3)
	density = 1
	add_inside()
	return 1

// Fold the bubble, transfering properties.
/obj/structure/closet/airbubble/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if((!zipped || ripped )&& (over == user && (in_range(src, user) || user.contents.Find(src))))
		if(!ishuman(user))	return
		if(opened)	return 0
		if(contents.len > 1)	return 0
		if(cell)
			to_chat(user, SPAN_WARNING("[src] can not be folded with [cell] attached to it."))
			return
		user.visible_message(
		SPAN_WARNING("[user] begins folding up the [src.name]."),
		SPAN_NOTICE("You begin folding up the [src.name].")
		)
		if (!do_after(user, 0.45 SECONDS))
			return
		user.visible_message(
		SPAN_WARNING("[user] folds up the [src.name].") ,
		SPAN_NOTICE("You fold up the [src.name].")
		)
		var/obj/item/airbubble/bag
		if(syndie)
			bag = new /obj/item/airbubble/syndie(get_turf(src))
		else
			bag = new /obj/item/airbubble(get_turf(src))
		bag.ripped = ripped
		bag.zipped = zipped
		bag.used = TRUE
		bag.internal_tank = internal_tank
		if(!isnull(internal_tank))
			internal_tank.forceMove(bag)
			internal_tank = null
		bag.w_class = WEIGHT_CLASS_BULKY

		bag.desc = "Special air bubble designed to protect people inside of it from decompressed environments. Has an integrated cooling unit to preserve a stable temperature inside. Requires a power cell to operate."
		if(syndie)
			bag.desc += " This does not seem like a regular color scheme"
		bag.desc += SPAN_NOTICE(" It appears to be poorly hand folded.")

		if(ripped)
			bag.icon_state = "[icon_state]_man_folded_ripped"
			bag.desc += SPAN_DANGER(" It has hole in it! Maybe you shouldn't use it!")
		else
			bag.icon_state = "[icon_state]_man_folded"
		qdel(src)
		return
	return ..()

/obj/structure/closet/airbubble/req_breakout()

	if(opened)
		return 0 //Door's open... wait, why are you in it's contents then?
	if(zipped)
		return 1 // If it is zipped
	if(breakout)
		return -1 //Already breaking out.
	return 0

/obj/structure/closet/airbubble/proc/breakout_callback(var/mob/living/escapee)
	if (QDELETED(escapee))
		return FALSE

	if ((world.time - last_shake) > 5 SECONDS)
		var/sound_to_play = pick(list('sound/items/rip1.ogg', 'sound/items/rip2.ogg'))
		playsound(loc, sound_to_play, 100, 1)
		shake_animation()
		last_shake = world.time

	if (!req_breakout())
		return FALSE

	return TRUE

// If we are stuck, and need to get out
/obj/structure/closet/airbubble/mob_breakout(var/mob/living/escapee)
	if (req_breakout() < 1)
		return

	escapee.next_move = world.time + 100
	escapee.last_special = world.time + 100
	to_chat(escapee, SPAN_WARNING("You lean on the back of \the [src] and start punching internal wall with your legs. (this will take about [breakout_time] minutes)"))
	visible_message(SPAN_DANGER("\The [src] begins to shake violently! Something is terring it from the inside!"))

	var/time = 360 * breakout_time * 2
	breakout = TRUE

	if (!do_after(escapee, time, src, extra_checks = CALLBACK(src, PROC_REF(breakout_callback), escapee)))
		breakout = FALSE
		return

	breakout = FALSE
	to_chat(escapee, SPAN_WARNING("You successfully break out! Tearing the bubble's walls!")) // holy shit this is hilarious
	visible_message(SPAN_DANGER("\the [escapee] successfully broke out of \the [src]! Tearing the bubble's walls!"))
	var/sound_to_play = pick(list('sound/items/rip1.ogg', 'sound/items/rip2.ogg'))
	playsound(loc, sound_to_play, 100, 1)
	break_open()
	shake_animation()
	desc += SPAN_DANGER(" It has hole in it! Maybe you shouldn't use it!")

// We are out finally, the bubble is ripped. So dump everything out from it. Especially air and user.
/obj/structure/closet/airbubble/break_open()
	ripped = TRUE
	update_icon()
	dump_contents()
	var/datum/gas_mixture/t_air = get_turf_air()
	t_air.merge(inside_air)

// When we shoot bubble, make it rip.
/obj/structure/closet/airbubble/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit)
	. = ..()
	if(. != BULLET_ACT_HIT)
		return .

	ripped = TRUE
	update_icon()

// Change valve on internal tank
/obj/structure/closet/airbubble/verb/set_internals()
	set src in oview(1)
	set category = "Object"
	set name = "Set Internals"

	if(!usr.canmove || usr.stat || usr.restrained())
		return

	if(!ishuman(usr))
		to_chat(usr, SPAN_WARNING("This mob type can't use this verb."))
		return

	if(!isnull(internal_tank))
		usr.visible_message(
		SPAN_WARNING("[usr] is setting [src] internals."),
		SPAN_NOTICE("You are settting [src] internals.")
		)
		if (!do_after(usr, 2 SECONDS, src))
			return
		usr.visible_message(
		SPAN_WARNING("[usr] has set [src] internals.") ,
		SPAN_NOTICE("You set [src] internals.")
		)
		if(use_internal_tank)
			STOP_PROCESSING(SSfast_process, src)
		else
			START_PROCESSING(SSfast_process, src)
		use_internal_tank = !use_internal_tank
		update_icon()
	else
		to_chat(usr, SPAN_NOTICE("[src] has no internal tank."))

// Remove tank from bubble
/obj/structure/closet/airbubble/verb/take_tank()
	set src in oview(1)
	set category = "Object"
	set name = "Remove Air Tank"

	if(!usr.canmove || usr.stat || usr.restrained())
		return

	if(!ishuman(usr))
		to_chat(usr, SPAN_WARNING("This mob type can't use this verb."))
		return

	if(!isnull(internal_tank))
		usr.visible_message(
		SPAN_WARNING("[usr] is removing [internal_tank] from [src]."),
		SPAN_NOTICE("You are removing [internal_tank] from [src].")
		)
		if (!do_after(usr, 2 SECONDS, src))
			return
		usr.visible_message(
		SPAN_WARNING("[usr] has removed [internal_tank] from [src]."),
		SPAN_NOTICE("You removed [internal_tank] from [src].")
		)
		for(var/obj/I in src)
			I.forceMove(usr.loc)
		use_internal_tank = 0
		internal_tank = null
		update_icon()
		STOP_PROCESSING(SSfast_process, src)
	else
		to_chat(usr, SPAN_WARNING("[src] has no tank."))

// Remove tank from bubble
/obj/structure/closet/airbubble/verb/take_cell()
	set src in oview(1)
	set category = "Object"
	set name = "Detach Power Cell"

	if(!usr.canmove || usr.stat || usr.restrained())
		return

	if(!ishuman(usr))
		to_chat(usr, SPAN_WARNING("This mob type can't use this verb."))
		return

	if(!isnull(cell))
		usr.visible_message(
		SPAN_WARNING("[usr] is removing [cell] from [src]."),
		SPAN_NOTICE("You are removing [cell] from [src].")
		)
		if (!do_after(usr, 2 SECONDS, src))
			return
		usr.visible_message(
		SPAN_WARNING("[usr] has removed [cell] from [src]."),
		SPAN_NOTICE("You removed [cell] from [src].")
		)
		cell.forceMove(usr.loc)
		cell = null
		cooling = FALSE
		update_icon()
	else
		to_chat(usr, SPAN_WARNING("[src] has no power cell."))

// Handle most of things: restraining, cutting restrains, attaching tank.
/obj/structure/closet/airbubble/attackby(obj/item/attacking_item, mob/user)
	if(istype(attacking_item, /obj/item/tank))
		if(!isnull(use_internal_tank))
			user.visible_message(
			SPAN_WARNING("[user] is attaching [attacking_item] to [src]."),
			SPAN_NOTICE("You are attaching [attacking_item] to [src].")
			)
			if (!do_after(user, 2 SECONDS, src))
				return
			user.visible_message(
			SPAN_WARNING("[user] has attached [attacking_item] to [src]."),
			SPAN_NOTICE("You attached [attacking_item] to [src].")
			)
			internal_tank = attacking_item
			user.drop_from_inventory(attacking_item, src)
			use_internal_tank = 1
			START_PROCESSING(SSfast_process, src)
		else
			to_chat(user, SPAN_WARNING("[src] already has a tank attached."))
		return TRUE
	if(opened)
		if(istype(attacking_item, /obj/item/grab))
			var/obj/item/grab/G = attacking_item
			mouse_drop_receive(G.affecting, user)
			return FALSE
		if(!attacking_item.dropsafety())
			return FALSE
		user.drop_item()
		return TRUE
	else if(istype(attacking_item, /obj/item/handcuffs/cable))
		if(zipped)
			to_chat(user, SPAN_WARNING("[src]'s zipper is already restrained."))
			return TRUE
		user.visible_message(
		SPAN_WARNING("[user] begins putting cable restrains on zipper of [src]."),
		SPAN_NOTICE("You begin putting cable restrains on zipper of [src].")
		)
		playsound(loc, 'sound/weapons/cablecuff.ogg', 50, 1)
		if (!do_after(user, 3 SECONDS, src, extra_checks = CALLBACK(src, PROC_REF(is_closed))))
			return TRUE
		zipped = !zipped
		update_icon()
		user.visible_message(
		SPAN_WARNING("[src]'s zipper have been zipped by [user]."),
		SPAN_NOTICE("You put restrains on [src]'s zipper.")
		)

		qdel(attacking_item)
		update_icon()
		return TRUE
	else if(attacking_item.iswirecutter())
		if(!zipped)
			to_chat(user, SPAN_WARNING("[src] has no cables to cut."))
			attack_hand(user)
			return TRUE
		user.visible_message(
		SPAN_WARNING("[user] begins cutting cable restrains on zipper of [src]."),
		SPAN_NOTICE("You begin cutting cable restrains on zipper of [src].")
		)
		playsound(loc, 'sound/items/Wirecutter.ogg', 50, 1)
		if (!do_after(user, 3 SECONDS, src, extra_checks = CALLBACK(src, PROC_REF(is_closed))))
			return TRUE
		zipped = !zipped
		update_icon()
		user.visible_message(
		SPAN_WARNING("[src] zipper's cable restrains has been cut by [user]."),
		SPAN_NOTICE("You cut cable restrains on [src]'s zipper.")
		)
		new/obj/item/handcuffs/cable(src.loc)
		update_icon()
		return TRUE
	else if(istype(attacking_item, /obj/item/cell))
		if(!isnull(cell))
			to_chat(user, SPAN_WARNING("[src] already has [cell] attached to it."))
			attack_hand(user)
			return TRUE
		user.visible_message(
		SPAN_WARNING("[user] is attaching [attacking_item] to [src]."),
		SPAN_NOTICE("You are attaching [attacking_item] to [src].")
		)
		if (!do_after(user, 2 SECONDS, src))
			return TRUE
		user.visible_message(
		SPAN_WARNING("[user] has attached [attacking_item] to [src]."),
		SPAN_NOTICE("You attached [attacking_item] to [src].")
		)
		cell = attacking_item
		cooling = TRUE
		user.drop_from_inventory(attacking_item, src)
		return TRUE
	else
		return attack_hand(user)

/obj/structure/closet/airbubble/store_mobs(var/stored_units, var/mob_limit)
	contains_body = ..(stored_units, mob_limit = TRUE)
	return contains_body

/obj/structure/closet/airbubble/update_icon()
	ClearOverlays()
	if(ripped)
		name = "ripped air bubble"
		icon_state = "[icon_state]_ripped"
	else
		icon_state = "[initial(icon_state)][opened ? "_open" : ""]"
	if(zipped)
		AddOverlays("[icon_state]_restrained")
	AddOverlays("pressure_[(use_internal_tank) ?("on") : ("off") ]")

// Process transfer of air from the tank. Handle if it is ripped open.
/obj/structure/closet/airbubble/proc/process_tank_give_air()
	if(internal_tank)
		var/datum/gas_mixture/tank_air = internal_tank.return_air()

		var/release_pressure = internal_tank_valve
		// If ripped, we are leaking
		if(ripped)
			// If we has no pressure in the tank, why bother?
			if(tank_air.return_pressure() <= 1)
				STOP_PROCESSING(SSfast_process, src)
				use_internal_tank = !use_internal_tank
				visible_message(SPAN_WARNING("You hear last bits of air coming out from [src]'s hole.Maybe the tank run out of air?"))
				playsound(loc, 'sound/effects/wind/wind_2_1.ogg', 100, 1)
				return
			inside_air = get_turf_air()
			visible_message(SPAN_WARNING("You hear air howling from [src]'s hole. Maybe it is good to shut off valve on the internals tank?"))
			playsound(loc, 'sound/effects/wind/wind_2_2.ogg', 100, 1)

			var/transfer_moles = inside_air.volume/(inside_air.temperature * R_IDEAL_GAS_EQUATION)
			var/datum/gas_mixture/removed = tank_air.remove(transfer_moles)
			if(inside_air)
				inside_air.merge(removed)
			else
				qdel(removed)
			return
		var/inside_pressure = inside_air.return_pressure()
		var/pressure_delta = min(release_pressure - inside_pressure, (tank_air.return_pressure() - inside_pressure)/2)
		var/transfer_moles = 0

		if(pressure_delta > 0) //inside pressure lower than release pressure
			if(tank_air.temperature > 0)
				transfer_moles = pressure_delta*inside_air.volume/(inside_air.temperature * R_IDEAL_GAS_EQUATION)
				var/datum/gas_mixture/removed = tank_air.remove(transfer_moles)
				inside_air.merge(removed)

		else if(pressure_delta < 0) //inside pressure higher than release pressure
			var/datum/gas_mixture/t_air = get_turf_air()
			pressure_delta = inside_pressure - release_pressure

			if(t_air)
				pressure_delta = min(inside_pressure - t_air.return_pressure(), pressure_delta)
			if(pressure_delta > 0) //if location pressure is lower than inside pressure
				transfer_moles = pressure_delta*inside_air.volume/(inside_air.temperature * R_IDEAL_GAS_EQUATION)

				var/datum/gas_mixture/removed = inside_air.remove(transfer_moles)
				if(t_air)
					t_air.merge(removed)
				else //just delete the inside gas, we're in space or some shit
					qdel(removed)

/obj/structure/closet/airbubble/proc/process_preserve_temp()
	if (!cooling || !cell)
		return
	for(var/mob/living/carbon/human/H in src)
		var/datum/gas_mixture/t_air = get_turf_air()
		if(!t_air)
			return
		var/env_temp = t_air.temperature
		var/temp_adj = min(H.bodytemperature - max(thermostat, env_temp), max_cooling)

		if (temp_adj < 0.5)	//only cools, doesn't heat, also we don't need extreme precision
			return

		var/charge_usage = (temp_adj/max_cooling)*charge_consumption
		H.bodytemperature -= temp_adj

		cell.use(charge_usage)

		if(cell.charge <= 0)
			cooling = FALSE

/obj/structure/closet/airbubble/return_air()
	if(use_internal_tank)
		return inside_air
	return ..()

/obj/structure/closet/airbubble/proc/get_turf_air()
	var/turf/T = get_turf(src)
	if(T)
		return T.return_air()

/obj/structure/closet/airbubble/proc/return_pressure()
	. = 0
	if(use_internal_tank)
		. =  inside_air.return_pressure()
	else
		var/datum/gas_mixture/t_air = get_turf_air()
		if(t_air)
			. = t_air.return_pressure()
	return


/obj/structure/closet/airbubble/proc/return_temperature()
	. = 0
	if(use_internal_tank)
		. = inside_air.temperature
	else
		var/datum/gas_mixture/t_air = get_turf_air()
		if(t_air)
			. = t_air.temperature
	return

/obj/structure/closet/airbubble/process()
	process_preserve_temp()
	process_tank_give_air()

/obj/structure/closet/airbubble/proc/add_inside()
	inside_air = new
	inside_air.temperature = T20C
	inside_air.volume = 2
	inside_air.adjust_multi(GAS_OXYGEN, O2STANDARD*inside_air.volume/(R_IDEAL_GAS_EQUATION*inside_air.temperature), GAS_NITROGEN, N2STANDARD*inside_air.volume/(R_IDEAL_GAS_EQUATION*inside_air.temperature))
	return inside_air

// Syndicate airbubble
/obj/item/airbubble/syndie
	name = "air bubble"
	desc = "Special air bubble designed to protect people inside of it from decompressed environments. Has an integrated cooling unit to preserve a stable temperature inside. Requires a power cell to operate. This does not seem like a regular color scheme."
	icon_state = "airbubble_syndie_fact_folded"
	syndie = TRUE

/obj/structure/closet/airbubble/syndie
	name = "air bubble"
	desc = "Special air bubble designed to protect people inside of it from decompressed environments. Has an integrated cooling unit to preserve a stable temperature inside. Requires a power cell to operate. This does not seem like a regular color scheme."
	icon_state = "airbubble_syndie"
	item_path = /obj/item/airbubble/syndie
	syndie = TRUE

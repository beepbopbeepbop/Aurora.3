/obj/machinery/portable_atmospherics/powered/pump
	name = "portable air pump"
	desc = "Used to fill or drain rooms without differentiating between gases. Invaluable for filling air in a room rapidly after a breach repair."
	icon = 'icons/obj/atmos.dmi'
	icon_state = "psiphon:0"
	density = TRUE
	w_class = WEIGHT_CLASS_NORMAL

	var/on = FALSE
	var/direction_out = 0 //0 = siphoning, 1 = releasing
	var/target_pressure = ONE_ATMOSPHERE

	var/pressuremin = 0
	var/pressuremax = PRESSURE_ONE_THOUSAND

	volume = 1000

	power_rating = 7500 //7500 W ~ 10 HP
	power_losses = 150

/obj/machinery/portable_atmospherics/powered/pump/mechanics_hints(mob/user, distance, is_adjacent)
	. += ..()
	. += "The internal gas container can be filled by connecting it to a connector port.  The pump can pump the air in (sucking) \
	or out (blowing), at a specific target pressure."
	. += "The power cell inside can be replaced by using a screwdriver, then adding a new cell. Screw it closed again afterwards."
	. += "A tank of gas can also be attached to the air pump."

/obj/machinery/portable_atmospherics/powered/pump/filled
	start_pressure = PRESSURE_ONE_THOUSAND * 5

/obj/machinery/portable_atmospherics/powered/pump/Initialize()
	. = ..()
	cell = new/obj/item/cell/apc(src)

	var/list/air_mix = StandardAirMix()
	src.air_contents.adjust_multi(GAS_OXYGEN, air_mix[GAS_OXYGEN], GAS_NITROGEN, air_mix[GAS_NITROGEN])

/obj/machinery/portable_atmospherics/powered/pump/update_icon()
	ClearOverlays()

	if(on && cell && cell.charge)
		icon_state = "psiphon:1"
	else
		icon_state = "psiphon:0"

	if(holding)
		AddOverlays("siphon-open")

	if(connected_port)
		AddOverlays("siphon-connector")

	return

/obj/machinery/portable_atmospherics/powered/pump/emp_act(severity)
	. = ..()

	if(stat & (BROKEN|NOPOWER))
		return

	if(prob(50/severity))
		on = !on

	if(prob(100/severity))
		direction_out = !direction_out

	target_pressure = rand(0,1300)
	update_icon()
	SStgui.update_uis(src)

/obj/machinery/portable_atmospherics/powered/pump/process()
	..()
	var/power_draw = -1

	if(on && cell && cell.charge)
		var/datum/gas_mixture/environment
		if(holding)
			environment = holding.air_contents
		else if(loc)
			environment = loc.return_air()
		else return

		var/pressure_delta
		var/output_volume
		var/air_temperature
		if(direction_out)
			pressure_delta = target_pressure - environment.return_pressure()
			output_volume = environment.volume * environment.group_multiplier
			air_temperature = environment.temperature? environment.temperature : air_contents.temperature
		else
			pressure_delta = environment.return_pressure() - target_pressure
			output_volume = air_contents.volume * air_contents.group_multiplier
			air_temperature = air_contents.temperature? air_contents.temperature : environment.temperature

		var/transfer_moles = pressure_delta*output_volume/(air_temperature * R_IDEAL_GAS_EQUATION)

		if (pressure_delta > 0.01)
			if (direction_out)
				power_draw = pump_gas(src, air_contents, environment, transfer_moles, power_rating)
			else
				power_draw = pump_gas(src, environment, air_contents, transfer_moles, power_rating)

	if (power_draw < 0)
		last_flow_rate = 0
		last_power_draw = 0
	else
		power_draw = max(power_draw, power_losses)
		cell.use(power_draw * CELLRATE)
		last_power_draw = power_draw

		update_connected_network()

		//ran out of charge
		if (!cell.charge)
			power_change()
			update_icon()

	src.updateDialog()
	SStgui.update_uis(src)

/obj/machinery/portable_atmospherics/powered/pump/return_air()
	return air_contents

/obj/machinery/portable_atmospherics/powered/pump/attack_ai(var/mob/user)
	if(!ai_can_interact(user))
		return
	src.add_hiddenprint(user)
	return src.attack_hand(user)

/obj/machinery/portable_atmospherics/powered/pump/attack_ghost(var/mob/user)
	return src.attack_hand(user)

/obj/machinery/portable_atmospherics/powered/pump/attack_hand(var/mob/user)
	ui_interact(user)

/obj/machinery/portable_atmospherics/powered/pump/ui_data(mob/user)
	var/list/data = list()
	data["portConnected"] = connected_port ? 1 : 0
	data["tankPressure"] = round(air_contents.return_pressure() > 0 ? air_contents.return_pressure() : 0)
	data["targetpressure"] = round(target_pressure)
	data["pump_dir"] = direction_out
	data["minpressure"] = round(pressuremin)
	data["maxpressure"] = round(pressuremax)
	data["powerDraw"] = round(last_power_draw)
	data["cellCharge"] = cell ? cell.charge : 0
	data["cellMaxCharge"] = cell ? cell.maxcharge : 1
	data["on"] = on ? 1 : 0

	data["hasHoldingTank"] = holding ? 1 : 0
	if (holding)
		data["holdingTank"] = list("name" = holding.name, "tankPressure" = round(holding.air_contents.return_pressure() > 0 ? holding.air_contents.return_pressure() : 0))
	return data

/obj/machinery/portable_atmospherics/powered/pump/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PortablePump", "Portable Pump", 480, 450)
		ui.open()

/obj/machinery/portable_atmospherics/powered/pump/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("power")
			on = !on
			. = TRUE
		if("direction")
			direction_out = !direction_out
			. = TRUE
		if ("remove_tank")
			if(holding)
				holding.forceMove(loc)
				holding = null
			. = TRUE
		if ("pressure_set")
			target_pressure = between(pressuremin, text2num(params["pressure_set"]), pressuremax)
			. = TRUE

	if(.)
		update_icon()

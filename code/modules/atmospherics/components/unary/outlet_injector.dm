//Basically a one way passive valve. If the pressure inside is greater than the environment then gas will flow passively,
//but it does not permit gas to flow back from the environment into the injector. Can be turned off to prevent any gas flow.
//When it receives the "inject" signal, it will try to pump it's entire contents into the environment regardless of pressure, using power.

/obj/machinery/atmospherics/unary/outlet_injector
	name = "air injector"
	desc = "Passively injects air into its surroundings. Has a valve attached to it that can control flow rate."
	icon = 'icons/atmos/injector.dmi'
	icon_state = "map_injector"

	use_power = POWER_USE_OFF
	idle_power_usage = 150		//internal circuitry, friction losses and stuff
	power_rating = 45000	//45000 W ~ 60 HP

	var/injecting = 0

	var/volume_rate = 50	//flow rate limit

	var/frequency = 0
	var/id = null
	var/datum/radio_frequency/radio_connection

	var/broadcast_status_next_process = FALSE

	level = 1

/obj/machinery/atmospherics/unary/outlet_injector/mechanics_hints(mob/user, distance, is_adjacent)
	. += ..()
	. += "Outputs the pipe's gas into the atmosphere, similar to an airvent."
	. += "It can be controlled by a nearby atmospherics computer."
	. += "A green light on it means it is on."

/obj/machinery/atmospherics/unary/outlet_injector/Initialize()
	. = ..()
	air_contents.volume = ATMOS_DEFAULT_VOLUME_PUMP + 500	//Give it a small reservoir for injecting. Also allows it to have a higher flow rate limit than vent pumps, to differentiate injectors a bit more.

/obj/machinery/atmospherics/unary/outlet_injector/update_icon()
	if(!powered())
		icon_state = "off"
	else
		icon_state = "[use_power ? "on" : "off"]"

/obj/machinery/atmospherics/unary/outlet_injector/update_underlays()
	if(..())
		underlays.Cut()
		var/turf/T = get_turf(src)
		if(!istype(T))
			return
		add_underlay(T, node, dir)

/obj/machinery/atmospherics/unary/outlet_injector/power_change()
	var/old_stat = stat
	..()
	if(old_stat != stat)
		update_icon()

/obj/machinery/atmospherics/unary/outlet_injector/process()
	..()

	last_power_draw = 0
	last_flow_rate = 0

	if (broadcast_status_next_process)
		broadcast_status()
		broadcast_status_next_process = FALSE

	if((stat & (NOPOWER|BROKEN)) || !use_power)
		return

	var/power_draw = -1
	if(!loc) return FALSE
	var/datum/gas_mixture/environment = loc.return_air()

	if(environment && air_contents.temperature > 0)
		var/transfer_moles = (volume_rate/air_contents.volume)*air_contents.total_moles //apply flow rate limit
		power_draw = pump_gas(src, air_contents, environment, transfer_moles, power_rating)

	if (power_draw >= 0)
		last_power_draw = power_draw
		use_power_oneoff(power_draw)

		if(network)
			network.update = 1

	return 1

/obj/machinery/atmospherics/unary/outlet_injector/proc/inject()
	if(injecting || (stat & NOPOWER) || !loc)
		return 0

	var/datum/gas_mixture/environment = loc.return_air()
	if (!environment)
		return 0

	injecting = 1

	if(air_contents.temperature > 0)
		var/power_used = pump_gas(src, air_contents, environment, air_contents.total_moles, power_rating)
		use_power_oneoff(power_used)

		if(network)
			network.update = 1

	flick("inject", src)

/obj/machinery/atmospherics/unary/outlet_injector/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	if(frequency)
		radio_connection = SSradio.add_object(src, frequency)

/obj/machinery/atmospherics/unary/outlet_injector/proc/broadcast_status()
	if(!radio_connection)
		return 0

	var/datum/signal/signal = new
	signal.transmission_method = TRANSMISSION_RADIO
	signal.source = src

	signal.data = list(
		"tag" = id,
		"device" = "AO",
		"power" = use_power,
		"volume_rate" = volume_rate,
		"sigtype" = "status"
	)

	radio_connection.post_signal(src, signal)

	return 1

/obj/machinery/atmospherics/unary/outlet_injector/atmos_init()
	..()

	set_frequency(frequency)
	broadcast_status()

/obj/machinery/atmospherics/unary/outlet_injector/receive_signal(datum/signal/signal)
	if(!signal.data["tag"] || (signal.data["tag"] != id) || (signal.data["sigtype"]!="command"))
		return 0

	if(signal.data["power"])
		update_use_power(text2num(signal.data["power"]))

	if(signal.data["power_toggle"])
		update_use_power(!use_power)

	if(signal.data["inject"])
		spawn inject()
		return

	if(signal.data["set_volume_rate"])
		var/number = text2num(signal.data["set_volume_rate"])
		volume_rate = between(0, number, air_contents.volume)

	if(signal.data["status"])
		broadcast_status_next_process = TRUE
		return //do not update_icon

	broadcast_status_next_process = TRUE
	update_icon()

/obj/machinery/atmospherics/unary/outlet_injector/hide(var/i)
	update_underlays()

// ---------- subtypes

/obj/machinery/atmospherics/unary/outlet_injector/supply
	connect_types = CONNECT_TYPE_SUPPLY

/obj/machinery/atmospherics/unary/outlet_injector/scrubber
	connect_types = CONNECT_TYPE_SCRUBBER

/obj/machinery/atmospherics/unary/outlet_injector/fuel
	connect_types = CONNECT_TYPE_FUEL

/obj/machinery/atmospherics/unary/outlet_injector/aux
	connect_types = CONNECT_TYPE_AUX

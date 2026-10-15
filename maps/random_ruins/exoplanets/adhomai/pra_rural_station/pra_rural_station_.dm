/datum/map_template/ruin/exoplanet/pra_rural_station
	name = "PRA Rural Station"
	id = "pra_rural_station"
	description = "An advanced outpost of the People's Republic of Adhomai's intelligence service."

	spawn_weight = 1
	spawn_cost = 2
	template_flags = TEMPLATE_FLAG_NO_RUINS|TEMPLATE_FLAG_RUIN_STARTS_DISALLOWED
	sectors = list(SECTOR_SRANDMARR)

	prefix = "pra_rural_station/"
	suffix = "pra_rural_station.dmm"

	unit_test_groups = list(3)

/area/pra_rural_station
	name = "PRA Rural Station"
	icon_state = "bluenew"
	requires_power = FALSE
	no_light_control = FALSE
	base_turf = /turf/simulated/floor/exoplanet/mineral/adhomai
	area_flags = AREA_FLAG_RAD_SHIELDED
	ambience = AMBIENCE_HIGHSEC
	area_blurb = "You feel watched inside this ominous compound."

/obj/item/key/door_key/pra_rural_station
	name = "NPD Rural Station Key"
	access_list = list(
		/datum/access/npd_rural_station
	)

/obj/item/key/door_key/pra_rural_station/psis
	name = "PSIS Field Office Key"
	access_list = list(
		/datum/access/npd_rural_station,
		/datum/access/psis_field_office
	)

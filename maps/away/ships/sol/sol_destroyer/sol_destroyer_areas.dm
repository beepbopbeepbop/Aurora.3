/area/sol_destroyer
	name = "Solarian Navy Destroyer"
	icon_state = "green"
	requires_power = TRUE
	no_light_control = FALSE
	base_turf = /turf/space
	area_flags = AREA_FLAG_RAD_SHIELDED
	ambience = AMBIENCE_ENGINEERING

/area/sol_destroyer/hangar
	name = "Solarian Navy Destroyer - Hangar Bay"
	icon_state = "hangar"
	ambience = AMBIENCE_HANGAR

// Shuttle areas
/area/shuttle/sol_destroyer/transport
	name = "Sol Destroyer Transport Shuttle"
	requires_power = TRUE

/area/shuttle/sol_destroyer/fighter
	name = "Sol Destroyer Fighter"
	requires_power = TRUE

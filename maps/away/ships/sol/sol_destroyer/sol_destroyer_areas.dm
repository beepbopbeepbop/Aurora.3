/area/sol_destroyer
	name = "Solarian Navy Destroyer"
	icon_state = "green"
	requires_power = TRUE
	no_light_control = FALSE
	base_turf = /turf/space
	area_flags = AREA_FLAG_RAD_SHIELDED
	ambience = AMBIENCE_ENGINEERING

/area/sol_destroyer/exterior
	name = "Solarian Navy Destroyer - Exterior"
	requires_power = FALSE
	icon_state = "exterior"
	needs_starlight = TRUE
	has_gravity = FALSE

/area/sol_destroyer/hangar
	name = "Solarian Navy Destroyer - Hangar Bay"
	icon_state = "hangar"
	ambience = AMBIENCE_HANGAR

/area/sol_destroyer/central_lift
	name = "Solarian Navy Destroyer - Central Lift"
	icon_state = "turbolift"

// Lift area
/area/turbolift/sol_destroyer/sol_destroyer_lift
	name = "Solarian Navy Destroyer - Lift"
	station_area = FALSE

// Shuttle areas
/area/shuttle/sol_destroyer/transport
	name = "Solarian Navy Destroyer - Transport Shuttle"
	requires_power = TRUE

/area/shuttle/sol_destroyer/fighter
	name = "Solarian Navy Destroyer - Fighter"
	requires_power = TRUE

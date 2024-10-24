//Ship Areas
/area/himean_corvette
	name = "Himean Planetary Navy Corvette"
	icon_state = "red"
	requires_power = TRUE
	dynamic_lighting = TRUE
	no_light_control = FALSE
	base_turf = /turf/space
	area_flags = AREA_FLAG_RAD_SHIELDED
	ambience = AMBIENCE_ENGINEERING

x

/area/himean_corvette/exterior
	name = "Himean Planetary Navy Corvette - Exterior"
	requires_power = FALSE
	icon_state = "exterior"
	has_gravity = FALSE

//Lift Area
/area/turbolift/himean_corvette/himean_lift
	name = "Himean Planetary Navy Lift"
	station_area = FALSE

//Shuttle Area
/area/shuttle/himean_corvette
	name = "Himean Planetary Navy Corvette"
	requires_power = TRUE

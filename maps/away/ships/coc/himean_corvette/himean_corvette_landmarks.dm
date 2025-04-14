// Lift
/datum/shuttle/autodock/multi/lift/himean_corvette
	name = "Himean Corvette Lift"
	current_location = "nav_himean_corvette_lift_first_deck"
	shuttle_area = /area/turbolift/himean_corvette/himean_corvette_lift
	destination_tags = list(
		"nav_himean_corvette_lift_first_deck",
		"nav_himean_corvette_lift_second_deck",
		)

/obj/effect/shuttle_landmark/lift/himean_corvette_first_deck
	name = "Republican Fleet Corvette - First Deck"
	landmark_tag = "nav_himean_corvette_lift_first_deck"
	base_area = /area/himean_corvette/hangar
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/lift/himean_corvette_second_deck
	name = "Republican Fleet Corvette - Second Deck"
	landmark_tag = "nav_himean_corvette_lift_second_deck"
	base_area = /area/himean_corvette/central_lift
	base_turf = /turf/simulated/open

/obj/machinery/computer/shuttle_control/multi/lift/himean_corvette
	shuttle_tag = "Himean Corvette Lift"

// Shuttle Landmarks
/obj/effect/shuttle_landmark/himean_corvette
	base_turf = /turf/space
	base_area = /area/space

/obj/effect/shuttle_landmark/himean_corvette/nav1
	name = "Fore"
	landmark_tag = "himean_corvette_nav1"

/obj/effect/shuttle_landmark/himean_corvette/nav2
	name = "Aft"
	landmark_tag = "himean_corvette_nav2"

/obj/effect/shuttle_landmark/himean_corvette/nav3
	name = "Port"
	landmark_tag = "himean_corvette_nav3"

/obj/effect/shuttle_landmark/himean_corvette/nav4
	name = "Starboard"
	landmark_tag = "himean_corvette_nav4"

/obj/effect/shuttle_landmark/himean_corvette/dock_port
	name = "Port Docking Port"
	docking_controller = "airlock_himean_corvette_port_dock"
	landmark_tag = "himean_corvette_port_dock"

/obj/effect/shuttle_landmark/himean_corvette/dock_starboard
	name = "Starboard Docking Port"
	docking_controller = "airlock_himean_corvette_starboard_dock"
	landmark_tag = "himean_corvette_starboard_dock"

/obj/effect/shuttle_landmark/himean_corvette/dock_aft
	name = "Aft Docking Port"
	docking_controller = "airlock_himean_corvette_aft_dock"
	landmark_tag = "himean_corvette_aft_dock"

/obj/effect/shuttle_landmark/himean_corvette/dock_fore
	name = "Fore Docking Port"
	docking_controller = "airlock_himean_corvette_fore_dock"
	landmark_tag = "himean_corvette_fore_dock"

// Non-docking airlock markers, for the small airlocks on deck two.
/obj/effect/map_effect/marker/airlock/himean_corvette/starboard_small_aft
	name = "Starboard Aft, Small"
	master_tag = "airlock_himean_corvette_starboard_aft"

/obj/effect/map_effect/marker/airlock/himean_corvette/port_small_aft
	name = "Port Aft, Small"
	master_tag = "airlock_himean_corvette_port_aft"

/obj/effect/map_effect/marker/airlock/himean_corvette/starboard_small_fore
	name = "Starboard Fore, Small"
	master_tag = "airlock_himean_corvette_starboard_fore"

/obj/effect/map_effect/marker/airlock/himean_corvette/port_small_fore
	name = "Port Fore, Small"
	master_tag = "airlock_himean_corvette_port_fore"

// Docking airlock markers, for deck one.
/obj/effect/map_effect/marker/airlock/docking/himean_corvette/aft_dock
	name = "Aft"
	master_tag = "airlock_himean_corvette_aft_dock"
	landmark_tag = "himean_corvette_aft_dock"

/obj/effect/map_effect/marker/airlock/docking/himean_corvette/fore_dock
	name = "Fore"
	master_tag = "airlock_himean_corvette_fore_dock"
	landmark_tag = "himean_corvette_fore_dock"

/obj/effect/map_effect/marker/airlock/docking/himean_corvette/port_dock
	name = "Port"
	master_tag = "airlock_himean_corvette_port_dock"
	landmark_tag = "himean_corvette_port_dock"

/obj/effect/map_effect/marker/airlock/docking/himean_corvette/starboard_dock
	name = "Starboard"
	master_tag = "airlock_himean_corvette_starboard_dock"
	landmark_tag = "himean_corvette_starboard_dock"

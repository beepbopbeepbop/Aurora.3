// Lift
/datum/shuttle/autodock/multi/lift/sol_destroyer
	name = "sol_destroyer Lift"
	current_location = "nav_sol_destroyer_lift_first_deck"
	shuttle_area = /area/turbolift/sol_destroyer/sol_destroyer_lift
	destination_tags = list(
		"nav_sol_destroyer_lift_first_deck",
		"nav_sol_destroyer_lift_second_deck",
		)

/obj/effect/shuttle_landmark/lift/sol_destroyer_first_deck
	name = "Republican Fleet Corvette - First Deck"
	landmark_tag = "nav_sol_destroyer_lift_first_deck"
	base_area = /area/sol_destroyer/hangar
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/lift/sol_destroyer_second_deck
	name = "Republican Fleet Corvette - Second Deck"
	landmark_tag = "nav_sol_destroyer_lift_second_deck"
	base_area = /area/sol_destroyer/central_lift
	base_turf = /turf/simulated/open

/obj/structure/machinery/computer/shuttle_control/multi/lift/sol_destroyer
	shuttle_tag = "Sol Destroyer Lift"
	req_access = list(ACCESS_SOL_SHIPS)
// --------

// Space landmarks
/obj/effect/shuttle_landmark/sol_destroyer/nav1
	name = "Fore"
	landmark_tag = "sol_destroyer_nav1"

/obj/effect/shuttle_landmark/sol_destroyer/nav2
	name = "Aft"
	landmark_tag = "sol_destroyer_nav2"

/obj/effect/shuttle_landmark/sol_destroyer/nav3
	name = "Port"
	landmark_tag = "sol_destroyer_nav3"

/obj/effect/shuttle_landmark/sol_destroyer/nav4
	name = "Starboard"
	landmark_tag = "sol_destroyer_nav4"
// --------

// Airlocks
/obj/effect/map_effect/marker/airlock/external/sol_destroyer
	name = "Solarian Destroyer Airlocks - PARENT TYPE"
	req_access = list(ACCESS_SOL_SHIPS)
	req_one_access = null
// --------

// Aft airlocks
/obj/effect/map_effect/marker/airlock/external/sol_destroyer/aft_starboard
	name = "Maintenance Hatch"
	master_tag = "sol_destroyer_aft_starboard"

/obj/effect/map_effect/marker/airlock/external/sol_destroyer/aft_portside
	name = "Maintenance Hatch"
	master_tag = "sol_destroyer_aft_port"
// --------

// Mid airlocks
/obj/effect/map_effect/marker/airlock/external/sol_destroyer/mid_starboard
	name = "Maintenance Hatch"
	master_tag = "sol_destroyer_mid_starboard"

/obj/effect/map_effect/marker/airlock/external/sol_destroyer/mid_portside
	name = "Maintenance Hatch"
	master_tag = "sol_destroyer_mid_port"
// --------

// Fore airlocks
/obj/effect/map_effect/marker/airlock/external/sol_destroyer/fore_starboard
	name = "Maintenance Hatch"
	master_tag = "sol_destroyer_fore_starboard"

/obj/effect/map_effect/marker/airlock/external/sol_destroyer/fore_portside
	name = "Maintenance Hatch"
	master_tag = "sol_destroyer_fore_port"
// --------

// Docking ports
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer
	name = "Solarian Destroyer Docking Ports - PARENT TYPE"
	req_access = list(ACCESS_SOL_SHIPS)
	req_one_access = null
// --------

// Aft dock
/obj/effect/shuttle_landmark/sol_destroyer/dock_aft
	name = "Aft Dock"
	landmark_tag = "sol_destroyer_aft_dock"
// --------

// Fore dock
/obj/effect/shuttle_landmark/sol_destroyer/dock_fore
	name = "Fore Dock"
	landmark_tag = "sol_destroyer_destroyer_fore_dock"
// --------

// Port dock
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer/port_dock
	name = "Port Docking Hatch"
	master_tag = "airlock_sol_destroyer_port_dock"
	landmark_tag = "sol_destroyer_port_dock"

/obj/effect/shuttle_landmark/sol_destroyer/dock_port
	name = "Port Docking Hatch"
	docking_controller = "airlock_sol_destroyer_port_dock"
	landmark_tag = "sol_destroyer_port_dock"
// --------

// Starboard dock
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer/starboard_dock
	name = "Starboard Docking Hatch"
	master_tag = "airlock_sol_destroyer_starboard_dock"
	landmark_tag = "sol_destroyer_starboard_dock"

/obj/effect/shuttle_landmark/sol_destroyer/dock_starboard
	name = "Starboard Docking Hatch"
	docking_controller = "airlock_sol_destroyer_starboard_dock"
	landmark_tag = "sol_destroyer_starboard_dock"
// --------

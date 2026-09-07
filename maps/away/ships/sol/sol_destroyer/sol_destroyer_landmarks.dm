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

// Gunnery airlock
/obj/effect/map_effect/marker/airlock/external/sol_destroyer/gunnery
	name = "Maintenance Hatch"
	master_tag = "sol_destroyer_gunnery"
// --------

// Docking ports
// Aft dock
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer/aft_dock
	name = "Aft Dock"
	master_tag = "airlock_sol_destroyer_aft_dock"
	landmark_tag = "sol_destroyer_aft_dock"

/obj/effect/shuttle_landmark/sol_destroyer/dock_aft
	name = "Aft Dock"
	docking_controller = "airlock_sol_destroyer_aft_dock"
	landmark_tag = "sol_destroyer_aft_dock"
// --------

// Fore dock
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer/fore_dock
	name = "Fore Dock"
	master_tag = "airlock_sol_destroyer_fore_dock"
	landmark_tag = "sol_destroyer_fore_dock"

/obj/effect/shuttle_landmark/sol_destroyer/dock_fore
	name = "Fore Dock"
	docking_controller = "airlock_sol_destroyer_fore_dock"
	landmark_tag = "sol_destroyer_corvette_fore_dock"
// --------

// Port dock
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer/port_dock
	name = "Port Dock"
	master_tag = "airlock_sol_destroyer_port_dock"
	landmark_tag = "sol_destroyer_port_dock"

/obj/effect/shuttle_landmark/sol_destroyer/dock_port
	name = "Port Dock"
	docking_controller = "airlock_sol_destroyer_port_dock"
	landmark_tag = "sol_destroyer_port_dock"
// --------

// Starboard dock
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer/starboard_dock
	name = "Starboard Dock"
	master_tag = "airlock_sol_destroyer_starboard_dock"
	landmark_tag = "sol_destroyer_starboard_dock"

/obj/effect/shuttle_landmark/sol_destroyer/dock_starboard
	name = "Starboard Dock"
	docking_controller = "airlock_sol_destroyer_starboard_dock"
	landmark_tag = "sol_destroyer_starboard_dock"
// --------

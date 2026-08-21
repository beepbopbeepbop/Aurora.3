/obj/effect/overmap/visitable/ship/landable/nralakk_shuttle
	name = "Nralakk Federal Security Vessel Shuttle"
	class = "NFSVS"
	desc = "x."
	shuttle = "NFSV Shuttle"
	icon_state = "shuttle"
	moving_state = "shuttle_moving"
	designer = "Stellar Corporate Conglomerate, Commonwealth of Valkyrie"
	sizeclass = "Bluebell-class passenger craft"
	shiptype = "Short-distance passenger transportation"
	colors = list("#27e4ee", "#4febbf")

	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	vessel_mass = 3000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_TINY

/obj/effect/overmap/visitable/ship/landable/nralakk_shuttle/New()
	designation = "[pick("glorsh three", "swimstars fan")]"
	..()

/obj/structure/machinery/computer/shuttle_control/explore/terminal/nralakk_shuttle
	name = "shuttle control console"
	shuttle_tag = "NFSV Shuttle"
	req_access = list(ACCESS_NRALAKK)
// --------

// Controls docking behaviour
/datum/shuttle/autodock/overmap/nralakk_shuttle
	name = "NFSV Shuttle"
	move_time = 20
	shuttle_area = list(/area/shuttle/nralakk_monitor)
	current_location = "nav_hangar_nralakk"
	landmark_transition = "nav_transit_nfsv_shuttle"
	dock_target = "nralakk_shuttle"
	range = 1
	fuel_consumption = 2
	logging_home_tag = "nav_hangar_nralakk"
	defer_initialisation = TRUE
// --------

// Hangar marker
/obj/effect/shuttle_landmark/nralakk_shuttle/hangar
	name = "Shuttle Port"
	landmark_tag = "nav_hangar_nralakk"
	docking_controller = "nralakk_shuttle_dock"
	base_area = /area/space
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE
// --------

// Transit landmark
/obj/effect/shuttle_landmark/nralakk_shuttle/transit
	name = "In transit"
	landmark_tag = "nav_transit_nralakk_shuttle"
	base_turf = /turf/space/transit/north
// --------

// Shuttle docking port
/obj/effect/map_effect/marker/airlock/docking/nralakk_monitor/shuttle_port
	name = "Shuttle Dock"
	landmark_tag = "nav_hangar_nralakk"
	master_tag = "nralakk_shuttle_dock"
// --------

// Shuttle airlock
/obj/effect/map_effect/marker/airlock/shuttle/nralakk_shuttle
	name = "nralakk_shuttle"
	master_tag = "nralakk_shuttle"
	shuttle_tag = "NFSV Shuttle"
	cycle_to_external_air = TRUE
// --------

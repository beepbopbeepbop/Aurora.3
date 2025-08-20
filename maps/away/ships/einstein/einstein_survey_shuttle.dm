// Shuttle
/obj/effect/overmap/visitable/ship/landable/einstein_survey_shuttle
	name = "Einstein Survey Shuttle"
	class = "EEV" // Einstein Engines Vessel
	designation = "x"
	desc = "x"
	designer = "Einstein Engines"
	shuttle = "Einstein Survey Shuttle"
	icon_state = "shuttle"
	moving_state = "shuttle_moving"
	colors = list("#B9BDC4")
	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	vessel_mass = 3000 //very inefficient pod
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_TINY

/obj/machinery/computer/shuttle_control/explore/terminal/einstein_survey_shuttle
	name = "shuttle control console"
	shuttle_tag = "Einstein Survey Shuttle"
	req_access = list(ACCESS_EINSTEIN)
// --------

// Controls docking behaviour
/datum/shuttle/autodock/overmap/einstein_survey_shuttle
	name = "Einstein Survey Shuttle"
	move_time = 20
	shuttle_area = list(/area/shuttle/einstein_survey_shuttle)
	current_location = "nav_hangar_einstein_survey_ship"
	landmark_transition = "nav_transit_einstein_survey_shuttle"
	dock_target = "einstein_survey_shuttle"
	range = 1
	fuel_consumption = 2
	logging_home_tag = "nav_hangar_einstein_survey_ship"
	defer_initialisation = TRUE
// --------

// Hangar marker
/obj/effect/shuttle_landmark/einstein_survey_shuttle/hangar
	name = "Shuttle Port"
	landmark_tag = "nav_hangar_einstein_survey_ship"
	docking_controller = "einstein_survey_shuttle_dock"
	base_area = /area/space
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE
// --------

// Transit landmark
/obj/effect/shuttle_landmark/einstein_survey_shuttle/transit
	name = "In transit"
	landmark_tag = "nav_transit_einstein_survey_shuttle"
	base_turf = /turf/space/transit/north
// --------

// Shuttle docking port
/obj/effect/map_effect/marker/airlock/docking/einstein_survey_shuttle/shuttle_port
	name = "Shuttle Dock"
	landmark_tag = "nav_hangar_einstein_survey_ship"
	master_tag = "einstein_survey_shuttle_dock"
// --------

// Shuttle airlock
/obj/effect/map_effect/marker/airlock/shuttle/einstein_survey_shuttle
	name = "einstein_survey_shuttle"
	master_tag = "einstein_survey_shuttle"
	shuttle_tag = "Einstein Survey Shuttle"
	cycle_to_external_air = TRUE
// --------

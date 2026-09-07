//
//	SOL DESTROYER TRANSPORT
//
/obj/effect/overmap/visitable/ship/landable/sol_destroyer_transport
	name = "Sol Destroyer Transport Shuttle"
	class = "SAMV"
	desc = "A small and relatively unassuming shuttle used by most Solarian ships for short-range transport between vessels or \
	stations, the Cutter has long been produced by Hephaestus for use by the Solarian Navy. While more armored than most shuttles \
	it is generally advisable to not take the unarmed Cutter into a fight. With only a small sublight engine and limited fuel \
	reserves the Cutter should never be far from the larger vessel it is assigned to."
	shuttle = "Sol Destroyer Transport Shuttle"
	icon_state = "pod"
	moving_state = "pod_moving"
	designer = "Solarian State Shipbuilding Corporation, Sovereign Solarian Federation of Triton"
	sizeclass = "Military transporter shuttlecraft"
	shiptype = "Transportation and combat boarding"
	colors = list("#5a644e", "#6a7e53")
	max_speed = 1/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	vessel_mass = 1500
	fore_dir = EAST
	vessel_size = SHIP_SIZE_TINY

/obj/effect/overmap/visitable/ship/landable/sol_destroyer_transport/New()
	designation = "[pick("Ours Now", "Better Use", "Watch It Closer", "Repurposed", "Liberated", "People's Mule", "You're Welcome")]"
	..()

/obj/structure/machinery/computer/shuttle_control/explore/terminal/sol_destroyer_transport
	name = "shuttle control console"
	shuttle_tag = "Sol Destroyer Transport Shuttle"
	req_access = list(ACCESS_SOL_SHIPS)
// --------

// Controls docking behaviour
/datum/shuttle/autodock/overmap/sol_destroyer_transport
	name = "Sol Destroyer Transport Shuttle"
	move_time = 20
	shuttle_area = list(/area/shuttle/sol_destroyer/transport)
	current_location = "nav_docking_port_sol_destroyer_transport"
	landmark_transition = "nav_transit_sol_destroyer_transport"
	dock_target = "sol_destroyer_transport"
	range = 1
	fuel_consumption = 2
	logging_home_tag = "nav_docking_port_sol_destroyer_transport"
	defer_initialisation = TRUE
// --------

// Transport docking port marker
/obj/effect/shuttle_landmark/sol_destroyer_transport/docking_port
	name = "Transport Shuttle Docking Port"
	landmark_tag = "nav_docking_port_sol_destroyer_transport"
	docking_controller = "sol_destroyer_transport_dock"
	base_area = /area/space
	base_turf = /turf/space
	movable_flags = MOVABLE_FLAG_EFFECTMOVE
// --------

// Transit landmark
/obj/effect/shuttle_landmark/sol_destroyer_transport/transit
	name = "In transit"
	landmark_tag = "nav_transit_sol_destroyer_transport"
	base_turf = /turf/space/transit/north
// --------

// Transport docking port
/obj/effect/map_effect/marker/airlock/docking/sol_destroyer/transport_docking_port
	name = "Transport Shuttle Docking Port"
	landmark_tag = "nav_docking_port_sol_destroyer_transport"
	master_tag = "sol_destroyer_transport_dock"
// --------

// Transport airlock
/obj/effect/map_effect/marker/airlock/shuttle/sol_destroyer_transport
	name = "sol_destroyer_transport"
	master_tag = "sol_destroyer_transport"
	shuttle_tag = "Sol Destroyer Transport Shuttle"
	cycle_to_external_air = TRUE
// --------

//
//	SOL DESTROYER FIGHTER
//
/obj/effect/overmap/visitable/ship/landable/sol_destroyer_fighter
	name = "SAN Space Superiority Fighter"
	class = "SAMV"
	desc = "Norikura."
	shuttle = "SAN Space Superiority Fighter"
	icon_state = "canary"
	moving_state = "canary_moving"
	designer = "Solarian State Shipbuilding Corporation, Sovereign Solarian Federation of Triton"
	sizeclass = "F-39N Norikura"
	shiptype = "Naval space superiority fighter"
	colors = list("#5a644e", "#6a7e53")
	max_speed = 1/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	vessel_mass = 800
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_TINY

/obj/effect/overmap/visitable/ship/landable/sol_destroyer_fighter/New()
	var/carrier_hull = pick(/obj/effect/overmap/visitable/ship/sol_destroyer::hull)
	var/shuttle_class = "SSF"
	var/shuttle_number = "[rand(1, 20)]"
	designation = "[shuttle_class]-[shuttle_number] [carrier_hull]"
	..()

/obj/structure/machinery/computer/shuttle_control/explore/terminal/sol_destroyer_fighter
	name = "shuttle control console"
	shuttle_tag = "Sol Destroyer Fighter"
	req_access = list(ACCESS_SOL_SHIPS)
// --------

// Controls docking behaviour
/datum/shuttle/autodock/overmap/sol_destroyer_fighter
	name = "Sol Destroyer Fighter"
	move_time = 20
	shuttle_area = list(/area/shuttle/sol_destroyer/fighter)
	current_location = "nav_hangar_sol_destroyer"
	landmark_transition = "nav_transit_sol_destroyer_fighter"
	dock_target = "sol_destroyer_fighter"
	range = 1
	fuel_consumption = 2
	logging_home_tag = "nav_hangar_sol_destroyer"
	defer_initialisation = TRUE
// --------

// Hangar marker
/obj/effect/shuttle_landmark/sol_destroyer_fighter/hangar
	name = "Fighter Port"
	landmark_tag = "nav_hangar_sol_destroyer"
	docking_controller = "sol_destroyer_fighter_dock"
	base_area = /area/sol_destroyer/hangar
	base_turf = /turf/simulated/floor/plating
	movable_flags = MOVABLE_FLAG_EFFECTMOVE
// --------

// Transit landmark
/obj/effect/shuttle_landmark/sol_destroyer_fighter/transit
	name = "In transit"
	landmark_tag = "nav_transit_sol_destroyer_fighter"
	base_turf = /turf/space/transit/north
// --------

// Fighter docking port
/obj/effect/map_effect/marker/airlock/docking/splf_raider/shuttle_port
	name = "Fighter Dock"
	landmark_tag = "nav_hangar_sol_destroyer"
	master_tag = "sol_destroyer_fighter_dock"
// --------

// Fighter airlock
/obj/effect/map_effect/marker/airlock/shuttle/sol_destroyer_fighter
	name = "sol_destroyer_fighter"
	master_tag = "sol_destroyer_fighter"
	shuttle_tag = "Sol Destroyer Fighter"
	cycle_to_external_air = TRUE
// --------

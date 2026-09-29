/datum/map_template/ruin/exoplanet/pra_base
	name = "PRA Grand People's Army Strategic Rocket Force, Base 611-5748"
	id = "pra_base"
	description = "A military outpost manned by the Grand People's Army."

	spawn_weight = 1.5
	spawn_cost = 2
	template_flags = TEMPLATE_FLAG_NO_RUINS|TEMPLATE_FLAG_RUIN_STARTS_DISALLOWED
	sectors = list(SECTOR_SRANDMARR)
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/paf_transport)

// Not entirely sure if this will work
	traits = list(
		//Z1
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = TRUE, ZTRAIT_DOWN = FALSE),
		//Z2
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = FALSE, ZTRAIT_DOWN = TRUE),
	)

	prefix = "adhomai/"
	suffix = "pra_base.dmm"

	unit_test_groups = list(1)

// Transport craft
/obj/effect/overmap/visitable/ship/landable/paf_transport
	name = "PAF Transport Shuttle"
	class = "PRAMV"
	desc = "A small and relatively unassuming shuttle used by most Solarian ships for short-range transport between vessels or \
	stations, the Cutter has long been produced by Hephaestus for use by the Solarian Navy. While more armored than most shuttles \
	it is generally advisable to not take the unarmed Cutter into a fight. With only a small sublight engine and limited fuel \
	reserves the Cutter should never be far from the larger vessel it is assigned to."
	shuttle = "PAF Transport Shuttle"
	icon_state = "pod"
	moving_state = "pod_moving"
	designer = "Ardiye Qaratajir Junhaliir'kra, People's Republic of Adhomai"
	sizeclass = "MC-3 Mirr'va" //(M)ulti-purpose (U)tility shuttle 3 'Mirra'va'
	shiptype = "Naval transport and utility shuttle"
	colors = list("#5a644e", "#6a7e53")
	max_speed = 1/(2 SECONDS)
	burn_delay = 0.5 SECONDS
	vessel_mass = 1500
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_TINY

/obj/effect/overmap/visitable/ship/landable/paf_transport/New()
	var/shuttle_squadron = pick("", "", "", pick("VNTA-81")) // (V)ertical take-off and landing, (N)aval (T)ransport expeditionary squadron, 81
	var/shuttle_number = pick("", "", "", pick("[rand(100, 900)]"))
	designation = "Mirr'va ([shuttle_squadron]-[shuttle_number])"
	..()

// --------

// Controls docking behaviour
/datum/shuttle/autodock/overmap/paf_transport
	name = "PAF Transport Shuttle"
	move_time = 20
	shuttle_area = list(/area/shuttle/paf_transport)
	current_location = "nav_pra_base_landing_pad_"
	landmark_transition = "nav_paf_transport_transit"
	dock_target = "paf_transport"
	range = 1
	fuel_consumption = 2
	defer_initialisation = TRUE

/obj/structure/machinery/computer/shuttle_control/explore/terminal/paf_transport
	name = "shuttle control console"
	shuttle_tag = "PAF Transport Shuttle"
	req_access = list(/datum/access/pra::id)
// --------

// LZ docking controller landmark
/obj/effect/shuttle_landmark/paf_transport/landing_pad
	name = "PAF Transport Landing Pad"
	landmark_tag = "nav_pra_base_landing_pad"
	docking_controller = "airlock_paf_transport_shuttle_docking"
	base_area = /area/pra_base/outside
	base_turf = /turf/simulated/floor/exoplanet/asphalt
	movable_flags = MOVABLE_FLAG_EFFECTMOVE
// --------

// LZ docking controller area
/obj/effect/map_effect/marker/airlock/docking/pra_base/landing_pad
	name = "GPASRF Base 611-5748, Outdoors - Landing Pad"
	landmark_tag = "nav_pra_base_landing_pad"
	master_tag = "airlock_paf_transport_shuttle_docking"
// --------

// Shuttle airlocks
/obj/effect/map_effect/marker/airlock/shuttle/paf_transport
	name = "PAF Transport Shuttle - Docking Airlock"
	master_tag = "airlock_paf_transport_shuttle_docking"
	shuttle_tag = "PAF Transport Shuttle"
	cycle_to_external_air = TRUE

/obj/effect/map_effect/marker/airlock/external/paf_transport/port
	name = "PAF Transport Shuttle - Port Airlock"
	master_tag = "airlock_paf_transport_port"

/obj/effect/map_effect/marker/airlock/external/paf_transport/starboard
	name = "PAF Transport Shuttle - Starboard Airlock"
	master_tag = "airlock_paf_transport_starboard"
// --------

// Transit landmark
/obj/effect/shuttle_landmark/paf_transport/transit
	name = "In transit"
	landmark_tag = "nav_paf_transport_transit"
	base_turf = /turf/space/transit/north
// --------

/datum/map_template/ruin/away_site/himean_corvette
	name = "Himean Planetary Navy Corvette"
	description = "A patrol vessel of the United Syndicates of Himeo's Planetary Navy."

	prefix = "ships/coc/himean_corvette/"
	suffix = "himean_corvette.dmm"

		traits = list(
		// Deck one
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = TRUE, ZTRAIT_DOWN = FALSE),
		// Deck two
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = FALSE, ZTRAIT_DOWN = TRUE),
	)

	sectors = list()
	spawn_weight = 1
	spawn_cost = 1
	id = "himean_corvette"
	shuttles_to_initialize = list(/datum/shuttle/autodock/overmap/himean_shuttle)

	unit_test_groups = list(3)

/singleton/submap_archetype/himean_corvette
	map = "Himean Planetary Navy Corvette"
	descriptor = "A patrol vessel of the United Syndicates of Himeo's Planetary Navy."

obj/effect/overmap/visitable/ship/himean_corvette
	name = "Himean Planetary Navy Corvette"
	class = "N/a"
	desc = "N/a"
	icon_state = "N/a"
	moving_state = "N/a"
	colors = list("N/a")
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL
	scanimage = "N/a"
	designer = "Himean People's Unified Armed Forces, Free Consortium of Defense and Aerospace Manufacturers"
	volume = "N/a"
	drive = "Mid-range Warp Acceleration FTL Drive"
	weapons = "N/a"
	sizeclass = "N/a"
	shiptype = "N/a"
	initial_restricted_waypoints = list(
		"Himean Planetary Navy Gunboat" = list("N/a")
	)

	initial_generic_waypoints = list(
		"N/a"
	)

	invisible_until_ghostrole_spawn = TRUE

/obj/effect/overmap/visitable/ship/himean_corvette/New()
	designation = "[pick("Rautakaivos Kaupunki", "Dorshafen", "Inverkeithing", "Uusi Viipuri", "Horner Station")]"
	..()

obj/effect/overmap/visitable/ship/landable/himean_shuttle
	name = "Himean Planetary Navy Gunboat"
	class = "N/a"
	desc = "N/a"
	shuttle = "Himean Planetary Navy Gunboat"
	icon_state = "shuttle"
	moving_state = "shuttle_moving"
	designer = "Himean People's Unified Armed Forces, Free Consortium of Defense and Aerospace Manufacturers"
	weapons = "Fore ballistic weapon mount."
	sizeclass = "N/a"
	colors = list("N/a")
	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	vessel_mass = 2500 // Same as the SCCV Canary. Lower than usual to compensate for only having two thrusters.
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_TINY

/obj/effect/overmap/visitable/ship/landable/himean_shuttle/New()
	designation = "[pick("N/a")]"
	..()

/obj/machinery/computer/shuttle_control/explore/terminal/himean_shuttle
	name = "shuttle control console"
	shuttle_tag = "Himean Planetary Navy Gunboat"
	req_access = list(ACCESS_COALITION_NAVY)

/datum/shuttle/autodock/overmap/himean_shuttle
	name = "Himean Planetary Navy Gunboat"
	move_time = 20
	shuttle_area = list(/area/shuttle/tcaf)
	current_location = "N/a"
	landmark_transition = "nav_transit_himean_shuttle"
	dock_target = "airlock_himean_shuttle"
	range = 1
	fuel_consumption = 2
	logging_home_tag = "N/a"
	defer_initialisation = TRUE

/obj/effect/shuttle_landmark/tcaf_shuttle/hangar
	name = "Gunship Hangar"
	landmark_tag = "nav_hangar_tcaf"
	docking_controller = "tcaf_shuttle_dock"
	base_area = /area/tcaf_corvette/hangar
	base_turf = /turf/simulated/floor/plating
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/shuttle_landmark/tcaf_shuttle/transit
	name = "In transit"
	landmark_tag = "nav_transit_tcaf_shuttle"
	base_turf = /turf/space/transit/north

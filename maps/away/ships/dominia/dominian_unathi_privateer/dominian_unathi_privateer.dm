/datum/map_template/ruin/away_site/dominian_unathi
	name = "Kazhkz Privateer Ship"
	description = "Dominian Unathi pirates"

	prefix = "ships/dominia/dominian_unathi_privateer/"
	suffix = "dominian_unathi_privateer.dmm"

	sectors = list(SECTOR_BADLANDS, SECTOR_WEEPING_STARS)
	spawn_weight = 1
	ship_cost = 1
	id = "dominian_unathi"
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/dominian_unathi_shuttle)
	unit_test_groups = list(2)

/singleton/submap_archetype/dominian_unathi
	map = "Kazhkz Privateer Ship"
	descriptor = "Dominian Unathi pirates"

/obj/effect/overmap/visitable/ship/dominian_unathi
	name = "Kazhkz Privateer Ship"
	class = "ICV"
	desc = "A modified Dragoon-class corvette - the predecessor to the Empire of Dominia's modern Lammergier-class. Though these once served a similar role in the early days of the Imperial Fleet, they have since been entirely decomissioned in favor of the Lammergier. This one has received some upgrades, such as a large ram mounted on the prow. Additionally, its IFF marks it as a civilian vessel, of no specific affiliation."
	icon_state = "dragoon"
	moving_state = "dragoon_moving"
	colors = list("#e67f09", "#fcf9f5")
	designer = "Imperial Engineering & Shipbuilding Corporation"
	volume = "54 meters length, 25 meters beam/width, 17 meters vertical height"
	sizeclass = "Modified Dragoon-class corvette"
	shiptype = "Fleet escort, long-distance patrol, and scouting action"
	drive = "Low-Speed Warp Acceleration FTL Drive"
	weapons = "Port wingtip-mounted extruding medium-caliber ballistic armament, aft boarding pod dock"
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL
	invisible_until_ghostrole_spawn = TRUE
	initial_restricted_waypoints = list(
		"Kazhkz Boarding Pod" = list("nav_hangar_kazhkz")
	)
	initial_generic_waypoints = list(
		"nav_dominian_unathi_1",
		"nav_dominian_unathi_2",
		"nav_dominian_unathi_3",
		"nav_dominian_unathi_4"
	)

/obj/effect/overmap/visitable/ship/dominian_unathi/New()
	designation = "[pick("Old Grudges", "Redhorn", "Seryo's Revenge", "Spiritbound", "Hammer of the Goddess", "Come Try Me", "Beating Wardrum", "Grudgetaker", "Our Lady's Talon", "Hunter", "Bloodied Claws", "Steelscale")]"
	..()

/obj/effect/shuttle_landmark/dominian_unathi
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/dominian_unathi/nav1
	name = "Fore"
	landmark_tag = "nav_dominian_unathi_1"

/obj/effect/shuttle_landmark/dominian_unathi/nav2
	name = "Starboard"
	landmark_tag = "nav_dominian_unathi_2"

/obj/effect/shuttle_landmark/dominian_unathi/nav3
	name = "Port"
	landmark_tag = "nav_dominian_unathi_3"

/obj/effect/shuttle_landmark/dominian_unathi/nav4
	name = "Aft"
	landmark_tag = "nav_dominian_unathi_4"

/obj/effect/shuttle_landmark/dominian_unathi/dock
	name = "Port Docking Bay"
	landmark_tag = "nav_dominian_unathi_dock"
	docking_controller = "airlock_dominian_unathi_dock"

//Lift
/datum/shuttle/autodock/multi/lift/dominian_unathi
	name = "Kazhkz Privateer Cargo Lift"
	current_location = "nav_dominian_unathi_cargo_lift_first_deck"
	shuttle_area = /area/turbolift/dominian_unathi/dominian_unathi_lift
	destination_tags = list(
		"nav_dominian_unathi_cargo_lift_first_deck",
		"nav_dominian_unathi_cargo_lift_second_deck",
		)

/obj/effect/shuttle_landmark/lift/dominian_unathi_first_deck
	name = "Kazhkz Privateer - First Deck"
	landmark_tag = "nav_dominian_unathi_cargo_lift_first_deck"
	base_area = /area/ship/dominian_unathi/first_deck_cargo_lift
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/lift/dominian_unathi_second_deck
	name = "Kazhkz Privateer - Second Deck"
	landmark_tag = "nav_dominian_unathi_cargo_lift_second_deck"
	base_area = /area/ship/dominian_unathi/second_deck_cargo_lift
	base_turf = /turf/simulated/open

/obj/machinery/computer/shuttle_control/multi/lift/dominian_unathi
	shuttle_tag = "Kazhkz Privateer Cargo Lift"

//Shuttle
/obj/effect/overmap/visitable/ship/landable/dominian_unathi_shuttle
	name = "Kazhkz Boarding Pod"
	class = "ICV"
	designation = "Dagger"
	desc = "The Lanying-class is often seen in the ranks of the Imperial Fleet - a void craft, capable of carrying a boarding party of up to five armsmen, and equipped with a rotary cannon. This one's transponder does not mark it as an Imperial vessel, however."
	shuttle = "Kazhkz Boarding Pod"
	icon_state = "shuttle"
	moving_state = "shuttle_moving"
	colors = list("#e67f09", "#fcf9f5")
	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	vessel_mass = 3000 //very inefficient pod
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_TINY

/obj/machinery/computer/shuttle_control/explore/dominian_unathi_shuttle
	name = "shuttle control console"
	shuttle_tag = "Kazhkz Boarding Pod"
	req_access = list(ACCESS_IMPERIAL_FLEET_VOIDSMAN_SHIP)

/datum/shuttle/autodock/overmap/dominian_unathi_shuttle
	name = "Kazhkz Boarding Pod"
	move_time = 20
	shuttle_area = list(/area/shuttle/dominian_unathi)
	current_location = "nav_hangar_kazhkz"
	landmark_transition = "nav_transit_kazhkz_boarding_pod"
	dock_target = "airlock_kazhkz_boarding_pod"
	range = 1
	fuel_consumption = 2
	logging_home_tag = "nav_hangar_kazhkz"
	defer_initialisation = TRUE

/obj/effect/shuttle_landmark/dominian_unathi_shuttle/hangar
	name = "Kazhkz Privateer Ship - Boarding Pod Dock"
	landmark_tag = "nav_hangar_kazhkz"
	docking_controller = "kazhkz_boarding_pod_dock"
	base_area = /area/ship/dominian_unathi/hangar
	base_turf = /turf/simulated/floor/plating
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/shuttle_landmark/dominian_unathi_shuttle/transit
	name = "In transit"
	landmark_tag = "nav_transit_kazhkz_boarding_pod"
	base_turf = /turf/space/transit/north

/datum/map_template/ruin/away_site/einstein_survey_ship
	name = "Einstein Survey Ship"
	id = "einstein_survey_ship"
	description = "An Einstein Engines surveying ship."

	prefix = "ships/einstein/"
	suffix = "einstein_survey_ship.dmm"

	ship_cost = 1
	spawn_weight = 1
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/einstein_survey_shuttle)
	spawn_weight_sector_dependent = list()
	sectors = list()
	unit_test_groups = list(3)

/singleton/submap_archetype/einstein_survey_ship
	map = "Einstein Survey Ship"
	descriptor = "."

/obj/effect/overmap/visitable/ship/einstein_survey_ship
	name = "Einstein Survey Ship"
	class = "EEV" // Einstein Engines Vessel
	desc = "."
	icon_state = "hailstorm"
	moving_state = "hailstorm_moving"
	colors = list("#B9BDC4")
	scanimage = "hailstorm.png"
	designer = "."
	volume = "., 11 meters vertical height"
	drive = "Low-Speed Warp Acceleration FTL Drive"
	weapons = "."
	sizeclass = "."
	shiptype = "."
	vessel_mass = 5000
	max_speed = 1/(2 SECONDS)
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL

	initial_restricted_waypoints = list(
		"Einstein Survey Shuttle" = list("nav_hangar_einstein")
	)

	initial_generic_waypoints = list(
		"einstein_survey_ship_nav1",
		"einstein_survey_ship_nav2",
		"einstein_survey_ship_nav3",
		"einstein_survey_ship_nav4",
		"einstein_survey_ship_starboard_dock",
		"einstein_survey_ship_port_dock",
	)

	invisible_until_ghostrole_spawn = TRUE

/obj/effect/overmap/visitable/ship/hailstorm_ship/New()
	designation = "[pick("x")]"
	..()

/obj/effect/overmap/visitable/ship/hailstorm_ship/get_skybox_representation()
	var/image/skybox_image = image('icons/skybox/subcapital_ships.dmi', "hailstorm")
	skybox_image.pixel_x = rand(0,64)
	skybox_image.pixel_y = rand(128,256)
	return skybox_image

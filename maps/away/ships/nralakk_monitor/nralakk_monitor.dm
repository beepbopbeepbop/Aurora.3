/datum/map_template/ruin/away_site/nralakk_monitor
	name = "Nralakk Federal Security Vessel"
	description = "x."

	prefix = "ships/nralakk_monitor/"
	suffix = "nralakk_monitor.dmm"

	sectors = list(
		SECTOR_BADLANDS,
		SECTOR_CRESCENT_EXPANSE_WEST
	)
	spawn_weight = 1
	ship_cost = 1
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/nralakk_shuttle)

	unit_test_groups = list(3)

singleton/submap_archetype/nralakk_monitor
	map = "Nralakk Federal Security Vessel"
	descriptor = "x."

/obj/effect/overmap/visitable/ship/nralakk_monitor
	name = "Nralakk Federal Security Vessel"
	class = "NFSV"
	desc = "x."
	icon_state = "tirakqi"
	moving_state = "tirakqi_moving"
	colors = list("#27e4ee", "#4febbf")
	scanimage = "skrell_freighter.png"
	designer = "Einstein Engines, Hang Tuah's Rest Orbital Shipyards"
	volume = "50 meters length, 36 meters beam/width, 13 meters vertical height"
	weapons = "Heavily modified ballistic gunnery pod starboard, shuttle bay portside"
	sizeclass = "Laksamana-class hauler"
	shiptype = "Remote hauling operations, long-term crew habitation"

	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL

	initial_restricted_waypoints = list(
		"NFSV Shuttle" = list("nav_hangar_nralakk")
	)

	initial_generic_waypoints = list(
		"nralakk_monitor_nav1",
		"nralakk_monitor_nav2",
		"nralakk_monitor_nav3",
		"nralakk_monitor_nav4",
		"nralakk_monitor_starboard_dock",
		"nralakk_monitor_port_dock",
		"nralakk_monitor_aft_dock",
		"nralakk_monitor_fore_dock"
	)

	invisible_until_ghostrole_spawn = TRUE

/obj/effect/overmap/visitable/ship/nralakk_monitor/New()
	designation = "[pick("jrugl number one", "glorsh two")]"
	..()

/obj/effect/overmap/visitable/ship/nralakk_monitor/get_skybox_representation()
	var/image/skybox_image = image('icons/skybox/subcapital_ships.dmi', "skrell_freighter")
	skybox_image.pixel_x = rand(0,64)
	skybox_image.pixel_y = rand(128,256)
	return skybox_image

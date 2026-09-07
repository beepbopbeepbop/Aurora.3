/datum/map_template/ruin/away_site/sol_destroyer

	name = "Sol Destroyer Auxiliary Vessel"
	description = "A repurposed hauler operated by the Solarian People's Liberation Fleet, sent to raid corporate holdings in the CRZ."

	prefix = "ships/sol/sol_splf/"
	suffix = "sol_destroyer.dmm"

	sectors = list(SECTOR_CORP_ZONE)
	spawn_weight = 1
	ship_cost = 1
	id = "sol_destroyer"
	shuttles_to_initialise = list(
		/datum/shuttle/autodock/overmap/sol_destroyer_transport,
		/datum/shuttle/autodock/overmap/sol_destroyer_fighter
	)

	unit_test_groups = list(3)

/singleton/submap_archetype/sol_destroyer
	map = "Sol Destroyer Auxiliary Vessel"
	descriptor = "A repurposed hauler operated by the Solarian People's Liberation Fleet, sent to raid corporate holdings in the CRZ."

/obj/effect/overmap/visitable/ship/sol_destroyer
	name = "Sol Destroyer Auxiliary Vessel"
	class = "SPLFV" // Solarian People's Liberation Fleet Vessel. This is not an anonymous or 'undercover' ship, they openly fly their colours.
	desc = "The Laksamana-class hauling vessel is a relatively unusual sighting in the wider spur, native almost exclusively to the shipyards of Hang Tuah's Rest and the surrounding space. Unlike its more successful competitors, it vests less of its space in its cargo capacity and more of its space in crew compartments - though, despite this, it remains quite cramped. This one appears to have been substantially modified, boasting a heavily armed gunnery pod slotted into its starboard cargo pod port, apparently feeding two moderately sized ballistic cannons. The hull also appears to have been strengthened, and the exterior has been painted a dull military green."
	icon_state = "freighter"
	moving_state = "freighter_moving"
	colors = list("#5a644e", "#6a7e53")
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL
	scanimage = "tramp_freighter.png" // Looks close enough.
	designer = "Einstein Engines, Hang Tuah's Rest Orbital Shipyards"
	volume = "50 meters length, 36 meters beam/width, 13 meters vertical height"
	weapons = "Heavily modified ballistic gunnery pod starboard, shuttle bay portside"
	sizeclass = "Laksamana-class hauler"
	shiptype = "Remote hauling operations, long-term crew habitation"

	initial_restricted_waypoints = list(
		"Sol Destroyer Shuttle" = list("nav_hangar_splf")
	)

	initial_generic_waypoints = list(
		"sol_destroyer_nav1",
		"sol_destroyer_nav2",
		"sol_destroyer_nav3",
		"sol_destroyer_nav4",
		"sol_destroyer_starboard_dock",
		"sol_destroyer_port_dock",
		"sol_destroyer_aft_dock",
		"sol_destroyer_fore_dock"
	)

	invisible_until_ghostrole_spawn = TRUE

/obj/effect/overmap/visitable/ship/sol_destroyer/New()
	designation = "[pick("Not A Fan Of The Government", "National Liberation", "Free Spirit", "Not Wanted Here", "Tight-knit", "Silat", "Sejarah Melayu", "As They Were Before", "Hand of Cabanas", "Justice for Mictlan", "Not One Step More", "Fraternity", "Culpability", "Magistrate", "Equity", "Sic Semper Tyrannis")]"
	..()

// Using the freighter sprite.
/obj/effect/overmap/visitable/ship/sol_destroyer/get_skybox_representation()
	var/image/skybox_image = image('icons/skybox/subcapital_ships.dmi', "tramp_freighter")
	skybox_image.pixel_x = rand(0,64)
	skybox_image.pixel_y = rand(128,256)
	return skybox_image

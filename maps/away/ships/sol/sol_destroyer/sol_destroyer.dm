/datum/map_template/ruin/away_site/sol_destroyer

	name = "Solarian Navy Destroyer"
	description = "A repurposed hauler operated by the Solarian People's Liberation Fleet, sent to raid corporate holdings in the CRZ."

	prefix = "ships/sol/sol_destroyer/"
	suffix = "sol_destroyer.dmm"

	traits = list(
		// Deck one
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = TRUE, ZTRAIT_DOWN = FALSE),
		// Deck two
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = FALSE, ZTRAIT_DOWN = TRUE),
	)

	sectors = list(SECTOR_BADLANDS, SECTOR_VALLEY_HALE)
	spawn_weight_sector_dependent = list(SECTOR_CRESCENT_EXPANSE_WEST = 0.5)
	spawn_weight = 1
	ship_cost = 1
	id = "sol_destroyer"
	shuttles_to_initialise = list(
		/datum/shuttle/autodock/multi/lift/sol_destroyer,
		/datum/shuttle/autodock/overmap/sol_destroyer_transport,
		/datum/shuttle/autodock/overmap/sol_destroyer_fighter
	)

	unit_test_groups = list(3)

/singleton/submap_archetype/sol_destroyer
	map = "Solarian Navy Destroyer"
	descriptor = "A repurposed hauler operated by the Solarian People's Liberation Fleet, sent to raid corporate holdings in the CRZ."

/obj/effect/overmap/visitable/ship/sol_destroyer
	name = "Solarian Navy Destroyer"
	class = "SAMV"
	desc = "The Laksamana-class hauling vessel is a relatively unusual sighting in the wider spur, native almost exclusively to the shipyards of Hang Tuah's Rest and the surrounding space. Unlike its more successful competitors, it vests less of its space in its cargo capacity and more of its space in crew compartments - though, despite this, it remains quite cramped. This one appears to have been substantially modified, boasting a heavily armed gunnery pod slotted into its starboard cargo pod port, apparently feeding two moderately sized ballistic cannons. The hull also appears to have been strengthened, and the exterior has been painted a dull military green."
	icon_state = "line_cruiser"
	moving_state = "line_cruiser_moving"
	colors = list("#5a644e", "#6a7e53")
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL
	scanimage = "line_cruiser.png"
	designer = "Solarian State Shipbuilding Corporation, Sovereign Solarian Federation of Triton"
	volume = "80 meters length, 33 meters beam/width, 25 meters vertical height"
	weapons = "<b>Main gun: </b>Kasen National Munitions Piledriver 7.9-inch(200 cm)/40-caliber light coilgun<BR>\
	<BR><b>Autocannons: </b>Kumar Arms Goshawk 2.4-inch (60 mm)/33-caliber quadruple mount chaingun<BR>\
	<BR><b>Facilities: </b>Midship hangar deck"
	sizeclass = "Pallas-class Escort Destroyer"
	shiptype = "Convoy escort, anti-piracy patrols, system defence"

	initial_restricted_waypoints = list(
		"Sol Destroyer Shuttle" = list("nav_hangar_sol_destroyer")
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
	var/planetary_body = pick(
		"Jupiter", "Saturn", "Uranus", "Neptune", "Venus", "Mars", "Ganymede", "Titan",
		"Mercury", "Callisto", "Io", "Europa", "Triton", "Pluto", "Eris", "Haumea",
		"Titania", "Rhea", "Oberon", "Iapetus", "Makemake", "Charon", "Umbriel", "Ariel",
		"Dione", "Quaoar", "Tethys", "Sedna", "Ceres", "Orcus", "Salacia", "Vesta",
		"Pallas", "Enceladus", "Mimas", "Nereid", "Europa", "Hyperion", "Juno", "Mnemosyne",
	)
	// Letter acronym corresponding to a ship class
	var/list/hull_class = pick("", "", "", pick("DDE"))
	// Unique numerical code assigned to a specific hull
	var/list/hull_number = pick("", "", "", pick("[rand(100, 500)]"))
	// The final product: the ship name + the hull code
	designation = "[planetary_body] ([hull_class]-[hull_number])"
	..()

// Using the freighter sprite.
/obj/effect/overmap/visitable/ship/sol_destroyer/get_skybox_representation()
	var/image/skybox_image = image('icons/skybox/subcapital_ships.dmi', "line_cruiser")
	skybox_image.pixel_x = rand(0,64)
	skybox_image.pixel_y = rand(128,256)
	return skybox_image

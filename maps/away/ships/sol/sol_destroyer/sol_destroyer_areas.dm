/area/sol_destroyer
	name = "Solarian Navy Destroyer"
	icon_state = "green"
	requires_power = TRUE
	no_light_control = FALSE
	base_turf = /turf/space
	area_flags = AREA_FLAG_RAD_SHIELDED
	ambience = AMBIENCE_ENGINEERING

/area/sol_destroyer/exterior
	name = "Solarian Navy Destroyer - Exterior"
	requires_power = FALSE
	icon_state = "exterior"
	needs_starlight = TRUE
	has_gravity = FALSE

// First Deck
/area/sol_destroyer/deck_one/fuel_starboard
	name = "Solarian Navy Destroyer - Starboardside Fuel Storage"
	icon_state = "thrust"
	ambience = AMBIENCE_ATMOS

/area/sol_destroyer/deck_one/fuel_port
	name = "Solarian Navy Destroyer - Portside Fuel Storage"
	icon_state = "thrust"
	ambience = AMBIENCE_ATMOS

/area/sol_destroyer/deck_one/cargo
	name = "Solarian Navy Destroyer - Cargo Hold"
	icon_state = "quartloading"

/area/sol_destroyer/deck_one/engineering
	name = "Solarian Navy Destroyer - Engineering Storage"
	icon_state = "engineering"

/area/sol_destroyer/deck_one/aft_hall
	name = "Solarian Navy Destroyer - Deck One, Aft Hallway"
	icon_state = "hallA"

/area/sol_destroyer/deck_one/workshop
	name = "Solarian Navy Destroyer - Workshop"
	icon_state = "machinist_workshop"

/area/sol_destroyer/deck_one/eva
	name = "Solarian Navy Destroyer - EVA Storage"
	icon_state = "eva"

/area/sol_destroyer/deck_one/brig
	name = "Solarian Navy Destroyer - Brig"
	icon_state = "brig"
	ambience = AMBIENCE_HIGHSEC

/area/sol_destroyer/deck_one/armoury
	name = "Solarian Navy Destroyer - Armoury"
	icon_state = "Tactical"
	ambience = AMBIENCE_HIGHSEC

/area/sol_destroyer/deck_one/mid_hall
	name = "Solarian Navy Destroyer - Deck One, Amidships Hallway"
	icon_state = "hallC"

/area/sol_destroyer/deck_one/hangar
	name = "Solarian Navy Destroyer - Hangar Bay"
	icon_state = "hangar"
	ambience = AMBIENCE_HANGAR

/area/sol_destroyer/deck_one/vls
	name = "Solarian Navy Destroyer - Vertical Launching System"
	icon_state = "bridge_weapon"
	ambience = AMBIENCE_HIGHSEC
//

// Second Deck
/area/sol_destroyer/deck_two/thrusters_starboard
	name = "Solarian Navy Destroyer - Starboardside Thruster Compartment"
	icon_state = "thrust"
	ambience = AMBIENCE_ATMOS

/area/sol_destroyer/deck_two/thrusters_port
	name = "Solarian Navy Destroyer - Portside Thruster Compartment"
	icon_state = "thrust"
	ambience = AMBIENCE_ATMOS

/area/sol_destroyer/deck_two/tcomms
	name = "Solarian Navy Destroyer - Telecommunications"
	icon_state = "tcommsatcham"

/area/sol_destroyer/deck_two/engine
	name = "Solarian Navy Destroyer - Engine"
	icon_state = "engine"

/area/sol_destroyer/deck_two/closet
	name = "Solarian Navy Destroyer - Auxiliary Closet"
	icon_state = "janitor"

/area/sol_destroyer/deck_two/aft_hall
	name = "Solarian Navy Destroyer - Deck Two, Aft Hallway"
	icon_state = "hallA"

/area/sol_destroyer/deck_two/infirmary
	name = "Solarian Navy Destroyer - Infirmary"
	icon_state = "medbay"

/area/sol_destroyer/deck_two/barracks
	name = "Solarian Navy Destroyer - Crew Barracks"
	icon_state = "crew_quarters"

/area/sol_destroyer/deck_two/head
	name = "Solarian Navy Destroyer - Head"
	icon_state = "restrooms"

/area/sol_destroyer/deck_two/wardroom
	name = "Solarian Navy Destroyer - Wardroom"
	icon_state = "lounge"

/area/sol_destroyer/deck_two/officers_stateroom
	name = "Solarian Navy Destroyer - Officers Stateroom"
	icon_state = "crew_quarters"

/area/sol_destroyer/deck_two/mid_hall
	name = "Solarian Navy Destroyer - Deck Two, Amidships Hallway"
	icon_state = "hallC"

/area/sol_destroyer/deck_two/central_lift
	name = "Solarian Navy Destroyer - Central Lift"
	icon_state = "hallC"
	ambience = AMBIENCE_ELEVATOR

/area/sol_destroyer/deck_two/starboard_weapon
	name = "Solarian Navy Destroyer - Starboardside Weapons System"
	icon_state = "bridge_weapon"
	ambience = AMBIENCE_HIGHSEC

/area/sol_destroyer/deck_two/port_weapon
	name = "Solarian Navy Destroyer - Portside Weapons System"
	icon_state = "bridge_weapon"
	ambience = AMBIENCE_HIGHSEC

/area/sol_destroyer/deck_two/cic
	name = "Solarian Navy Destroyer - Operations Control Room"
	icon_state = "bridge"
	ambience = AMBIENCE_HIGHSEC

/area/sol_destroyer/deck_two/captains_office
	name = "Solarian Navy Destroyer - Captain's Stateroom"
	icon_state = "captain"
	ambience = AMBIENCE_FOREBODING

/area/sol_destroyer/deck_two/captains_cabin
	name = "Solarian Navy Destroyer - Captain's Cabin"
	icon_state = "captain"
	ambience = AMBIENCE_FOREBODING

/area/sol_destroyer/deck_two/bridge
	name = "Solarian Navy Destroyer - Bridge"
	icon_state = "bridge"
	ambience = AMBIENCE_HIGHSEC

/area/sol_destroyer/deck_two/starboard_hall
	name = "Solarian Navy Destroyer - Deck Two, Starboardside Hallway"
	icon_state = "hallS"

/area/sol_destroyer/deck_two/port_hall
	name = "Solarian Navy Destroyer - Deck Two, Portside Hallway"
	icon_state = "hallP"
//

// Lift area
/area/turbolift/sol_destroyer/sol_destroyer_lift
	name = "Solarian Navy Destroyer - Lift"
	icon_state = "turbolift"
	ambience = AMBIENCE_ELEVATOR
	station_area = FALSE

// Shuttle areas
/area/shuttle/sol_destroyer/transport
	name = "Solarian Navy Destroyer - Transport Shuttle"
	requires_power = TRUE

/area/shuttle/sol_destroyer/fighter
	name = "Solarian Navy Destroyer - Fighter"
	requires_power = TRUE

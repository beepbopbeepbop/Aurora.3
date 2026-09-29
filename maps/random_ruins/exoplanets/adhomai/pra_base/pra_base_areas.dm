// Areas
/area/pra_base
	name = "GPASRF Base 611-5748 - Base Type"
	requires_power = FALSE
	area_flags = AREA_FLAG_HIDE_FROM_HOLOMAP | AREA_FLAG_RAD_SHIELDED | AREA_FLAG_INDESTRUCTIBLE_TURFS | AREA_FLAG_PREVENT_PERSISTENT_TRASH
	base_turf = /turf/simulated/floor/exoplanet/mineral/cave/adhomai

/area/pra_base/out_of_bounds
	name = "GPASRF Base 611-5748"
	icon_state = "blue"
// --------

// Outside
/area/pra_base/outside
	name = "GPASRF Base 611-5748, Outdoors"
	icon_state = "dark128"
	is_outside = OUTSIDE_YES
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS

/area/pra_base/outside/firing_range
	name = "GPASRF Base 611-5748, Outdoors - Firing Range"

/area/pra_base/outside/artillery
	name = "GPASRF Base 611-5748, Outdoors - Field Gun Emplacement"

/area/pra_base/outside/artillery/tent
	is_outside = OUTSIDE_NO

/area/pra_base/outside/parade
	name = "GPASRF Base 611-5748, Outdoors - Parade Grounds"

/area/pra_base/outside/cages
	name = "GPASRF Base 611-5748, Outdoors - Ha'rron Kennel"

/area/pra_base/outside/landing_pad
	name = "GPASRF Base 611-5748, Outdoors - Landing Pad"
// --------

// Unsorted Building Insides
/area/pra_base/inside
	name = "GPASRF Base 611-5748 - Base Type"

/area/pra_base/inside/checkpoint
	name = "GPASRF Base 611-5748 - Checkpoint"

/area/pra_base/inside/garage
	name = "GPASRF Base 611-5748 - Garage"

/area/pra_base/inside/armoury
	name = "GPASRF Base 611-5748 - Armoury"

/area/pra_base/inside/infirmary
	name = "GPASRF Base 611-5748 - Infirmary"
// --------

// Barracks
/area/pra_base/inside/barracks
	name = "GPASRF Base 611-5748, Barracks - Base Type"

/area/pra_base/inside/barracks/bunks
	name = "GPASRF Base 611-5748, Barracks - Bunks"

/area/pra_base/inside/barracks/lavatory
	name = "GPASRF Base 611-5748, Barracks - Lavatory"

/area/pra_base/inside/barracks/kitchen
	name = "GPASRF Base 611-5748, Barracks - Kitchen"
// --------

// Presidium
/area/pra_base/inside/presidium
	name = "GPASRF Base 611-5748, Presidium - Base Type"

/area/pra_base/inside/presidium/antechamber
	name = "GPASRF Base 611-5748, Presidium - Antechamber"

/area/pra_base/inside/presidium/hall
	name = "GPASRF Base 611-5748, Presidium - Hall"

/area/pra_base/inside/presidium/commissar_office
	name = "GPASRF Base 611-5748, Presidium - Political Commissar's Office"

/area/pra_base/inside/presidium/commissar_quarters
	name = "GPASRF Base 611-5748, Presidium - Political Commissar's Quarters"
// --------

// Missile Silo
/area/pra_base/inside/silo
	name = "GPASRF Base 611-5748, Missile Silo - Base Type"

/area/pra_base/inside/silo/hallway_upper
	name = "GPASRF Base 611-5748, Missile Silo - Hallway"

/area/pra_base/inside/silo/hallway_lower
	name = "GPASRF Base 611-5748, Missile Silo - Hallway"

/area/pra_base/inside/silo/control
	name = "GPASRF Base 611-5748, Missile Silo - Control Room"

/area/pra_base/inside/silo/blastdoor
	name = "GPASRF Base 611-5748, Missile Silo - Blastdoor Access"
	is_outside = OUTSIDE_YES

/area/pra_base/inside/silo/launch
	name = "GPASRF Base 611-5748, Missile Silo - Missile Launch Access"

/area/pra_base/inside/silo/ai
	name = "GPASRF Base 611-5748, Missile Silo - Aparhatchyk Subsystem"
// --------

// Shuttle
/area/shuttle/paf_transport
	name = "GPASRF Base 611-5748 - PAF Transport Shuttle"
	requires_power = TRUE
// --------

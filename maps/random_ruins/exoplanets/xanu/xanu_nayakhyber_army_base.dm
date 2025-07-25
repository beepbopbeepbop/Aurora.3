/datum/map_template/ruin/exoplanet/xanu_nayakhyber_army_base
	name = "All-Xanu Grand Army Base"
	id = "xanu_nayakhyber_army_base"
	description = "A military outpost belonging to the Grand Army of the All-Xanu Armed Forces."
	spawn_weight = 1
	spawn_cost = 2
	template_flags = TEMPLATE_FLAG_NO_RUINS|TEMPLATE_FLAG_RUIN_STARTS_DISALLOWED
	sectors = list(SECTOR_XANU)
	prefix = "xanu/"
	suffix = "xanu_nayakhyber_army_base.dmm"

	unit_test_groups = list(3)

// Areas
/area/moghes/xanu_nayakhyber_army_base
	name = "All-Xanu Grand Army Base"
	icon_state = "red"
	requires_power = FALSE
	dynamic_lighting = TRUE
	no_light_control = FALSE
	is_outside = OUTSIDE_NO
	base_turf = /turf/simulated/floor/exoplanet/grass
	area_flags = AREA_FLAG_RAD_SHIELDED|AREA_FLAG_INDESTRUCTIBLE_TURFS

/area/moghes/xanu_nayakhyber_army_base/outdoors
	name = "All-Xanu Grand Army Base Outdors"
	icon_state = "bluenew"
	is_outside = OUTSIDE_YES
	area_blurb = "A tall fence encircles squat concrete buildings."

// Ghostspawners
// Soldier
/datum/ghostspawner/human/xanu_nayakhyber_army_soldier
	name = "All-Xanu Grand Army Soldier"
	short_name = "xanu_nayakhyber_army_soldier"
	desc = "Serve as a soldier in the All-Xanu Grand Army, the planetary military branch of Xanu Prime and one of the largest component armies of the Coalition of Colonies."
	tags = list("External")

	welcome_message = "You're a soldier manning an All-Xanu Grand Army outpost, representing Xanu Prime and protecting the Coalition of Colonies. You are a military professional, and are trained extensively in combat, survival, and damage control, but \
	may specialize in specific fields such as infantry or security"

	spawnpoints = list("xanu_nayakhyber_army_soldier")
	max_count = 4
	mob_name_prefix = "SOLD. 1RE CL. "

	outfit = /obj/outfit/admin/xanu_nayakhyber_army_soldier
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_DIONA, SPECIES_IPC, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "All-Xanu Grand Army Soldier"
	special_role = "All-Xanu Grand Army Soldier"
	respawn_flag = null

/obj/outfit/admin/xanu_nayakhyber_army_soldier
	name = "All-Xanu Grand Army Soldier"
	id = /obj/item/card/id/coalition
	l_ear = /obj/item/device/radio/headset/ship/coalition_navy
	back = /obj/item/storage/backpack/industrial
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/device/radio
		)

	uniform = /obj/item/clothing/under/xanu
	head = /obj/item/clothing/head/xanu
	shoes = /obj/item/clothing/shoes/jackboots

// Engineer
/datum/ghostspawner/human/xanu_nayakhyber_army_soldier/engineer
	name = "All-Xanu Grand Army Engineer"
	short_name = "xanu_nayakhyber_army_engineer"
	desc = "Serve as an engineer in the All-Xanu Grand Army, the planetary military branch of Xanu Prime and one of the largest component armies of the Coalition of Colonies."
	tags = list("External")

	welcome_message = "You're an engineer manning an All-Xanu Grand Army outpost, representing Xanu Prime and protecting the Coalition of Colonies. You are a military professional, and are trained extensively in combat, survival, and damage control, and \
	serve as your unit's combat engineering specialist."

	spawnpoints = list("xanu_nayakhyber_army_engineer")
	max_count = 1
	mob_name_prefix = "CPL. "

	outfit = /obj/outfit/admin/xanu_nayakhyber_army_engineer
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_DIONA, SPECIES_IPC, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "All-Xanu Grand Army Engineer"
	special_role = "All-Xanu Grand Army Engineer"
	respawn_flag = null

/obj/outfit/admin/xanu_nayakhyber_army_engineer
	name = "All-Xanu Grand Army Engineer"
	uniform = /obj/item/clothing/under/xanu/engi

// Medic
/datum/ghostspawner/human/xanu_nayakhyber_army_soldier/medic
	name = "All-Xanu Grand Army Medic"
	short_name = "xanu_nayakhyber_army_medic"
	desc = "Serve as a medic in the All-Xanu Grand Army, the planetary military branch of Xanu Prime and one of the largest component armies of the Coalition of Colonies."
	tags = list("External")

	welcome_message = "You're a medic manning an All-Xanu Grand Army outpost, representing Xanu Prime and protecting the Coalition of Colonies. You are a military professional, and are trained extensively in combat, survival, and damage control, and \
	serve as your unit's combat medic and surgeon."

	spawnpoints = list("xanu_nayakhyber_army_medic")
	max_count = 1
	mob_name_prefix = "SGT. "

	outfit = /obj/outfit/admin/xanu_nayakhyber_army_medic
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_DIONA, SPECIES_IPC, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "All-Xanu Grand Army Medic"
	special_role = "All-Xanu Grand Army Medic"
	respawn_flag = null

/obj/outfit/admin/xanu_nayakhyber_army_medic
	name = "All-Xanu Grand Army Medic"
	uniform = /obj/item/clothing/under/xanu/med

// Officer
/datum/ghostspawner/human/xanu_nayakhyber_army_soldier/officer
	name = "All-Xanu Grand Army Officer"
	short_name = "xanu_nayakhyber_army_officer"
	desc = "Serve as an officer in the All-Xanu Grand Army, the planetary military branch of Xanu Prime and one of the largest component armies of the Coalition of Colonies."
	tags = list("External")

	welcome_message = "You're an officer manning an All-Xanu Grand Army outpost, representing Xanu Prime and protecting the Coalition of Colonies. You are a military professional, and are trained extensively in combat, survival, and damage control, and \
	serve as your unit's commander."

	spawnpoints = list("xanu_nayakhyber_army_officer")
	max_count = 1
	mob_name_prefix = "LT. "

	outfit = /obj/outfit/admin/xanu_nayakhyber_army_officer
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_DIONA, SPECIES_IPC, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "All-Xanu Grand Army Officer"
	special_role = "All-Xanu Grand Army Officer"
	respawn_flag = null

/obj/outfit/admin/xanu_nayakhyber_army_officer
	name = "All-Xanu Grand Army Officer"
	uniform = /obj/item/clothing/under/xanu/officer
	head = /obj/item/clothing/head/xanu/officer
	shoes = /obj/item/clothing/shoes/laceup/brown
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/device/radio
		)

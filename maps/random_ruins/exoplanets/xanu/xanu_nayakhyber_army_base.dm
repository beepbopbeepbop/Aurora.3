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
/datum/ghostspawner/human/xanu_nayakhyber_army_soldier
	name = "All-Xanu Grand Army Soldier"
	short_name = "xanu_nayakhyber_army_soldier"
	desc = "Serve as a soldier in the All-Xanu Grand Army, the planetary military branch of Xanu Prime and one of the largest component armies of the Coalition of Colonies."
	tags = list("External")

	welcome_message = "You're a soldier manning an All-Xanu Grand Army outpost, representing Xanu Prime and protecting the Coalition of Colonies. You are a military professional, and are trained extensively in combat, survival, and damage control, but \
	may specialize in specific fields such as infantry, engineering, security, or bridge crew."

	spawnpoints = list("xanu_nayakhyber_army_soldier")
	max_count = 4
	mob_name_prefix = "PO3. "

	outfit = /obj/outfit/admin/xanufrigate_crewman
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_DIONA, SPECIES_IPC, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "All-Xanu Grand Army Soldier"
	special_role = "All-Xanu Grand Army Soldier"
	respawn_flag = null

/obj/outfit/admin/xanu_nayakhyber_army_soldier
	name = "All-Xanu Grand Army Soldier"
	uniform = /obj/item/clothing/under/xanu
	head = /obj/item/clothing/head/xanu
	shoes = /obj/item/clothing/shoes/jackboots
	l_ear = /obj/item/device/radio/headset/ship/coalition_navy
	back = /obj/item/storage/backpack/satchel
	id = /obj/item/card/id/coalition
	l_pocket = /obj/item/device/radio/off
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/clothing/mask/gas/half = 1,
		)

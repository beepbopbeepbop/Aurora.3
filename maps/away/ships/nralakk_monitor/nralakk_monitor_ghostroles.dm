/datum/ghostspawner/human/nralakk_monitor_crew
	name = "Nralakk Federal Security Vessel Crew"
	short_name = "nralakk_monitor_crew"
	desc = "x."
	tags = list("External")

	spawnpoints = list("nralakk_monitor_crew")
	max_count = 3

	outfit = /obj/outfit/admin/nralakk_monitor_crew
	possible_species = list(
		SPECIES_SKRELL,
		SPECIES_SKRELL_AXIORI,
		SPECIES_VAURCA_WORKER,
		SPECIES_VAURCA_ATTENDANT,
		SPECIES_VAURCA_WARRIOR,
		SPECIES_VAURCA_BULWARK,
		SPECIES_DIONA,
		SPECIES_DIONA_COEUS
	)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Nralakk Federal Security Vessel Crew"
	special_role = "Nralakk Federal Security Vessel Crew"
	respawn_flag = null

/obj/outfit/admin/nralakk_monitor_crew
	name = "Nralakk Federal Security Vessel Crew"
	uniform = /obj/item/clothing/under/skrell/qukala
	gloves = /obj/item/clothing/gloves/kala
	shoes = /obj/item/clothing/shoes/jackboots/kala
	back = /obj/item/storage/backpack/kala
	head =
	id = /obj/item/card/id/white
	l_ear = /obj/item/radio/headset/ship
	backpack_contents = list(/obj/item/storage/box/survival = 1)

/obj/outfit/admin/nralakk_monitor_crew/get_id_access()
	return list(ACCESS_NRALAKK_MONITOR, ACCESS_EXTERNAL_AIRLOCKS)

// 1 lead enforcer, 1 medic, 1 engineer, 3 enforcers

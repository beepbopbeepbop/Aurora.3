/datum/ghostspawner/human/himean_crewman
	name = "Himean Planetary Navy Crewman"
	short_name = "tcaf_crewman"
	desc = "sigma"
	tags = list("External")
	mob_name_prefix = "Smn. "

	spawnpoints = list("himean_crewman")
	max_count = 4

	outfit = /obj/outfit/admin/himean_crewman
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_TAJARA, SPECIES_TAJARA_MSAI, SPECIES_TAJARA_ZHAN, SPECIES_IPC, SPECIES_IPC_G1, SPECIES_IPC_G2, SPECIES_IPC_XION, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Himean Planetary Navy Crewman"
	special_role = "Himean Planetary Navy Crewman"
	respawn_flag = null

/obj/outfit/admin/himean_crewman
	name = "Himean Planetary Navy Crewman"
	gloves = /obj/item/clothing/gloves/black
	shoes = /obj/item/clothing/shoes/jackboots
	id = /obj/item/card/id/coalition
	l_ear = /obj/item/device/radio/headset/ship
	backpack_contents = list(/obj/item/storage/box/survival = 1)

	species_shoes = list(
		SPECIES_TAJARA = /obj/item/clothing/shoes/jackboots/toeless,
		SPECIES_TAJARA_MSAI = /obj/item/clothing/shoes/jackboots/toeless,
		SPECIES_TAJARA_ZHAN = /obj/item/clothing/shoes/jackboots/toeless,
	)

/obj/outfit/admin/himean_crewman/get_id_access()
	return list(ACCESS_HIMEAN_CORVETTE, ACCESS_EXTERNAL_AIRLOCKS)

/datum/ghostspawner/human/himean_crewman/captain
	name = "Himean Planetary Navy Captain"
	short_name = "himean_captain"
	desc = "sigma"
	tags = list("External")
	mob_name_prefix = "Smn. "

	spawnpoints = list("himean_captain")
	max_count = 4

	outfit = /obj/outfit/admin/himean_crewman/captain
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Himean Planetary Navy Captain"
	special_role = "Himean Planetary Navy Captain"
	respawn_flag = null

/obj/outfit/admin/himean_crewman/captain
	name = "Himean Planetary Navy Captain"
	gloves = /obj/item/clothing/gloves/black
	shoes = /obj/item/clothing/shoes/jackboots
	id = /obj/item/card/id/coalition
	l_ear = /obj/item/device/radio/headset/ship
	backpack_contents = list(/obj/item/storage/box/survival = 1)

	species_shoes = list(
		SPECIES_TAJARA = /obj/item/clothing/shoes/jackboots/toeless,
		SPECIES_TAJARA_MSAI = /obj/item/clothing/shoes/jackboots/toeless,
		SPECIES_TAJARA_ZHAN = /obj/item/clothing/shoes/jackboots/toeless,
	)

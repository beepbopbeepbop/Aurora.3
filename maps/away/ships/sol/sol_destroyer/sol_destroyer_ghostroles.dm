// Default enlisted sailor
/datum/ghostspawner/human/sol_destroyer_sailor
	name = "Solarian Navy Destroyer Sailor"
	short_name = "sol_destroyer_sailor"
	desc = "description here."
	tags = list("External")

	mob_name_prefix = "PO3. "

	spawnpoints = list("sol_destroyer_sailor")
	max_count = 4

	outfit = /obj/outfit/admin/sol_destroyer_sailor
	possible_species = list(SPECIES_HUMAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Sailor"
	special_role = "Solarian Navy Destroyer Sailor"
	respawn_flag = null

/obj/outfit/admin/sol_destroyer_sailor
	name = "Solarian Navy Destroyer Sailor"
	uniform = /obj/item/clothing/under/rank/sol
	gloves = /obj/item/clothing/gloves/black
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack/satchel/eng
	head = /obj/item/clothing/head/sol
	id = /obj/item/card/id/white
	l_ear = /obj/item/radio/headset/ship
	backpack_contents = list(/obj/item/storage/box/survival/engineer = 1)

/obj/outfit/admin/sol_destroyer_sailor/get_id_access()
	return list(ACCESS_SOL_SHIPS, ACCESS_EXTERNAL_AIRLOCKS)
// ------------

// Marine security complement
/datum/ghostspawner/human/sol_destroyer_sailor/marine
	name = "Solarian Navy Destroyer Marine"
	short_name = "sol_destroyer_marine"
	desc = "description here."

	mob_name_prefix = "SGT. "

// ------------

// XO
/datum/ghostspawner/human/sol_destroyer_sailor/officer
	name = "Solarian Navy Destroyer Executive Officer"
	short_name = "sol_destroyer_officer"
	desc = "description here."

	mob_name_prefix = "LT. "

// ------------

// CO
/datum/ghostspawner/human/sol_destroyer_sailor/captain
	name = "Solarian Navy Destroyer Commanding Officer"
	short_name = "sol_destroyer_captain"
	desc = "description here."

	mob_name_prefix = "CDR. "

// ------------

// Synthetic
/datum/ghostspawner/human/sol_destroyer_synth
	name = "Solarian Navy Destroyer Synthetic Auxiliary"
	short_name = "sol_destroyer_synth"
	desc = "description here."
	tags = list("External")

	mob_name_prefix = "NU-"

	spawnpoints = list("sol_destroyer_synth")
	max_count = 1

	outfit = /obj/outfit/admin/sol_destroyer_synth
	possible_species = list(SPECIES_IPC)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Synthetic Auxiliary"
	special_role = "Solarian Navy Destroyer Synthetic Auxiliary"
	respawn_flag = null

/obj/outfit/admin/sol_destroyer_synth
	name = "Solarian Navy Destroyer Synthetic Auxiliary"
	uniform = /obj/item/clothing/under/rank/sol/ipc
	gloves = /obj/item/clothing/gloves/black
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack/industrial
	id = /obj/item/card/id/white
	l_ear = /obj/item/radio/headset/ship
	backpack_contents = list(/obj/item/storage/box/survival/engineer = 1)

/obj/outfit/admin/sol_destroyer_synth/get_id_access()
	return list(ACCESS_SOL_SHIPS, ACCESS_EXTERNAL_AIRLOCKS)
// ------------

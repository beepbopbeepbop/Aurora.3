// Standard 6-person crew:
//	Commissioned Officers - 1 Captain, 1 Line/Staff Officer
//	Enlisted Crew - 2 Marines, 2 Sailors
//	Auxiliary - 1 NU

// Extended 8-person crew:
//	Commissioned Officers - 1 Captain, 1 Line/Staff Officer
//	Non-Commissioned Officers - 1 SCPO
//	Enlisted Crew - 2 Marines, 3 Sailors
//	Auxiliary - 1 NU

// Odyssey 12-person crew:
//	Commissioned Officers - 1 Captain, 1 Line Officer (XO), 1 Staff Officer
//	Non-Commissioned Officers - 1 SCPO
//	Enlisted Crew - 2 Marines, 4 Sailors
//	Auxiliary - 2 NU

/obj/item/card/id/sol_navy
	name = "\improper SAN enlisted identification card"
	icon_state = "navy"
	item_state = "navy_id"
	overlay_state = "navy"
	access = list(/datum/access/sol_navy_enlisted::id, /datum/access/external_airlocks::id)

/obj/item/card/id/sol_navy/officer
	name = "\improper SAN officer identification card"
	icon_state = "gold"
	item_state = "gold_id"
	overlay_state = "gold"
	access = list(/datum/access/sol_navy_enlisted::id, /datum/access/sol_navy_officer::id, /datum/access/external_airlocks::id)

/obj/item/card/id/sol_navy/synth
	name = "\improper SAN synthetic auxiliary identification card"
	icon_state = "silver"
	item_state = "silver_id"
	overlay_state = "silver"
	access = list(/datum/access/sol_navy_enlisted::id, /datum/access/external_airlocks::id)

/obj/item/clothing/accessory/sec_commander_stripes/sol
	name = "head of security stripes"
	desc = "A set of high visibility inserts for use in armour. This one declares the wearer as a Head of Security."
	icon = 'icons/obj/item/clothing/accessory/armor/modular_armor_accessories.dmi'
	icon_state = "sec_commander_stripes"
	item_state = "sec_commander_stripes"
	contained_sprite = TRUE
	slot = ACCESSORY_SLOT_GENERIC
	flippable = FALSE

// Default enlisted sailor
/datum/ghostspawner/human/sol_destroyer_sailor
	name = "Solarian Navy Destroyer Sailor"
	short_name = "sol_destroyer_sailor"
	desc = "You are an enlisted sailor of the Solarian Alliance Navy, serving aboard a Pallas-class guided-missile destroyer."
	tags = list("External")

	mob_name_prefix = "PO3. "

	spawnpoints = list("sol_destroyer_sailor")
	max_count = 2

var/overflow = null

/datum/ghostspawner/human/sol_destroyer_sailor/proc/overflow_capacity(mob/user)
	if(max_count && (count >= max_count))
		return overflow = TRUE

	outfit = /obj/outfit/admin/sol_destroyer_sailor
	possible_species = list(SPECIES_HUMAN)
	culture_restriction = list(/singleton/origin_item/culture/solarian)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Sailor"
	special_role = "Solarian Navy Destroyer Sailor"
	respawn_flag = null

/obj/outfit/admin/sol_destroyer_sailor
	name = "Solarian Navy Destroyer Sailor"
	uniform = /obj/item/clothing/under/rank/sol
	gloves = /obj/item/clothing/gloves/black_leather
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack/satchel/eng
	head = /obj/item/clothing/head/sol
	backpack_contents = list(/obj/item/storage/box/survival/engineer = 1)

	id = /obj/item/card/id/sol_navy
	l_ear = /obj/item/radio/headset/ship

/obj/outfit/admin/sol_destroyer_sailor/get_id_access()
	return list(/datum/access/sol_navy_enlisted::id, /datum/access/external_airlocks::id)
// ------------

// Marine security complement
/datum/ghostspawner/human/sol_destroyer_sailor/marine
	name = "Solarian Navy Destroyer Marine"
	short_name = "sol_destroyer_marine"
	desc = "You are an enlisted marine of the Solarian Alliance Marine Corps, serving aboard a Pallas-class guided-missile destroyer."

	mob_name_prefix = "CPL. "

	spawnpoints = list("sol_destroyer_marine")
	max_count = 2

	outfit = /obj/outfit/admin/sol_destroyer_marine
	possible_species = list(SPECIES_HUMAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Marine"
	special_role = "Solarian Navy Destroyer Marine"
	respawn_flag = null

/obj/outfit/admin/sol_destroyer_marine
	name = "Solarian Navy Destroyer Marine"
	uniform = /obj/item/clothing/under/rank/sol/marine/grey
	head = /obj/item/clothing/head/sol/marine/grey

/obj/outfit/admin/sol_destroyer_marine/get_id_access()
	return list(/datum/access/sol_navy_enlisted::id, /datum/access/external_airlocks::id)
// ------------

// SCPO
/datum/ghostspawner/human/sol_destroyer_sailor/nco
	name = "Solarian Navy Destroyer Non-Commissioned Officer"
	short_name = "sol_destroyer_nco"
	desc = "You are a non-commissioned officer of the Solarian Alliance Navy, serving aboard a Pallas-class guided-missile destroyer."

	mob_name_prefix = "SCPO. "

	spawnpoints = list("sol_destroyer_nco")
	max_count = 1

/datum/ghostspawner/human/sol_destroyer_sailor/nco/proc/overflow_open_slot(mob/user)
	if(overflow)
		return enabled = TRUE
	else enabled = FALSE

	outfit = /obj/outfit/admin/sol_destroyer_nco
	possible_species = list(SPECIES_HUMAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Non-Commissioned Officer"
	special_role = "Solarian Navy Destroyer Non-Commissioned Officer"
	respawn_flag = null

	idris_account_min = 1000
	idris_account_max = 1500

/obj/outfit/admin/sol_destroyer_nco
	name = "Solarian Navy Destroyer Non-Commissioned Officer"
	uniform = /obj/item/clothing/under/rank/sol/dress/pettyofficer
	head = /obj/item/clothing/head/sol/dress

	id = /obj/item/card/id/sol_navy/officer

/obj/outfit/admin/sol_destroyer_nco/get_id_access()
	return list(/datum/access/sol_navy_enlisted::id,  /datum/access/sol_navy_officer::id, /datum/access/external_airlocks::id)
// ------------

// Line/Staff Officer
/datum/ghostspawner/human/sol_destroyer_sailor/officer
	name = "Solarian Navy Destroyer Commissioned Officer"
	short_name = "sol_destroyer_officer"
	desc = "You are a junior commissioned officer of the Solarian Alliance Navy, serving aboard a Pallas-class guided-missile destroyer."

	mob_name_prefix = "LT. "

	spawnpoints = list("sol_destroyer_officer")
	max_count = 1

	outfit = /obj/outfit/admin/sol_destroyer_officer
	possible_species = list(SPECIES_HUMAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Commissioned Officer"
	special_role = "Solarian Navy Destroyer Commissioned Officer"
	respawn_flag = null

	idris_account_min = 1500
	idris_account_max = 2000

/obj/outfit/admin/sol_destroyer_officer
	name = "Solarian Navy Destroyer Commissioned Officer"
	uniform = /obj/item/clothing/under/rank/sol/dress/subofficer
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel/leather
	head = /obj/item/clothing/head/sol/dress

	id = /obj/item/card/id/sol_navy/officer

/obj/outfit/admin/sol_destroyer_officer/get_id_access()
	return list(/datum/access/sol_navy_enlisted::id, /datum/access/sol_navy_officer::id, /datum/access/external_airlocks::id)
// ------------

// captain
/datum/ghostspawner/human/sol_destroyer_sailor/captain
	name = "Solarian Navy Destroyer Commanding Officer"
	short_name = "sol_destroyer_captain"
	desc = "You are a senior commissioned officer of the Solarian Alliance Navy, serving as the captain of a Pallas-class guided-missile destroyer."

	mob_name_prefix = "CDR. "

	spawnpoints = list("sol_destroyer_captain")
	max_count = 1

	outfit = /obj/outfit/admin/sol_destroyer_captain
	possible_species = list(SPECIES_HUMAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Commanding Officer"
	special_role = "Solarian Navy Destroyer Commanding Officer"
	respawn_flag = null

	idris_account_min = 2000
	idris_account_max = 2500

/obj/outfit/admin/sol_destroyer_captain
	name = "Solarian Navy Destroyer Commanding Officer"
	uniform = /obj/item/clothing/under/rank/sol/dress/officer
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel/leather
	head = /obj/item/clothing/head/sol/dress/senior_officer

	id = /obj/item/card/id/sol_navy/officer

/obj/outfit/admin/sol_destroyer_captain/get_id_access()
	return list(/datum/access/sol_navy_enlisted::id, /datum/access/sol_navy_officer::id, /datum/access/external_airlocks::id)
// ------------

// Synthetic
/datum/ghostspawner/human/sol_destroyer_synth
	name = "Solarian Navy Destroyer Synthetic Auxiliary"
	short_name = "sol_destroyer_synth"
	desc = "You are a synthetic auxiliary owned by the Solarian Alliance Navy, serving aboard a Pallas-class guided-missile destroyer."
	tags = list("External")

	mob_name_prefix = "NU-"

	spawnpoints = list("sol_destroyer_synth")
	max_count = 1

	outfit = /obj/outfit/admin/sol_destroyer_synth
	possible_species = list(SPECIES_IPC, SPECIES_IPC_SHELL, SPECIES_IPC_G1, SPECIES_IPC_G2, SPECIES_IPC_XION) // check with lore
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Solarian Navy Destroyer Synthetic Auxiliary"
	special_role = "Solarian Navy Destroyer Synthetic Auxiliary"
	respawn_flag = null

/obj/outfit/admin/sol_destroyer_synth
	name = "Solarian Navy Destroyer Synthetic Auxiliary"
	uniform = /obj/item/clothing/under/rank/sol/ipc
	gloves = /obj/item/clothing/gloves/black_leather
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack/industrial

	id = /obj/item/card/id/sol_navy/synth
	l_ear = /obj/item/radio/headset/ship

/obj/outfit/admin/sol_destroyer_synth/get_id_access()
	return list(/datum/access/sol_navy_enlisted::id, /datum/access/external_airlocks::id)

/obj/outfit/admin/sol_destroyer_synth/post_equip(mob/living/carbon/human/H, visualsOnly)
	var/obj/item/organ/internal/machine/ipc_tag/tag = H.internal_organs_by_name[BP_IPCTAG]
	if(istype(tag))
		tag.serial_number = uppertext(dd_limittext(md5(H.real_name), 12))
		tag.ownership_info = IPC_OWNERSHIP_PRIVATE
		tag.citizenship_info = CITIZENSHIP_NONE
// ------------

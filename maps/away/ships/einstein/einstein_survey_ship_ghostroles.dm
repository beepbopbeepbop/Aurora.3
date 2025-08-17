/datum/ghostspawner/human/einstein_ship_crew
	name = "Einstein Survey Ship Crewman"
	short_name = "einstein_crewman"
	desc = "."
	tags = list("External")

	spawnpoints = list("einstein_crewman")
	max_count = 4

	outfit = /obj/outfit/admin/einstein_crewman
	possible_species = list(SPECIES_HUMAN, SPECIES_SKRELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Einstein Survey Ship Crewman"
	special_role = "Einstein Survey Ship Crewman"
	respawn_flag = null

/obj/outfit/admin/einstein_crewman
	name = "Einstein Survey Ship Crewman"
	uniform = /obj/item/clothing/under/rank/einstein
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack/industrial
	id = /obj/item/card/id/einstein
	l_ear = /obj/item/device/radio/headset/ship
	backpack_contents = list(/obj/item/storage/box/survival/engineer = 1)

/obj/outfit/admin/einstein_crewman/get_id_access()
	return list(ACCESS_EINSTEIN, ACCESS_EXTERNAL_AIRLOCKS)

/obj/effect/ghostspawpoint/einstein_ship_crew
	name = "igs - einstein_crewman"
	identifier = "einstein_crewman"

// Einstein Survery Ship Captain - a career corporate ladder climber in command of the ship itself, as well as ensuring the security of Einstein assets and acting as a public representative of the company
/datum/ghostspawner/human/einstein_ship_crew/captain
	name = "Einstein Survey Ship Captain"
	short_name = "einstein_captain"
	desc = "."
	tags = list("External")

	spawnpoints = list("einstein_captain")
	max_count = 1

	outfit = /obj/outfit/admin/einstein_captain
	possible_species = list(SPECIES_HUMAN, SPECIES_SKRELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Einstein Survey Ship Captain"
	special_role = "Einstein Survey Ship Captain"
	respawn_flag = null

/obj/outfit/admin/einstein_crewman/captain
	name = "Einstein Survey Ship Captain"
	uniform = /obj/item/clothing/under/rank/liaison/einstein
	glasses = /obj/item/clothing/glasses/sunglasses/aviator
	gloves = /obj/item/clothing/ring/material/gold
	shoes = /obj/item/clothing/shoes/laceup/brown
	back = /obj/item/storage/backpack/satchel/leather
	l_pocket = /obj/item/storage/wallet/rich

/obj/effect/ghostspawpoint/einstein_ship_crew/captain
	name = "igs - einstein_captain"
	identifier = "einstein_captain"

// Einstein Survey Ship Researcher -
/datum/ghostspawner/human/einstein_ship_crew/scientist
	name = "Einstein Survey Ship Researcher"
	short_name = "einstein_scientist"
	desc = "."
	tags = list("External")

	spawnpoints = list("einstein_scientist")
	max_count = 1

	outfit = /obj/outfit/admin/einstein_scientist
	possible_species = list(SPECIES_HUMAN, SPECIES_SKRELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Einstein Survey Ship Researcher"
	special_role = "Einstein Survey Ship Researcher"
	respawn_flag = null

/obj/outfit/admin/einstein_crewman/scientist
	name = "Einstein Survey Ship Researcher"
	uniform = /obj/item/clothing/under/rank/scientist/einstein
	suit = /obj/item/clothing/suit/storage/toggle/longcoat
	shoes = /obj/item/clothing/shoes/laceup/brown
	back = /obj/item/storage/backpack/satchel/leather
	l_pocket = /obj/item/storage/wallet/rich

/obj/effect/ghostspawpoint/einstein_ship_crew/scientist
	name = "igs - einstein_scientist"
	identifier = "einstein_scientist"

// Einstein Survey Ship Security -
/datum/ghostspawner/human/einstein_ship_crew/security
	name = "Einstein Survey Ship Security"
	short_name = "einstein_security"
	desc = "."
	tags = list("External")

	spawnpoints = list("einstein_security")
	max_count = 2

	outfit = /obj/outfit/admin/einstein_security
	possible_species = list(SPECIES_HUMAN, SPECIES_SKRELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Einstein Survey Ship Security"
	special_role = "Einstein Survey Ship Security"
	respawn_flag = null

/obj/outfit/admin/einstein_crewman/security
	name = "Einstein Survey Ship Security"
	uniform = /obj/item/clothing/under/rank/security/einstein
	gloves = /obj/item/clothing/gloves/swat
	back = /obj/item/storage/backpack/satchel/eng
	l_pocket = /obj/item/storage/wallet/random

/obj/effect/ghostspawpoint/einstein_ship_crew/security
	name = "igs - einstein_security"
	identifier = "einstein_security"

// Einstein Survery Ship Synthetic -
/datum/ghostspawner/human/einstein_ship_crew/synth
	name = "Einstein Survey Ship Synthetic"
	short_name = "einstein_synth"
	desc = "."
	tags = list("External")

	spawnpoints = list("einstein_synth")
	max_count = 2

	outfit = /obj/outfit/admin/einstein_synth
	possible_species = list(SPECIES_IPC, SPECIES_IPC_BISHOP, SPECIES_IPC_G1, SPECIES_IPC_G2, SPECIES_IPC_SHELL, SPECIES_IPC_XION, SPECIES_IPC_ZENGHU)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Einstein Survey Ship Synthetic"
	special_role = "Einstein Survey Ship Synthetic"
	respawn_flag = null

/obj/outfit/admin/einstein_crewman/synth
	name = "Einstein Survey Ship Synthetic"
	uniform = /obj/item/clothing/under/rank/einstein/synthetic

/obj/effect/ghostspawpoint/einstein_ship_crew/synth
	name = "igs - einstein_synth"
	identifier = "einstein_synth"

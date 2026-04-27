/datum/ghostspawner/human/izharshan
	short_name = "izharshan_crew"
	name = "Izharshan Crewman"
	desc = "Quartermaster, Vesselhide, Gunner or mere Crew, whatever your role is, you will obey your captain, for your pirate clan and fleet, the Izharshan. NOT AN ANTAGONIST! Do not act as such."
	tags = list("External")

	spawnpoints = list("izharshan_crew")
	max_count = 4

	outfit = /obj/outfit/admin/izharshan
	possible_species = list(SPECIES_UNATHI)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Izharshan Crewman"
	special_role = "Izharshan Crewman"
	respawn_flag = null
	extra_languages = list(LANGUAGE_UNATHI, LANGUAGE_AZAZIBA)

	uses_species_whitelist = FALSE

	has_idris_account = FALSE

/datum/ghostspawner/human/izharshan/captain
	short_name = "izharshan_captain"
	name = "Izharshan Captain"
	desc = "Lead your ship for the honor and wealth of pirate clan and fleet Izharshan. Your ship has poor side armor, so be careful threatening ships with bigger guns, but your flechettes can intimidate the rest. If all else fails, you can bring the entire ship into boarding range. NOT AN ANTAGONIST! Do not act as such."
	max_count = 1
	uses_species_whitelist = TRUE

	spawnpoints = list("izharshan_captain")

	outfit = /obj/outfit/admin/izharshan/captain

	assigned_role = "Izharshan Captain"
	special_role = "Izharshan Captain"

/obj/outfit/admin/izharshan
	name = "Izharshan Crewman"

	uniform = /obj/item/clothing/under/unathi/izharshan
	shoes = /obj/item/clothing/shoes/sandals/caligae
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel/eng
	accessory = /obj/item/clothing/accessory/storage/webbing
	gloves = /obj/item/clothing/gloves/unathi
	head = /obj/item/clothing/head/headbando/random


	l_ear = /obj/item/radio/headset/ship

	backpack_contents = list(
		/obj/item/storage/box/survival = 1
	)

/obj/outfit/admin/izharshan/get_id_access()
	return list(ACCESS_IZHARSHAN_PIRATE_CREW, ACCESS_EXTERNAL_AIRLOCKS)

/obj/outfit/admin/izharshan/captain
	name = "Izharshan Captain"

	suit = /obj/item/clothing/suit/storage/toggle/asymmetriccoat/izharshan
	head = /obj/item/clothing/head/bandana/pirate

	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
	)

/obj/outfit/admin/izharshan/captain/get_id_access()
	return list(ACCESS_IZHARSHAN_PIRATE_CAPTAIN, ACCESS_IZHARSHAN_PIRATE_CREW, ACCESS_EXTERNAL_AIRLOCKS)

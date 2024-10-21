/datum/ghostspawner/human/kazhkz_privateer
	short_name = "kazhkz_privateer"
	name = "Grudgebearer Privateer"
	desc = "You are a privateer of Clan Lord Salak Kazhkz's Grudgebearer fleet - sent into the Badlands and the Sparring Sea to pillage and harass the enemies of the Empire and the Kazhkz-Han'san. Vessels of the Serene Republic of Elyra, the Coalition of Colonies, and the Izweski Hegemony are particularly prized targets by the Kazhkz. NOT AN ANTAGONIST! Do not act as such."
	tags = list("External")
	mob_name_suffix = " Kazhkz"
	mob_name_pick_message = "Pick an Unathi first name."
	spawnpoints = list("kazhkz_privateer")
	max_count = 4

	outfit = /obj/outfit/admin/kazhkz_privateer
	possible_species = list(SPECIES_UNATHI)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Kazhkz Privateer"
	special_role = "Kazhkz Privateer"
	respawn_flag = TRUE
	extra_languages = list(LANGUAGE_TRADEBAND, LANGUAGE_AZAZIBA)
	uses_species_whitelist = FALSE
	welcome_message = "You are a privateer of the Grudgebearers, the pirate fleet of Clan Kazhkz - a plausibly deniable weapon of the Empire of Dominia, sent to scourge the Emperor's enemies in the Badlands. Though the two nations are not enemies, the Kazhkz hold a particular hatred of the Izweski Hegemony, and will often attack their merchant vessels. The Unathi in Dominia wiki page may have some useful information for roleplaying a Kazhkz privateer."

/obj/outfit/admin/kazhkz_privateer
	name = "Grudgebearer Privateer"
	uniform = /obj/item/clothing/under/unathi
	accessory = /obj/item/clothing/accessory/dominia
	id = /obj/item/card/id
	gloves = /obj/item/clothing/gloves/orange/unathi
	shoes = /obj/item/clothing/shoes/jackboots/toeless
	back = /obj/item/storage/backpack/satchel/eng
	l_ear = /obj/item/device/radio/headset/ship

	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/donkpockets = 1,
		/obj/item/clothing/accessory/badge/passport/dominia = 1
	)

/obj/outfit/admin/kazhkz_privateer/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/uniform_colour = "#F3A11B"
	var/uniform_accent_colour = "#FF9E00"
	if(H?.w_uniform)
		H.w_uniform.color = uniform_colour
		H.w_uniform.accent_color = uniform_accent_colour

/obj/outfit/admin/kazhkz_privateer/get_id_access()
	return list(ACCESS_IMPERIAL_FLEET_VOIDSMAN_SHIP, ACCESS_EXTERNAL_AIRLOCKS)

/datum/ghostspawner/human/kazhkz_privateer/captain
	short_name = "kazhkz_privateer_captain"
	name = "Grudgebearer Lord-Captain"
	desc = "You are a Lord-Captain of Clan Lord Salak Kazhkz's Grudgebearer fleet - placed in command of a vessel and sent into the Badlands and the Sparring Sea to pillage and harass the enemies of the Empire and the Kazhkz-Han'san. Vessels of the Serene Republic of Elyra, the Coalition of Colonies, and the Izweski Hegemony are particularly prized targets by the Kazhkz. NOT AN ANTAGONIST! Do not act as such."
	tags = list("External")
	mob_name_suffix = " Kazhkz"
	mob_name_pick_message = "Pick an Unathi first name."
	spawnpoints = list("kazhkz_privateer_captain")
	max_count = 1
	assigned_role = "Kazhkz Privateer Captain"
	special_role = "Kazhkz Privateer Captain"
	welcome_message = "You are a privateer of the Grudgebearers, the pirate fleet of Clan Kazhkz - a plausibly deniable weapon of the Empire of Dominia, sent to scourge the Emperor's enemies in the Badlands. Though the two nations are not enemies, the Kazhkz hold a particular hatred of the Izweski Hegemony, and will often attack their merchant vessels. The Unathi in Dominia wiki page may have some useful information for roleplaying a Kazhkz privateer."
	uses_species_whitelist = TRUE
	outfit = /obj/outfit/admin/kazhkz_privateer/captain

/obj/outfit/admin/kazhkz_privateer/captain
	name = "Kazhkz Privateer Captain"
	uniform = /obj/item/clothing/under/dominia/imperial_suit/kazhkz
	suit = /obj/item/clothing/suit/storage/dominia/coat
	gloves = /obj/item/clothing/ring/seal
	belt = /obj/item/clothing/accessory/holster/waist/brown
	back = /obj/item/storage/backpack/satchel/leather

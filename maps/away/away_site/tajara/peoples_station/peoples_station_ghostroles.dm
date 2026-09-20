// Kosmostrelki - Elite crew of the PRA's Orbital Fleet
/datum/ghostspawner/human/prss_kosmostrelki
	short_name = "prss_kosmostrelki"
	name = "People's Republic Space Station Kosmostrelki"
	desc = "Crew an Orbital Fleet ship."
	tags = list("External")

	spawnpoints = list("prss_kosmostrelki")
	max_count = 5

	outfit = /obj/outfit/admin/prss_kosmostrelki
	possible_species = list(SPECIES_TAJARA, SPECIES_TAJARA_MSAI, SPECIES_TAJARA_ZHAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "PRSS Kosmostrelkiiye Security Battalion"
	special_role = "PRSS Orbital Fleet Kosmostrelki-Dranalket"
	mob_name_prefix = "Dkt. "

	uses_species_whitelist = FALSE
	extra_languages = list(LANGUAGE_SIIK_MAAS)

/obj/outfit/admin/prss_kosmostrelki
	name = "People's Republic Space Station Kosmostrelki"

	id = /obj/item/card/id
	l_ear = /obj/item/radio/headset/ship
	shoes = /obj/item/clothing/shoes/jackboots/tajara
	uniform = /obj/item/clothing/under/tajaran/cosmonaut
	accessory = /obj/item/clothing/accessory/badge/pra_passport
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	gloves = /obj/item/clothing/gloves/black_leather/tajara
	back = /obj/item/storage/backpack/satchel/eng
	backpack_contents = list(/obj/item/storage/box/survival = 1, /obj/item/clothing/accessory/badge/hadii_card = 1)

	r_pocket = /obj/item/storage/wallet/random
	l_hand = /obj/item/martial_manual/tajara

/obj/outfit/admin/prss_kosmostrelki/get_id_access()
	return list(/datum/access/pra::id, /datum/access/external_airlocks::id)
// ------------

// Kosmostrelki Commander - Orbital Fleet Commander in official and operational command of the People's Space Station
/datum/ghostspawner/human/prss_kosmostrelki/captain
	short_name = "pss_commander"
	name = "People's Republic Space Station Commander"
	desc = "Command an Orbital Fleet ship."

	spawnpoints = list("prss_kosmostrelki")
	max_count = 1

	outfit = /obj/outfit/admin/prss_kosmostrelki
	possible_species = list(SPECIES_TAJARA, SPECIES_TAJARA_MSAI)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "PRSS Installation Command"
	special_role = "PRSS Orbital Fleet Installation Zarkir"
	mob_name_prefix = "Zkr. "

	uses_species_whitelist = FALSE
	extra_languages = list(LANGUAGE_SIIK_MAAS)

/obj/outfit/admin/prss_kosmostrelki/captain
	name = "People's Republic Space Station Commander"

	head = /obj/item/clothing/head/tajaran/orbital_captain
	uniform = /obj/item/clothing/under/tajaran/cosmonaut/captain
	back = /obj/item/storage/backpack/satchel/leather

	l_pocket = /obj/item/clothing/wrists/watch/pocketwatch/adhomai

// Party Commissar - High-ranking party commissar attached to the Kosmostrelki unit and ship to ensure the loyalty of the crew.
/datum/ghostspawner/human/prss_kosmostrelki/commissar
	short_name = "prss_commissar"
	name = "People's Republic Space Station Party Commissar"
	desc = "Ensure that the Kosmostrelki follow the principles of Hadiism."

	spawnpoints = list("prss_kosmostrelki")
	max_count = 1

	outfit = /obj/outfit/admin/prss_kosmostrelki/commissar
	possible_species = list(SPECIES_TAJARA, SPECIES_TAJARA_MSAI)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "PRSS Party Oversight Committee"
	special_role = "PRSS Orbital Fleet Parizahra Mahmahdar"
	mob_name_prefix = "Mhr. "

	uses_species_whitelist = TRUE
	extra_languages = list(LANGUAGE_SIIK_MAAS)

/obj/outfit/admin/prss_kosmostrelki/commissar

	name = "People's Republic Space Station Party Commissar"

	uniform = /obj/item/clothing/under/tajaran/cosmonaut/commissar
	accessory = /obj/item/clothing/accessory/hadii_pin
	head = /obj/item/clothing/head/tajaran/cosmonaut_commissar
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/hadii_manifesto = 1,
						/obj/item/storage/box/hadii_card = 1,
						/obj/item/clothing/accessory/badge/hadii_card/member = 1,
						/obj/item/clothing/accessory/badge/pra_passport = 1,
						)
	l_pocket = /obj/item/clothing/wrists/watch/pocketwatch/adhomai

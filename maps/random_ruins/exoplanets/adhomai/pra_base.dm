/datum/map_template/ruin/exoplanet/pra_base
	name = "PRA Military Outpost"
	id = "pra_base"
	description = "A military outpost manned by the Grand People's Army."

	spawn_weight = 1
	spawn_cost = 2
	template_flags = TEMPLATE_FLAG_NO_RUINS|TEMPLATE_FLAG_RUIN_STARTS_DISALLOWED
	sectors = list(SECTOR_SRANDMARR)

	prefix = "adhomai/"
	suffix = "pra_base.dmm"

	unit_test_groups = list(1)

/area/pra_base
	name = "PRA Military Outpost"
	icon_state = "bluenew"
	requires_power = FALSE
	no_light_control = FALSE
	base_turf = /turf/simulated/floor/exoplanet/mineral/adhomai
	area_flags = AREA_FLAG_RAD_SHIELDED
	area_blurb = "A Hadiist Army outpost. The People's Republic of Adhomai's anthem is blared from the speakers."

//ghost roles

/datum/ghostspawner/human/pra_army_outpost_trooper
	short_name = "pra_army_trooper"
	name = "Grand People's Army Trooper"
	desc = "Man the Republican Army outpost on Adhomai."
	tags = list("External")

	spawnpoints = list("pra_army_soldier")
	max_count = 4

	extra_languages = list(LANGUAGE_SIIK_MAAS)
	outfit = /obj/outfit/admin/pra_army_outpost/trooper
	possible_species = list(SPECIES_TAJARA,SPECIES_TAJARA_MSAI, SPECIES_TAJARA_ZHAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Grand People's Army Trooper"
	special_role = "Grand People's Army Trooper"
	mob_name_prefix = "Nkt. "
	respawn_flag = null
	uses_species_whitelist = FALSE

/obj/outfit/admin/pra_army_outpost/trooper
	name = "People's Republic of Adhomai Soldier"

	uniform = /obj/item/clothing/under/tajaran/pra_uniform
	head = /obj/item/clothing/head/beret/tajaran/pra
	suit = /obj/item/clothing/suit/storage/tajaran/pra_jacket/armored
	back = /obj/item/storage/backpack/rucksack/green
	shoes = /obj/item/clothing/shoes/workboots/tajara/dark
	belt = /obj/item/storage/belt/military
	l_ear = /obj/item/radio/headset/ship

	id = /obj/item/card/id
	r_pocket = /obj/item/storage/wallet/random_adhomian_knuckle

/obj/outfit/admin/pra_base/get_id_access()
	return list(/datum/access/pra::id)

/datum/ghostspawner/human/pra_army_outpost_trooper/commissar
	short_name = "pra_army_commissar"
	name = "Grand People's Army Commissar"
	desc = "Ensure that the forces in the People's Republic outpost follows the principles of Hadiism."

	spawnpoints = list("pra_army_commissar")
	max_count = 1

	outfit = /obj/outfit/admin/pra_army_outpost/commissar
	possible_species = list(SPECIES_TAJARA,SPECIES_TAJARA_MSAI)
	uses_species_whitelist = TRUE

	assigned_role = "Grand People's Army Commissar"
	special_role = "Grand People's Army Commissar"
	mob_name_prefix = "Kzn. "

/obj/outfit/admin/pra_army_outpost/commissar
	name = "Grand People's Army Commissar"

	uniform = /obj/item/clothing/under/tajaran/army_commissar
	accessory = list(
		/obj/item/clothing/accessory/tajaran/pra_brooch,
		/obj/item/clothing/accessory/hadii_pin,
		/obj/item/clothing/accessory/tajaran/hadii_badge/gold
	)
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	head = /obj/item/clothing/head/tajaran/army_commissar
	suit = /obj/item/clothing/suit/storage/toggle/tajaran/consular
	belt = null
	belt_contents = null
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
						/obj/item/material/knife/trench = 1,
						/obj/item/clothing/accessory/badge/hadii_card/member = 1,
						/obj/item/storage/box/hadii_manifesto = 1,
						/obj/item/storage/box/hadii_card = 1,
						/obj/item/clothing/accessory/badge/pra_passport
						)
	l_hand = /obj/item/megaphone

/datum/map_template/ruin/exoplanet/nka_base
	name = "NKA Military Outpost"
	id = "nka_base"
	description = "A military outposted manned by the New Kingdom Royal Army."

	spawn_weight = 1
	ship_cost = 2
	template_flags = TEMPLATE_FLAG_NO_RUINS|TEMPLATE_FLAG_RUIN_STARTS_DISALLOWED
	sectors = list(SECTOR_SRANDMARR)

	prefix = "adhomai/"
	suffix = "nka_base.dmm"

	unit_test_groups = list(3)

/area/nka_base
	name = "NKA Military Outpost"
	icon_state = "bluenew"
	requires_power = FALSE
	no_light_control = FALSE
	base_turf = /turf/simulated/floor/exoplanet/mineral/adhomai
	area_flags = AREA_FLAG_RAD_SHIELDED
	area_blurb = "A Royal Army outpost. The installations appear to be precarious."

/obj/item/key/door_key/nka_base
	name = "Imperial Adhomian Army Outpost Key"
	access_list = list(/datum/access/nka_trooper)

/obj/item/key/door_key/nka_base/officer
	name = "Officers Quarters Key"
	access_list = list(/datum/access/nka_officer)

//						//
//	--- GHOSTROLES ---	//
//						//

// Trooper
/datum/ghostspawner/human/nka_base
	short_name = "nka_base_trooper"
	name = "Imperial Adhomian Army Soldier"
	desc = "Man the New Kingdom outpost in Adhomai."
	tags = list("External")

	spawnpoints = list("nka_base_trooper")
	max_count = 4

	extra_languages = list(LANGUAGE_SIIK_MAAS)
	outfit = /obj/outfit/admin/nka_base/trooper
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI,
		SPECIES_TAJARA_ZHAN
	)
	uses_species_whitelist = FALSE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Imperial Adhomian Army Rhaz'Zirmroii"
	special_role = "Imperial Adhomian Army Rhaz'Zirmroii"
	faction = "NKA"
	mob_name_prefix = "Nkt. " // Nalket - Trooper
	respawn_flag = null

	recognition_group = "nka_base"
	recognition_message = "You recognise this person as one of the troopers posted at the outpost."

/obj/outfit/admin/nka_base/trooper
	name = "Imperial Adhomian Army Rhaz'Zirmroii"

	uniform = /obj/item/clothing/under/tajaran/nka_uniform
	suit = null
	belt = null
	gloves = null
	wrist = null
	pants = null
	shoes = /obj/item/clothing/shoes/workboots/tajara/dark

	head = /obj/item/clothing/head/tajaran/nka_cap
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = null
	r_ear = null
	glasses = null

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = /obj/item/radio

	l_hand = null
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/nka_passport
		/obj/item/key/door_key/nka_base
	)

/obj/outfit/admin/nka_base/trooper/get_id_access()
	return list(
		/datum/access/nka::id,
		/datum/access/nka_trooper::id
	)
// -------------

// Royal Grenadier
/datum/ghostspawner/human/nka_base/grenadier
	short_name = "nka_base_grenadier"
	name = "Imperial Adhomian Army Royal Grenadier"
	desc = "Man the New Kingdom outpost in Adhomai."
	tags = list("External")

	spawnpoints = list("nka_base_grenadier")
	max_count = 1

	extra_languages = list(LANGUAGE_SIIK_MAAS)
	outfit = /obj/outfit/admin/nka_base/trooper
	possible_species = list(
		SPECIES_TAJARA_ZHAN
	)
	uses_species_whitelist = FALSE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Imperial Adhomian Army Rhaz'Zirmroii"
	special_role = "Imperial Adhomian Army Rhaz'Zirmroii"
	faction = "NKA"
	mob_name_prefix = "Mka. " // Mirmrroka - Lead Trooper
	respawn_flag = null

	recognition_group = "nka_base"
	recognition_message = "You recognise this person as one of the Royal Grenadiers posted at the outpost."
// -------------

// Royal Grenadier
/datum/ghostspawner/human/nka_base/grenadier
	short_name = "nka_base_grenadier"
	name = "Imperial Adhomian Army Royal Grenadier"
	desc = "Man the New Kingdom outpost in Adhomai."
	tags = list("External")

	spawnpoints = list("nka_base_grenadier")
	max_count = 1

	extra_languages = list(LANGUAGE_SIIK_MAAS)
	outfit = /obj/outfit/admin/nka_base/trooper
	possible_species = list(
		SPECIES_TAJARA_ZHAN
	)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Imperial Adhomian Army Rhaz'Zirmroii"
	special_role = "Imperial Adhomian Army Rhaz'Zirmroii"
	faction = "NKA"
	mob_name_prefix = "Mka. " // Mirmrroka - Lead Trooper
	respawn_flag = null

	recognition_group = "nka_base"
	recognition_message = "You recognise this person as one of the Royal Grenadiers posted at the outpost."
// -------------

// Outpost Marshal
/datum/ghostspawner/human/nka_base/officer
	short_name = "nka_base_officer"
	name = "Imperial Adhomian Army Kazarr'Akhran"
	desc = "Man the New Kingdom outpost in Adhomai."
	tags = list("External")

	spawnpoints = list("nka_base_officer")
	max_count = 1

	extra_languages = list(LANGUAGE_SIIK_MAAS)
	outfit = /obj/outfit/admin/nka_base/officer
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI
	)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Imperial Adhomian Army Kazarr'Akhran"
	special_role = "Imperial Adhomian Army Kazarr'Akhran"
	faction = "NKA"
	mob_name_prefix = "Qkn. " // Qarakhran - Marshal
	respawn_flag = null

	recognition_group = "nka_base"
	recognition_message = "You recognise this person as the Marshal of your unit and the outpost."

/obj/outfit/admin/nka_base/officer
	name = "Imperial Adhomian Army Kazarr'Akhran"

	uniform = /obj/item/clothing/under/tajaran/nka_uniform/commander
	suit = null
	belt = /obj/item/material/knife/trench
	gloves = /obj/item/clothing/gloves/white/tajara/dress
	wrist = /obj/item/clothing/wrists/watch/pocketwatch/adhomai
	pants = null
	shoes = /obj/item/clothing/shoes/jackboots/tajara/cavalry
	head = /obj/item/clothing/head/tajaran/nka_cap/commander
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = null
	r_ear = null
	glasses = /obj/item/clothing/glasses/sunglasses/aviator

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = /obj/item/radio

	l_hand = null
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/nka_passport,
		/obj/item/key/door_key/nka_base,
		/obj/item/key/door_key/nka_base/officer,
		/obj/item/ammo_magazine/c38 = 2,
	)

/obj/outfit/admin/nka_base/commander/get_id_access()
	return list(
		/datum/access/nka::id,
		/datum/access/nka_trooper::id,
		/datum/access/nka_officer::id
	)
// -------------

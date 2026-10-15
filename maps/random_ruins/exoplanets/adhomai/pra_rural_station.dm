/datum/map_template/ruin/exoplanet/pra_rural_station
	name = "PRA Rural Station"
	id = "pra_rural_station"
	description = "An advanced outpost of the People's Republic of Adhomai's intelligence service."

	spawn_weight = 1
	spawn_cost = 2
	template_flags = TEMPLATE_FLAG_NO_RUINS|TEMPLATE_FLAG_RUIN_STARTS_DISALLOWED
	sectors = list(SECTOR_SRANDMARR)

	prefix = "adhomai/"
	suffix = "pra_rural_station.dmm"

	unit_test_groups = list(3)

/area/pra_rural_station
	name = "PRA Rural Station"
	icon_state = "bluenew"
	requires_power = FALSE
	no_light_control = FALSE
	base_turf = /turf/simulated/floor/exoplanet/mineral/adhomai
	area_flags = AREA_FLAG_RAD_SHIELDED
	ambience = AMBIENCE_HIGHSEC
	area_blurb = "You feel watched inside this ominous compound."

//ghost roles

/datum/ghostspawner/human/pra_rural_station/npd_trooper
	short_name = "npd_trooper"
	name = "PRA National Police Department Trooper"
	desc = "Man the New Kingdom outpost in Adhomai."
	tags = list("External")

	spawnpoints = list("npd_trooper")
	max_count = 4

	extra_languages = list(LANGUAGE_SIIK_MAAS)
	outfit = /obj/outfit/admin/pra_rural_station/npd_trooper
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI,
		SPECIES_TAJARA_ZHAN
	)
	uses_species_whitelist = FALSE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "PRA National Police Department Trooper"
	special_role = "NPD Senior Trooper (PRA)"
	faction = "PRA"
	mob_name_prefix = "Rkt. " // Rhazket - Senior Trooper
	respawn_flag = null

	recognition_group = "pra_rural_station"
	recognition_message = "You recognise this person as an NPD Trooper from your local station."

/obj/outfit/admin/pra_rural_station/npd_trooper
	name = "PRA National Police Department Trooper"

	uniform = /obj/item/clothing/under/tajaran/pra_cop/rural
	accessory = /obj/item/clothing/accessory/holster/waist
	accessory_contents = list(
		/obj/item/gun/projectile/pistol/adhomai
	)
	suit = /obj/item/clothing/suit/storage/tajaran/pra_cop/rural
	gloves = /obj/item/clothing/gloves/black_leather/tajara
	wrist = /obj/item/clothing/wrists/watch/pocketwatch/adhomai
	pants = null
	shoes = /obj/item/clothing/shoes/jackboots/tajara/cavalry

	head = null
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = /obj/item/radio/headset/ship
	r_ear = /obj/item/pen/multi
	glasses = /obj/item/clothing/glasses/sunglasses/aviator

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = /obj/item/taperecorder

	l_hand = null
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/pra_passport,
		/obj/item/clothing/head/tajaran/pra_cop/rural,
		/obj/item/clothing/head/tajaran/pra_cop/winter,
		/obj/item/material/knife/trench,
	)

	belt = /obj/item/storage/belt/security/tactical
	belt_contents = list(
		/obj/item/flash,
		/obj/item/megaphone/sec,
		/obj/item/camera/adhomai,
		/obj/item/journal/notepad/filled/security,
		/obj/item/melee/classic_baton,
		/obj/item/crowbar/rescue_axe/tactical,
		/obj/item/ammo_magazine/c9mm = 2,
		/obj/item/handcuffs = 2,
		/obj/item/gun/energy/taser
	)

/obj/outfit/admin/pra_rural_station/npd_trooper/get_id_access()
	return list(/datum/access/pra::id)

/datum/ghostspawner/human/pra_rural_station/psis_agent
	short_name = "psis_agent"
	name = "PRA People's Strategic Intelligence Service Agent"
	desc = "Man the New Kingdom outpost in Adhomai."
	tags = list("External")

	spawnpoints = list("psis_agent")
	max_count = 2

	extra_languages = list(
		LANGUAGE_SIIK_MAAS,
		LANGUAGE_SIIK_TAJR
		)
	outfit = /obj/outfit/admin/pra_rural_station/psis_agent
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI,
		SPECIES_TAJARA_ZHAN
	)
	uses_species_whitelist = TRUE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "PRA People's Strategic Intelligence Service Agent"
	special_role = "PSIS Agent (PRA)"
	faction = "PRA"
	mob_name_prefix = "Vzr. " // Vrezhnar - Agent
	respawn_flag = null

	recognition_group = "pra_rural_station"
	recognition_message = "You recognise this person as one of the agents from the PSIS office at your local station."

/obj/outfit/admin/pra_rural_station/psis_agent
	name = "PRA People's Strategic Intelligence Service Agent"

	uniform = /obj/item/clothing/under/tajaran/psis
	accessory = list(
		/obj/item/clothing/accessory/hadii_pin,
		/obj/item/clothing/accessory/medal/pra_courage,
		/obj/item/clothing/accessory/tajaran/pra_brooch
	)
	suit = null
	gloves = /obj/item/clothing/gloves/black_leather/tajara
	wrist = /obj/item/clothing/wrists/watch/pocketwatch/adhomai
	pants = null
	shoes = /obj/item/clothing/shoes/jackboots/tajara/cavalry

	head = /obj/item/clothing/head/tajaran/psis
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = /obj/item/radio/headset/ship
	r_ear = /obj/item/pen/fountain/black
	glasses = /obj/item/clothing/glasses/sunglasses/aviator

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = /obj/item/versebook/pra

	l_hand = /obj/item/martial_manual/tajara
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/pra_passport,
		/obj/item/clothing/accessory/badge/hadii_card/member,
		/obj/item/material/knife/trench,
		/obj/item/clothing/accessory/holster/waist,
		/obj/item/gun/projectile/deagle/adhomai,
		/obj/item/reagent_containers/pill/cyanide
	)

	belt = /obj/item/storage/belt/security/tactical
	belt_contents = list(
		/obj/item/flash,
		/obj/item/taperecorder,
		/obj/item/camera/adhomai,
		/obj/item/journal/notepad/filled/security,
		/obj/item/melee/baton/stunrod,
		/obj/item/crowbar/rescue_axe/tactical,
		/obj/item/ammo_magazine/a50 = 2,
		/obj/item/handcuffs/ziptie = 2,
		/obj/item/gun/energy/stunrevolver
	)

/obj/outfit/admin/pra_rural_station/psis_agent/get_id_access()
	return list(/datum/access/pra::id)

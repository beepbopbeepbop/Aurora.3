// Trooper
/datum/ghostspawner/human/pra_base_trooper
	short_name = "pra_base_trooper"
	name = "Grand People's Army Rhaz'Zirmroii"
	desc = "Man the Republican Army outpost on Adhomai."
	tags = list("External")

	spawnpoints = list("pra_base_trooper")
	max_count = 3

	extra_languages = list(LANGUAGE_SIIK_MAAS)
	outfit = /obj/outfit/admin/pra_base/trooper
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI,
		SPECIES_TAJARA_ZHAN
	)
	uses_species_whitelist = FALSE
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "GPASRF Base 611-5748 - Security Troops Battalion"
	special_role = "Grand People's Army Rhaz'Zirmroii"
	faction = "PRA"
	mob_name_prefix = "Nkt. " // Nalket - Trooper
	respawn_flag = null

	recognition_group = "pra_base"
	recognition_message = "You recognise this person as one of the Security Battalion Troopers assigned to the base."

/obj/outfit/admin/pra_base/trooper
	name = "Grand People's Army Rhaz'Zirmroii"

	uniform = /obj/item/clothing/under/tajaran/pra_trooper
	suit = /obj/item/clothing/suit/storage/tajaran/pra_jacket/armored
	belt = null
	gloves = null
	wrist = null
	pants = null
	shoes = /obj/item/clothing/shoes/workboots/tajara/dark

	head = /obj/item/clothing/head/beret/tajaran/pra
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = /obj/item/radio/headset/ship
	r_ear = null
	glasses = null

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = null

	l_hand = /obj/item/martial_manual/tajara
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/rucksack/green
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/pra_passport
	)

/obj/outfit/admin/pra_base/get_id_access()
	return list(/datum/access/pra::id)
// -------------

// NCO
/datum/ghostspawner/human/pra_base_trooper/nco
	short_name = "pra_base_nco"
	name = "Grand People's Army Kra'Zirmroii"
	desc = "Ensure that the forces in the People's Republic outpost follows the principles of Hadiism."

	spawnpoints = list("pra_base_nco")
	max_count = 1

	outfit = /obj/outfit/admin/pra_base/nco
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI,
		SPECIES_TAJARA_ZHAN
	)
	uses_species_whitelist = FALSE

	assigned_role = "GPASRF Base 611-5748 - Security Troops Battalion"
	special_role = "Grand People's Kra'Zirmroii"
	faction = "PRA"
	mob_name_prefix = "Mka. " // Mirmrroka - Lead Trooper
	respawn_flag = null

	recognition_group = "pra_base"
	recognition_message = "You recognise this person as the lead Security Battalion Trooper assigned to the base."

/obj/outfit/admin/pra_base/nco
	name = "Grand People's Army Kra'Zirmroii"

	uniform = /obj/item/clothing/under/tajaran/pra_trooper
	suit = /obj/item/clothing/suit/storage/tajaran/pra_jacket/armored
	belt = null
	gloves = null
	wrist = null
	pants = null
	shoes = /obj/item/clothing/shoes/workboots/tajara/dark

	head = /obj/item/clothing/head/beret/tajaran/pra
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = /obj/item/radio/headset/ship
	r_ear = null
	glasses = null

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = null

	l_hand = /obj/item/martial_manual/tajara
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/rucksack/green
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/hadii_card,
		/obj/item/clothing/accessory/badge/pra_passport
	)
// -------------

// Specialist
/datum/ghostspawner/human/pra_base_trooper/spec
	short_name = "pra_base_spec"
	name = "Grand People's Army Specialist"
	desc = "You are either a missile engineer, military doctor, or PAF gunship pilot."

	spawnpoints = list("pra_base_spec")
	max_count = 1

	outfit = /obj/outfit/admin/pra_base/spec
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI,
	)
	uses_species_whitelist = FALSE

	assigned_role = "GPASRF Base 611-5748 - Missile Trooper"
	special_role = "Grand People's Kra'Zirmroii"
	faction = "PRA"
	mob_name_prefix = "Dkt. " // Dranalket - Specialist Trooper
	respawn_flag = null

	recognition_group = "pra_base"
	recognition_message = "You recognise this person as one of the military staff assigned to the base."

/obj/outfit/admin/pra_base/spec
	name = "Grand People's Army Specialist"

	uniform = /obj/item/clothing/under/tajaran/pra_trooper
	suit = /obj/item/clothing/suit/storage/tajaran/pra_jacket/armored
	belt = null
	gloves = null
	wrist = null
	pants = null
	shoes = /obj/item/clothing/shoes/workboots/tajara/dark

	head = /obj/item/clothing/head/beret/tajaran/pra
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = /obj/item/radio/headset/ship
	r_ear = null
	glasses = null

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = null

	l_hand = /obj/item/martial_manual/tajara
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/rucksack/green
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/hadii_card,
		/obj/item/clothing/accessory/badge/pra_passport
	)
// -------------

// Officer
/datum/ghostspawner/human/pra_base_trooper/officer
	short_name = "pra_army_officer"
	name = "Grand People's Army Kazarr'Akhran"
	desc = "Ensure that the forces in the People's Republic outpost follows the principles of Hadiism."

	spawnpoints = list("pra_base_officer")
	max_count = 1

	outfit = /obj/outfit/admin/pra_base/officer
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI
	)
	uses_species_whitelist = TRUE

	assigned_role = "GPASRF Base 611-5748 - Missile Commander"
	special_role = "Grand People's Army Kazarr'Akhran"
	faction = "PRA"
	mob_name_prefix = "Zkr. " // Zarkir - Captain
	respawn_flag = null

	recognition_group = "pra_base"
	recognition_message = "You recognise this person as the military commander of the base."

/obj/outfit/admin/pra_base/officer
	name = "Grand People's Army Kazarr'Akhran"

	uniform = /obj/item/clothing/under/tajaran/pra_officer
	suit = /obj/item/clothing/suit/storage/toggle/tajaran/pra_greatcoat
	belt = /obj/item/material/knife/trench
	gloves = /obj/item/clothing/gloves/white/tajara/dress
	wrist = null
	pants = null
	shoes = /obj/item/clothing/shoes/jackboots/tajara/cavalry

	head = /obj/item/clothing/head/tajaran/pra_officer
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = /obj/item/radio/headset/ship
	r_ear = null
	glasses = /obj/item/clothing/glasses/sunglasses/aviator

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = /obj/item/versebook/pra

	l_hand = /obj/item/martial_manual/tajara
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/hadii_card,
		/obj/item/clothing/accessory/badge/pra_passport
	)
// -------------

// Commissar
/datum/ghostspawner/human/pra_base_trooper/commissar
	short_name = "pra_base_commissar"
	name = "Grand People's Army Political Commissar"
	desc = "Ensure that the forces in the People's Republic outpost follows the principles of Hadiism."

	spawnpoints = list("pra_base_commissar")
	max_count = 1

	outfit = /obj/outfit/admin/pra_base/commissar
	possible_species = list(
		SPECIES_TAJARA,
		SPECIES_TAJARA_MSAI
	)
	uses_species_whitelist = TRUE

	assigned_role = "GPASRF Base 611-5748 - Political Commissar"
	special_role = "Grand People's Army Political Commissar"
	faction = "PRA"
	mob_name_prefix = "Cmr. " // Commissar - TBD
	respawn_flag = null

	recognition_group = "pra_base"
	recognition_message = "You recognise this person as the political commissar of the base."

/obj/outfit/admin/pra_base/commissar
	name = "Grand People's Army Political Commissar"

	uniform = /obj/item/clothing/under/tajaran/pra_commissar
	suit = /obj/item/clothing/suit/storage/toggle/tajaran/pra_greatcoat/commissar
	belt = /obj/item/material/knife/trench
	gloves = /obj/item/clothing/gloves/white/tajara/dress
	wrist = null
	pants = null
	shoes = /obj/item/clothing/shoes/jackboots/tajara/cavalry

	head = /obj/item/clothing/head/tajaran/pra_commissar
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	l_ear = /obj/item/radio/headset/ship
	r_ear = null
	glasses = /obj/item/clothing/glasses/sunglasses/aviator

	l_pocket = /obj/item/storage/wallet/random_adhomian_knuckle
	r_pocket = /obj/item/versebook/pra

	l_hand = /obj/item/martial_manual/tajara
	r_hand = null

	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/firstaid/light/offship,
		/obj/item/clothing/accessory/badge/hadii_card/member,
		/obj/item/clothing/accessory/badge/pra_passport
	)
// -------------

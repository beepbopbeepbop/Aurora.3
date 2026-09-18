#define CREVUS_GENERIC_SPECIES list(\
	SPECIES_TAJARA, \
	SPECIES_TAJARA_ZHAN, \
	SPECIES_TAJARA_MSAI, \
)

// ---------- Chef

/datum/ghostspawner/human/crevus_chef
	short_name = "crevus_chef"
	name = "Nikal'n Marr Diner Chef"
	desc = "Run Nikal'n Marr Diner's kitchen, cook whatever your guests request. Complain when your guests know all about pacojet."
	tags = list("External")
	spawnpoints = list("crevus_chef")
	max_count = 2
	outfit = /obj/outfit/admin/crevus/chef
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Nikal'n Marr Diner Chef"
	special_role = "Nikal'n Marr Diner Chef"
	respawn_flag = null

/obj/outfit/admin/crevus/chef
	name = "Crevus Chef"
	uniform = /obj/item/clothing/under/rank/chef
	suit = /obj/item/clothing/suit/chef_jacket/nt
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm
	)

// ---------- Attendant

/datum/ghostspawner/human/crevus_attendant
	short_name = "crevus_attendant"
	name = "Nikal'n Marr Diner Attendant"
	desc = "Serve the guests of Nikal'n Marr Diner, either run the bar or serve the orders - or do both. Give dead eye to the non-tippers."
	tags = list("External")
	spawnpoints = list("crevus_attendant")
	max_count = 2
	outfit = /obj/outfit/admin/crevus/attendant
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Nikal'n Marr Diner Attendant"
	special_role = "Nikal'n Marr Diner Attendant"
	respawn_flag = null

/obj/outfit/admin/crevus/attendant
	name = "Crevus Attendant"
	uniform = /obj/item/clothing/under/tajaran/fancy
	gloves = /obj/item/clothing/gloves/white
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	r_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id
	backpack_contents = list(
		/obj/item/storage/box/fancy/candle_box,
		/obj/item/flame/lighter/zippo,
		/obj/item/journal/notepad/filled,
		/obj/item/pen/black,
		/obj/item/clothing/accessory/temperature/warm
	)

	species_gloves = list(
		SPECIES_TAJARA = /obj/item/clothing/gloves/white/tajara,
		SPECIES_TAJARA_MSAI = /obj/item/clothing/gloves/white/tajara,
		SPECIES_TAJARA_ZHAN = /obj/item/clothing/gloves/white/tajara,
	)


// ---------- General Store Vendor

/datum/ghostspawner/human/crevus_general_store_vendor
	short_name = "crevus_general_store_vendor"
	name = "Ane-Mart Vendor"
	desc = "Run the general store, maybe stock the shelves, hope that shoplifting will be the worst thing you'll have to deal with today."
	tags = list("External")
	spawnpoints = list("crevus_general_store_vendor")
	max_count = 1
	outfit = /obj/outfit/admin/crevus/generic_vendor/general_store
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Ane-Mart Vendor"
	special_role = "Ane-Mart Vendor"
	respawn_flag = null

/obj/outfit/admin/crevus/generic_vendor
	name = "Generic Vendor"
	uniform = /obj/item/clothing/under/dressshirt
	pants = list(
		/obj/item/clothing/pants/jeans,
		/obj/item/clothing/pants/jeansblack,
		/obj/item/clothing/pants/mustang,
		/obj/item/clothing/pants/black,
		/obj/item/clothing/pants/designer
	)
	suit = /obj/item/clothing/suit/jacket/puffer
	shoes = list(
		/obj/item/clothing/shoes/jackboots,
		/obj/item/clothing/shoes/workboots,
		/obj/item/clothing/shoes/workboots/dark
	)

	species_shoes = list(
		SPECIES_TAJARA = /obj/item/clothing/shoes/workboots/toeless/dark,
		SPECIES_TAJARA_MSAI = /obj/item/clothing/shoes/workboots/toeless/dark,
		SPECIES_TAJARA_ZHAN = /obj/item/clothing/shoes/workboots/toeless/dark,
	)
	r_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm
	)

/obj/outfit/admin/crevus/generic_vendor/general_store
	name = "Ane-Mart Vendor"
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/general_store
	)

/obj/outfit/admin/crevus/generic_vendor/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.w_uniform?.color = get_random_colour(lower = 150)
	H.w_uniform?.update_worn_icon()
	H.wear_suit?.color = get_random_colour(lower = 150)
	H.wear_suit?.update_worn_icon()

// ---------- Automobile Salesperson
/datum/ghostspawner/human/crevus_car_salesperson
	short_name = "crevus_car_salesperson"
	name = "Automobile Salesperson"
	desc = "\
	Find potential customers, introduce your automobiles, try not to be too obvious when you try to sell them very above the market price. \
	Bargain like the autonomy of your soul depends on it. \
	"
	tags = list("External")
	spawnpoints = list("crevus_car_salesperson")
	max_count = 1
	outfit = /obj/outfit/admin/crevus/car_salesperson
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Automobile Salesperson"
	special_role = "Automobile Salesperson"
	respawn_flag = null

/obj/outfit/admin/crevus/car_salesperson
	name = "Automobile Salesperson"
	uniform = /obj/item/clothing/under/tajaran/high_waisted/business
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm
	)

// ---------- Transit Centre Clerk

/datum/ghostspawner/human/crevus_clerk
	short_name = "crevus_clerk"
	name = "Transit Centre Clerk"
	desc = "\
	Welcome the guests, and more importantly the tourists, to the Free City of Crevus. Give them a brochure, run the gift shop. \
	Conduct tours, be subtle when you intentionally bring them to a gang's turf. \
	"
	tags = list("External")
	spawnpoints = list("crevus_clerk")
	max_count = 2
	outfit = /obj/outfit/admin/crevus/clerk
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Transit Centre Clerk"
	special_role = "Transit Centre Clerk"
	respawn_flag = null

/obj/outfit/admin/crevus/clerk
	name = "Transit Centre Clerk"
	uniform = /obj/item/clothing/under/dressshirt
	pants = /obj/item/clothing/pants/black
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/storage/wallet/random
	accessory = /obj/item/clothing/accessory/tie/black
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm
	)

// ---------- Clothing Store Vendor

/datum/ghostspawner/human/crevus_clothing_vendor
	short_name = "crevus_clothing_vendor"
	name = "Clothing Store Vendor"
	desc = "Display fashion, sell fashion and make fashion. Customize (recolour) your stock, don't let your customers see how you do it."
	tags = list("External")
	spawnpoints = list("crevus_clothing_vendor")
	max_count = 1
	outfit = /obj/outfit/admin/crevus/generic_vendor/clothing_store
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Clothing Store Vendor"
	special_role = "Clothing Store Vendor"
	respawn_flag = null

/obj/outfit/admin/crevus/generic_vendor/clothing_store
	name = "Clothing Store Vendor"
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/clothing_store
	)

// ---------- Firearm Salesperson

/datum/ghostspawner/human/crevus_firearm_salesperson
	short_name = "crevus_firearm_salesperson"
	name = "Firearm Salesperson"
	desc = "\
	Sell your guns, sell memberships for your shooting range at the downstairs. Educate people about firearm safety, show them how they're doing it wrong. \
	Brag about for how many generations your family ran this store. \
	"
	tags = list("External")
	spawnpoints = list("crevus_firearm_salesperson")
	max_count = 1
	outfit = /obj/outfit/admin/crevus/generic_vendor/firearm_salesperson
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Firearm Salesperson"
	special_role = "Firearm Salesperson"
	respawn_flag = null

/obj/outfit/admin/crevus/generic_vendor/firearm_salesperson
	name = "Firearm Salesperson"
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/firearm_store
	)

/obj/outfit/admin/crevus/generic_vendor/firearm_salesperson/get_id_access()
	return list(/datum/access/crevus_firearm_store)

// ---------- Artisan Shop Vendor

/datum/ghostspawner/human/crevus_artisan_shop_vendor
	short_name = "crevus_artisan_shop_vendor"
	name = "Artisan Shop Vendor"
	desc = "Sell your handmade goods and more. Advertise your liquor stock as a proud producer."
	tags = list("External")
	spawnpoints = list("crevus_artisan_shop_vendor")
	max_count = 1
	outfit = /obj/outfit/admin/crevus/generic_vendor/artisan_shop
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Artisan Shop Vendor"
	special_role = "Artisan Shop Vendor"
	respawn_flag = null

/obj/outfit/admin/crevus/generic_vendor/artisan_shop
	name = "Artisan Shop Vendor"
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/artisan_shop
	)


// ---------- NanoTrasen Pharmacist

/datum/ghostspawner/human/crevus_nt_pharmacist
	short_name = "crevus_nt_pharmacist"
	name = "NanoTrasen Pharmacist"
	desc = "\
	Sell medicine out of the pharmacy, be convinced to forget checking prescriptions for the right sum. \
	Produce drugs for any and every needs. Hope that the numbers at the end-of-month inventory report won't look too suspicious. \
	"
	tags = list("External")
	spawnpoints = list("crevus_nt_pharmacist")
	max_count = 1
	outfit = /obj/outfit/admin/crevus/nt_pharmacist
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "NanoTrasen Pharmacist"
	special_role = "NanoTrasen Pharmacist"
	respawn_flag = null

/obj/outfit/admin/crevus/nt_pharmacist
	name = "NanoTrasen Pharmacist"
	uniform = /obj/item/clothing/under/dressshirt
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/nt
	pants = /obj/item/clothing/pants/black
	shoes = list(
		/obj/item/clothing/shoes/jackboots,
		/obj/item/clothing/shoes/workboots,
		/obj/item/clothing/shoes/workboots/dark
	)

	species_shoes = list(
		SPECIES_TAJARA = /obj/item/clothing/shoes/workboots/toeless/dark,
		SPECIES_TAJARA_MSAI = /obj/item/clothing/shoes/workboots/toeless/dark,
		SPECIES_TAJARA_ZHAN = /obj/item/clothing/shoes/workboots/toeless/dark,
	)
	r_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/nt_pharmacy
	)

// ---------- Keltra Zav Nikal Casino Personnel

/datum/ghostspawner/human/crevus_casino_personnel
	short_name = "crevus_casino_personnel"
	name = "Keltra Zav Nikal Casino Personnel"
	desc = "Oversee the games, deal hands, take bets. Remember, the house always wins."
	tags = list("External")
	spawnpoints = list("crevus_casino_personnel")
	max_count = 2
	outfit = /obj/outfit/admin/crevus/casino
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Keltra Zav Nikal Personnel"
	special_role = "Keltra Zav Nikal Personnel"
	respawn_flag = null

/obj/outfit/admin/crevus/casino
	name = "Keltra Zav Nikal Casino Personnel"
	uniform = /obj/item/clothing/under/tajaran/fancy/evening_suit
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/casino
	)

// ---------- The Lock Attendant

/datum/ghostspawner/human/crevus_the_lock_attendant
	short_name = "crevus_the_lock_attendant"
	name = "The Lock Attendant"
	desc = "\
	You are a member of the Cult of Raskara, either in the Door and Key or King of Maggots group. You are responsible with running the current location of The Lock. \
	Provide a safe space for the other members and potential members to party in. Let the drugs and booze flow, try not to be discovered and uprooted too early. \
	"
	tags = list("External")
	spawnpoints = list("crevus_the_lock_attendant")
	recognition_group = "crevus_the_lock"
	recognition_message = "You recognize this person as a fellow member of the Cult of Raskara, an attendant of The Lock like you."
	max_count = 2
	outfit = /obj/outfit/admin/crevus/generic_vendor/the_lock
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "The Lock Attendant"
	special_role = "The Lock Attendant"
	respawn_flag = null

/obj/outfit/admin/crevus/generic_vendor/the_lock
	backpack_contents = list(
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/the_lock
	)

// ---------- Rhan-Cresh Highway Patrolman

/datum/ghostspawner/human/crevus_rhan_cresh_patrol
	short_name = "crevus_rhan_cresh_patrol"
	name = "Rhan-Cresh Highway Patrolman"
	desc = "\
	You are an enforcer of the Rhan-Cresh Charities' Highway Patrol. Walk the streets and look tough. Make sure none of those pesky gangers disrupt the spaceport. \
	Make sure the gun shop is paying its donation to the Charity. Get into a scuffle with Azaula goons to keep these streets yours. \
	"
	tags = list("External")
	spawnpoints = list("crevus_rhan_cresh_patrol")
	recognition_group = "crevus_rhan_cresh_patrol"
	recognition_message = "You recognize this person as a fellow enforcer of Rhan-Cresh Charities' Highway Patrol."
	max_count = 2
	outfit = /obj/outfit/admin/crevus/rhan_cresh_patrol
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Rhan-Cresh Highway Patrolman"
	special_role = "Rhan-Cresh Highway Patrolman"
	respawn_flag = null

/obj/outfit/admin/crevus/rhan_cresh_patrol
	name = "Rhan-Cresh Highway Patrolman"
	uniform = list(
		/obj/item/clothing/under/suit_jacket/charcoal,
		/obj/item/clothing/under/tajaran/high_waisted/business
	)
	suit = /obj/item/clothing/suit/storage/toggle/greatcoat/recolor
	glasses = /obj/item/clothing/glasses/sunglasses/visor
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id
	l_pocket = /obj/item/storage/wallet/random
	r_pocket = /obj/item/journal/notepad/filled
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/flashlight/maglight,
		/obj/item/clothing/accessory/holster/waist/brown,
		/obj/item/gun/projectile/revolver/adhomian,
		/obj/item/ammo_magazine/c38 = 3,
		/obj/item/crowbar/red,
		/obj/item/pen/black,
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/key/door_key/crevus/rhan_cresh_patrol
	)

/obj/outfit/admin/crevus/rhan_cresh_patrol/get_id_access()
	return list(/datum/access/crevus_rhan_cresh)

/obj/outfit/admin/crevus/rhan_cresh_patrol/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.wear_suit?.color = "#736258"
	H.wear_suit?.accent_color = "#C0C0C0"
	H.wear_suit?.update_worn_icon()

// ---------- Azaula Entertainment Enforcers

/datum/ghostspawner/human/crevus_azaula_enforcer
	short_name = "crevus_azaula_enforcer"
	name = "Azaula Entertainment Enforcer"
	desc = "\
	You are an enforcer for Azaula Entertainment. Look for up and coming gangers in the local rabble. \
	Ensure the local restaurant and casino are loyal to (and paying) Twin-Gun Granny, Mazula Azaula. \
	Make sure those Rhan-Cresh posers don't gain the upper hand on the streets. Invite the off-worlders to have the best experience Crevus can offer. \
	"
	tags = list("External")
	spawnpoints = list("crevus_azaula_enforcer")
	recognition_group = "crevus_azaula_enforcer"
	recognition_message = "You recognize this person as a fellow enforcer of Azaula Entertainment."
	max_count = 2
	outfit = /obj/outfit/admin/crevus/crevus_azaula_enforcer
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Azaula Entertainment Enforcer"
	special_role = "Azaula Entertainment Enforcer"
	respawn_flag = null

/obj/outfit/admin/crevus/crevus_azaula_enforcer
	name = "Azaula Entertainment Enforcer"
	uniform = list(
		/obj/item/clothing/under/tajaran/dpra/alt
	)
	suit = list(
		/obj/item/clothing/suit/storage/toggle/suitjacket,
		/obj/item/clothing/suit/storage/toggle/suitjacket/blazer
	)
	suit_store = /obj/item/pen/black
	accessory = /obj/item/clothing/accessory/wcoat
	glasses = /obj/item/clothing/glasses/sunglasses/visor
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id
	l_pocket = /obj/item/storage/wallet/random
	r_pocket = /obj/item/reagent_containers/glass/rag/handkerchief
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/crowbar/red,
		/obj/item/journal/notepad/filled,
		/obj/item/clothing/accessory/temperature/warm,
		/obj/item/flashlight/maglight,
		/obj/item/key/door_key/crevus/azaula_enforcer
	)

/obj/outfit/admin/crevus/crevus_azaula_enforcer/get_id_access()
	return list(/datum/access/crevus_azaula_enforcer)

/obj/outfit/admin/crevus/crevus_azaula_enforcer/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/list/possible_colors = list("#333333", "#433946", "#46393b")
	H.wear_suit?.color = pick(possible_colors)
	H.wear_suit?.accent_color = "#C0C0C0"
	H.wear_suit?.update_worn_icon()
	H.r_store?.color = "#433946"

// ---------- Gangs

// ----- Gang 1

/datum/ghostspawner/human/crevus_gang1_member
	short_name = "crevus_gang1_member"
	name = "The Violet Knuckles, Gang Member"
	desc = "\
	You are a member of a small-time gang, there are many like you in the streets. Expand your network, sell drugs, mug people, do business - but above all, do your best to be \
	noticed by the city's eyes. And who knows, maybe you can one day join a crime family proper. \
	Try not to bother much with where you stand on the moral compass. Despite your best efforts to avoid it, end up dying an untimely death. \
	"
	tags = list("External")
	spawnpoints = list("crevus_gang1_member")
	recognition_group = "crevus_gang1"
	recognition_message = "You recognize this person as a fellow member of your gang."
	max_count = 2
	outfit = /obj/outfit/admin/crevus/gang_member
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Gang Member"
	special_role = "Gang Member"
	respawn_flag = null

/obj/outfit/admin/crevus/gang_member
	name = "Gang Member"
	uniform = list(
		/obj/item/clothing/under/dressshirt/tanktop,
		/obj/item/clothing/under/dressshirt/longsleeve_s,
		/obj/item/clothing/under/dressshirt/deepv
	)

	suit = list(
		/obj/item/clothing/suit/storage/toggle/greatcoat/recolor,
		/obj/item/clothing/suit/storage/hooded/wintercoat/hoodie/sleeveless
	)

	pants = list(
		/obj/item/clothing/pants/cargo,
		/obj/item/clothing/pants/mustang/colourable
	)

	gloves = /obj/item/clothing/gloves/fingerless

	shoes = list(
		/obj/item/clothing/shoes/jackboots,
		/obj/item/clothing/shoes/workboots,
		/obj/item/clothing/shoes/workboots/dark
	)

	species_shoes = list(
		SPECIES_TAJARA = /obj/item/clothing/shoes/workboots/toeless,
		SPECIES_TAJARA_MSAI = /obj/item/clothing/shoes/workboots/toeless,
		SPECIES_TAJARA_ZHAN = /obj/item/clothing/shoes/workboots/toeless,
	)

	id = null
	l_pocket = /obj/item/storage/wallet/random
	r_pocket = /obj/item/material/knife/butterfly/switchblade
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/flashlight/maglight
	)

/obj/outfit/admin/crevus/gang_member/post_equip(mob/living/carbon/human/H)
	. = ..()

	// color the colorable stuff
	H.w_uniform?.color = get_random_colour(lower = 150)
	H.w_uniform?.update_worn_icon()
	H.wear_suit?.color = get_random_colour(lower = 150)
	H.wear_suit?.accent_color = "#C0C0C0"
	H.wear_suit?.update_worn_icon()
	H.pants?.color = get_random_colour(lower = 150)
	H.pants?.update_worn_icon()

	// random equipment
	//if(prob(50))
	H.equip_or_collect(new /obj/random/medical, slot_in_backpack)
	if(prob(50))
		H.equip_or_collect(new /obj/random/loot, slot_in_backpack)
	if(prob(55))
		H.equip_or_collect(new /obj/item/crowbar/red, slot_in_backpack)

/datum/ghostspawner/human/crevus_gang1_boss
	short_name = "crevus_gang1_boss"
	name = "The Violet Knuckles, Gang Leader"
	desc = "\
	You are a leader of a small-time gang, or at least you were when you last checked. Look after your people, do whatever it takes to make you (and maybe your men) rich. \
	Never compromise your authority, end up seeing your men die an untimely death because of your hubris. \
	"
	tags = list("External")
	spawnpoints = list("crevus_gang1_boss")
	recognition_group = "crevus_gang1"
	recognition_message = "You recognize this person as the leader of your gang."
	max_count = 1
	outfit = /obj/outfit/admin/crevus/gang_boss
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Gang Leader"
	special_role = "Gang Leader"
	respawn_flag = null

/obj/outfit/admin/crevus/gang_boss
	name = "Gang Leader"
	uniform = list(
		/obj/item/clothing/under/dressshirt/tanktop,
		/obj/item/clothing/under/dressshirt/longsleeve_s,
		/obj/item/clothing/under/dressshirt/deepv
	)

	suit = list(
		/obj/item/clothing/suit/storage/toggle/greatcoat/recolor,
		/obj/item/clothing/suit/storage/hooded/wintercoat/hoodie/sleeveless
	)

	pants = /obj/item/clothing/pants/tacticool
	gloves = /obj/item/clothing/gloves/fingerless
	glasses = /obj/item/clothing/glasses/sunglasses/visor
	shoes = /obj/item/clothing/shoes/laceup
	id = null
	l_pocket = /obj/item/storage/wallet/random
	r_pocket = /obj/item/material/knife/butterfly/switchblade
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/flashlight/maglight,
		/obj/item/clothing/accessory/holster/utility/machete,
		/obj/item/material/hatchet/machete/steel
	)

/obj/outfit/admin/crevus/gang_boss/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()

	// color the colorable stuff
	H.w_uniform?.color = get_random_colour(lower = 150)
	H.w_uniform?.update_worn_icon()
	H.wear_suit?.color = get_random_colour(lower = 150)
	H.wear_suit?.update_worn_icon()

	// random equipment
	if(prob(50))
		H.equip_or_collect(new /obj/random/medical, slot_in_backpack)
	if(prob(50))
		H.equip_or_collect(new /obj/random/loot, slot_in_backpack)
	if(prob(55))
		H.equip_or_collect(new /obj/item/crowbar/red, slot_in_backpack)

// ----- Gang 2

/datum/ghostspawner/human/crevus_gang2_member
	short_name = "crevus_gang2_member"
	name = "The Sham'tyrs, Gang Member"
	desc = "\
	You are a member of a small-time gang, there are many like you in the streets. Expand your network, sell drugs, mug people, do business - but above all, do your best to be \
	noticed by the city's eyes. And who knows, maybe you can one day join a crime family proper. \
	Try not to bother much with where you stand on the moral compass. Despite your best efforts to avoid it, end up dying an untimely death. \
	"
	tags = list("External")
	spawnpoints = list("crevus_gang2_member")
	recognition_group = "crevus_gang2"
	recognition_message = "You recognize this person as a fellow member of your gang."
	max_count = 2
	outfit = /obj/outfit/admin/crevus/gang_member
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Gang Member"
	special_role = "Gang Member"
	respawn_flag = null

/datum/ghostspawner/human/crevus_gang2_boss
	short_name = "crevus_gang2_boss"
	name = "The Sham'tyrs, Gang Leader"
	desc = "\
	You are a leader of a small-time gang, or at least you were when you last checked. Look after your people, do whatever it takes to make you (and maybe your men) rich. \
	Never compromise your authority, end up seeing your men die an untimely death because of your hubris. \
	"
	tags = list("External")
	spawnpoints = list("crevus_gang2_boss")
	recognition_group = "crevus_gang2"
	recognition_message = "You recognize this person as the leader of your gang."
	max_count = 1
	outfit = /obj/outfit/admin/crevus/gang_boss
	possible_species = CREVUS_GENERIC_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Gang Leader"
	special_role = "Gang Leader"
	respawn_flag = null

#undef CREVUS_GENERIC_SPECIES

// ---------- Crevan Liberation Army
/datum/ghostspawner/human/crevus_cla_partisan
	short_name = "crevus_cla_partisan"
	name = "Crevan Liberation Army Partisan"
	desc = "\
		You are a member of a small Crevan Liberation Army cell. Despite being whittled down to a few remaining guerillas following the \
		loss of your last safehouse, the arrival of an experienced ALA advisor (and an influx of convenient firearms and explosives) \
		have ignited a renewed hope for your cause. Gather intelligence, listen to your new leader, and try not to draw any unnecessary \
		attention to your cell, lest you find yourself at the receiving end of an Azaula Enforcer's pistol. \
	"
	desc_ooc = "\
		This is not an antagonist role. \
	"
	welcome_message_ooc = "\
		This is not an antagonist role. \
		The CLA is universally despised by the denizens of Crevus, and is expected to become extinct within the next decade. \
		Remember the survival of your cell is reliant on it's secrecy, and that overt action all but guarantees your demise. \
	"


	tags = list("External")
	spawnpoints = list("crevus_cla_partisan")
	recognition_group = "crevus_cla"
	recognition_message = "You recognize this person as a fellow member of your cell."
	max_count = 4
	outfit = /obj/outfit/admin/crevus/cla_partisan
	possible_species = ALL_TAJARA_SPECIES
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	assigned_role = "Sustainment Depot 43-5T Personnel"
	special_role = "CLA Partisan"
	respawn_flag = null
	enabled = FALSE

/obj/outfit/admin/crevus/cla_partisan
	name = "CLA Partisan"
	uniform = list(
		/obj/item/clothing/under/dressshirt/tanktop,
		/obj/item/clothing/under/dressshirt/longsleeve_s,
		/obj/item/clothing/under/dressshirt/deepv
	)

	suit = list(
		/obj/item/clothing/suit/storage/toggle/greatcoat/recolor,
		/obj/item/clothing/suit/storage/hooded/wintercoat/hoodie/sleeveless
	)

	pants = list(
		/obj/item/clothing/pants/cargo,
		/obj/item/clothing/pants/mustang/colourable
	)

	gloves = /obj/item/clothing/gloves/fingerless

	shoes = list(
		/obj/item/clothing/shoes/jackboots/tajara,
		/obj/item/clothing/shoes/workboots/tajara,
		/obj/item/clothing/shoes/workboots/tajara/dark
	)

	id = /obj/item/card/id
	l_pocket = /obj/item/storage/wallet/random
	r_pocket = /obj/item/material/kitchen/utensil/knife/boot
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/key/door_key/crevus/cla_safehouse,
		/obj/item/key/door_key/crevus/ala_depot
	)

/obj/outfit/admin/crevus/cla_partisan/get_id_access()
	return list(
		/datum/access/crevus_cla_safehouse,
		/datum/access/crevus_ala_depot
	)

/obj/outfit/admin/crevus/cla_partisan/post_equip(mob/living/carbon/human/H)
	. = ..()

	// colour the colorable stuff
	H.w_uniform?.color = get_random_colour(lower = 150)
	H.w_uniform?.update_worn_icon()
	H.wear_suit?.color = get_random_colour(lower = 150)
	H.wear_suit?.accent_color = "#C0C0C0"
	H.wear_suit?.update_worn_icon()
	H.pants?.color = get_random_colour(lower = 150)
	H.pants?.update_worn_icon()

	// random equipment
	//if(prob(50))
	H.equip_or_collect(new /obj/random/medical, slot_in_backpack)
	if(prob(50))
		H.equip_or_collect(new /obj/random/loot, slot_in_backpack)
	if(prob(55))
		H.equip_or_collect(new /obj/item/crowbar/red, slot_in_backpack)

/datum/ghostspawner/human/crevus_ala_advisor
	short_name = "crevus_ala_advisor"
	name = "Adhomai Liberation Army Hotak Commando"
	desc = "\
		You are an ALA Ketvah-Zarkir (Cell-Captain) belonging to Hotak's Commandos, tasked with moulding a ragtag group of amateur partisans \
		into a disciplined cell loyal to Supreme Commander Nated and Commander Hotak. This is a high risk, high reward assignment, where \
		success could fulfill your ambition of a Liberated Crevus, and failure will cement the total control of the xenos and the crime \
		families over the invaluable port-city.
	"
	desc_ooc = "\
		This is not an antagonist role. \
	"
	welcome_message = "\
		You've only had a couple of months to get your guerillas up to ALA standards, but now they prove themselves; the Azaula and Rhan-Cresh \
		both hold a small presence in Nikal Sahira to distract themelves, yet not powerful enough to inhibit your cell from making the occassional \
		theft or abduction. Additionally, your signals interception
	"
	welcome_message_ooc = "\
		This is not an antagonist role. \
		The ALA holds no significant physical presence or strength within Crevus; you are operating incognito of your true affiliations. \
		Remember that the succcess of your mission relies on covert intelligence-gathering and sabotage. Gathering the attention \
		of the corporations or the families will doom your mission, and attract Hotak's wrath. \
	"

	spawnpoints = list("crevus_ala_advisor")
	recognition_group = "crevus_cla"
	recognition_message = "You recognize this person as the leader of your cell."
	max_count = 1
	outfit = /obj/outfit/admin/crevus/ala_advisor
	assigned_role = "Sustainment Depot 43-5T Command"
	special_role = "ALA Hotak Commando"

/obj/outfit/admin/crevus/ala_advisor
	name = "Adhomai Liberation Army Hotak Commando"
	uniform = /obj/item/clothing/under/tajaran/dpra/alt
	accessory = /obj/item/clothing/accessory/wcoat
	suit = /obj/item/clothing/suit/storage/tajaran/hunting
	suit_accessory = list(
		/obj/item/clothing/accessory/tajaran/dpra_brooch,
		/obj/item/clothing/accessory/dpra_badge
	)
	gloves = null
	wrist = /obj/item/clothing/wrists/watch/pocketwatch/adhomai
	mask = /obj/item/clothing/accessory/dogtags/adhomai
	glasses = /obj/item/clothing/glasses/sunglasses/visor
	shoes = /obj/item/clothing/shoes/workboots/tajara/dark

	r_pocket = /obj/item/gun/projectile/revolver/derringer
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/clothing/accessory/holster/waist/brown,
		/obj/item/gun/projectile/silenced,
		/obj/item/ammo_magazine/c45m = 3,
		/obj/item/ammo_magazine/a357,
		/obj/item/crowbar/rescue_axe/tactical,
		/obj/item/clothing/accessory/badge/dpra_passport,
		/obj/item/key/door_key/crevus/cla_safehouse,
		/obj/item/key/door_key/crevus/ala_depot
	)

/obj/outfit/admin/crevus/ala_advisor/get_id_access()
	return list(
		/datum/access/crevus_cla_safehouse,
		/datum/access/crevus_ala_depot
	)

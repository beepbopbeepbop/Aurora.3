
//Deathsquad suit
/obj/item/clothing/head/helmet/space/deathsquad
	name = "deathsquad helmet"
	desc = "That's not red paint. That's real blood."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "deathsquad"
	item_state_slots = list(
		slot_l_hand_str = "syndicate-helm-black-red",
		slot_r_hand_str = "syndicate-helm-black-red"
		)
	armor = list(
		MELEE = ARMOR_MELEE_VERY_HIGH,
		BULLET = ARMOR_BALLISTIC_MEDIUM,
		LASER = ARMOR_LASER_PISTOL,
		ENERGY = ARMOR_ENERGY_SMALL,
		BOMB = ARMOR_BOMB_PADDED,
		BIO = ARMOR_BIO_SHIELDED,
		RAD = ARMOR_RAD_RESISTANT
	)
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	min_pressure_protection = 0
	flags_inv = BLOCKHAIR
	siemens_coefficient = 0.6
	contained_sprite = FALSE

//how is this a space helmet?
/obj/item/clothing/head/helmet/space/deathsquad/beret
	name = "officer's beret"
	desc = "An armored beret commonly used by special operations officers."
	icon = 'icons/obj/clothing/hats/berets.dmi'
	icon_state = "beret_sec"
	item_state = "beret_sec"
	contained_sprite = TRUE
	armor = list(
		MELEE = ARMOR_MELEE_KNIVES,
		BULLET = ARMOR_BALLISTIC_MINOR,
		LASER = ARMOR_LASER_MINOR
	)
	flags_inv = BLOCKHAIR
	siemens_coefficient = 0.9

//Space santa outfit suit
/obj/item/clothing/head/helmet/space/santahat
	name = "Santa's hat"
	desc = "Ho ho ho. Merrry X-mas!"
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "santahat"
	item_state = "santahat"
	flags_inv = BLOCKHAIR
	body_parts_covered = HEAD
	contained_sprite = FALSE

/obj/item/clothing/suit/space/santa
	name = "Santa's suit"
	desc = "Festive!"
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "santa"
	item_state = "santa"
	slowdown = 0
	allowed = list(/obj/item) //for stuffing exta special presents
	contained_sprite = FALSE

//Space pirate outfit
/obj/item/clothing/head/helmet/space/pirate
	name = "pirate hat"
	desc = "Yarr."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "pirate"
	item_state = "pirate"
	armor = list(
		MELEE = ARMOR_MELEE_MAJOR,
		BULLET = ARMOR_BALLISTIC_PISTOL,
		LASER = ARMOR_LASER_SMALL,
		ENERGY = ARMOR_ENERGY_MINOR,
		BOMB = ARMOR_BOMB_PADDED,
		BIO = ARMOR_BIO_SMALL,
		RAD = ARMOR_RAD_MINOR
	)
	flags_inv = BLOCKHAIR
	body_parts_covered = 0
	siemens_coefficient = 0.4
	contained_sprite = FALSE

/obj/item/clothing/suit/space/pirate
	name = "pirate coat"
	desc = "Yarr."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "pirate"
	item_state = "pirate"
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/tank/emergency_oxygen)
	slowdown = 0
	armor = list(
		MELEE = ARMOR_MELEE_MAJOR,
		BULLET = ARMOR_BALLISTIC_PISTOL,
		LASER = ARMOR_LASER_SMALL,
		ENERGY = ARMOR_ENERGY_MINOR,
		BOMB = ARMOR_BOMB_PADDED,
		BIO = ARMOR_BIO_SMALL,
		RAD = ARMOR_RAD_MINOR
	)
	siemens_coefficient = 0.4
	body_parts_covered = UPPER_TORSO|ARMS
	contained_sprite = FALSE

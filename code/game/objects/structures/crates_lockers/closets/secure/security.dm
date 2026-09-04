/obj/structure/closet/secure_closet/captains
	name = "captain's locker"
	req_access = list(ACCESS_CAPTAIN)
	icon_state = "cap"

/obj/structure/closet/secure_closet/captains/fill()
	// Backpack
	if(prob(50))
		new /obj/item/storage/backpack/captain(src)
	else
		new /obj/item/storage/backpack/satchel/cap(src)
	new /obj/item/storage/backpack/duffel/cap(src)
	// Armor
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/suit/armor/carrier/generic(src)
	//Tools
	new /obj/item/radio/headset/heads/captain(src)
	new /obj/item/radio/headset/heads/captain/alt(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/gun/energy/repeater/pistol(src)
	new /obj/item/flash(src)
	new /obj/item/melee/telebaton(src)
	new /obj/item/radio/off(src)
	new /obj/item/taperecorder(src)
	// uniform briefcases
	new /obj/item/storage/briefcase/nt/captain(src)
	new /obj/item/storage/briefcase/nt/captain_white(src)
	new /obj/item/storage/briefcase/nt/captain_formal(src)
	new /obj/item/storage/briefcase/nt/acap(src)

/obj/structure/closet/secure_closet/captains2
	name = "captain's attire"
	req_access = list(ACCESS_CAPTAIN)
	icon_state = "cap"

/obj/structure/closet/secure_closet/captains2/fill()
	new /obj/item/storage/backpack/captain(src)
	new /obj/item/storage/backpack/satchel/cap(src)
	new /obj/item/clothing/suit/captunic(src)
	new /obj/item/clothing/suit/captunic/capjacket(src)
	new /obj/item/clothing/head/caphat(src)
	new /obj/item/clothing/head/bandana/captain(src)
	new /obj/item/clothing/under/rank/captain(src)
	new /obj/item/clothing/suit/storage/vest(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/gloves/captain(src)
	new /obj/item/clothing/under/dress/dress_cap(src)
	new /obj/item/clothing/head/helmet/formalcaptain(src)
	new /obj/item/clothing/under/captainformal(src)

/obj/structure/closet/secure_closet/xo
	name = "executive officer's locker"
	req_access = list(ACCESS_HOP)
	icon_state = "sec"
	icon_door = "hop"

/obj/structure/closet/secure_closet/xo/fill()
	..()
	//Supply
	new /obj/item/storage/briefcase/black(src)
	new /obj/item/storage/secure/briefcase (src)
	new /obj/item/storage/box/ids(src)
	new /obj/item/storage/box/ids(src)
	new /obj/item/radio/headset/heads/xo(src)
	new /obj/item/radio/headset/heads/xo/alt(src)
	//Appearance
	new /obj/item/storage/backpack/satchel/pocketbook(src)
	new /obj/item/clothing/shoes/laceup/brown(src)
	new /obj/item/clothing/under/rank/xo(src)
	new /obj/item/clothing/head/caphat/xo(src)
	new /obj/item/clothing/head/caphat/cap/beret/xo(src)
	new /obj/item/clothing/gloves/captain/white/xo(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/suit/armor/carrier/generic(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/accessory/holster/waist(src)
	//Tools
	new /obj/item/megaphone/command(src)
	new /obj/item/storage/stickersheet/goldstar(src)
	new /obj/item/journal/notepad/scc/filled(src)
	new /obj/item/gun/energy/repeater/pistol(src)
	new /obj/item/flash(src)
	new /obj/item/radio(src)
	new /obj/item/taperecorder(src)

// SECURITY CLOSETS
/obj/structure/closet/secure_closet/security
	name = "Security Locker - PARENT ITEM"
	req_access = list(ACCESS_BRIG)
	icon_state = "sec"

//Supply
//Clothing
//Belts
//Armour
//Tools
//Weapons

/obj/structure/closet/secure_closet/security/fill()
	..()
	//Supply
	new /obj/item/radio/sec(src)
	//Clothing
	new /obj/item/storage/backpack/satchel/sec(src)
	new /obj/item/storage/backpack/duffel/sec(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/glasses/sunglasses/aviator(src)
	new /obj/item/clothing/glasses/hud/security(src)
	new /obj/item/clothing/glasses/sunglasses/sechud(src)
	new /obj/item/clothing/glasses/sunglasses/sechud/aviator(src)
	new /obj/item/clothing/mask/gas/alt(src)
	new /obj/item/clothing/mask/gas/half(src)
	//Belts
	new /obj/item/clothing/accessory/storage/black_vest(src)
	new /obj/item/clothing/accessory/storage/pouches/black(src)
	new /obj/item/clothing/accessory/holster/hip(src)
	new /obj/item/clothing/accessory/holster/modular(src)
	new /obj/item/clothing/accessory/holster/waist(src)
	new /obj/item/clothing/accessory/holster/thigh(src)
	new /obj/item/clothing/accessory/holster/armpit(src)
	//Tools
	new /obj/item/taperecorder(src)
	new /obj/item/taperoll/police(src)
	new /obj/item/breath_analyzer(src)
	new /obj/item/journal/notepad/filled/security(src)

// Security Officer
/obj/structure/closet/secure_closet/security/officer
	name = "security officer's locker"

/obj/structure/closet/secure_closet/security/officer/fill()
	..()
	//Supply
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/radio/headset/alt/double/sec(src)
	new /obj/item/radio/headset/wrist/sec(src)
	new /obj/item/radio/headset/wrist/clip/sec(src)
	//Clothing
	new /obj/item/clothing/accessory/badge/officer(src)
	//Belts
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/storage/belt/security/vestbelt(src)
	//Armour
	new /obj/item/clothing/suit/armor/carrier/officer(src)
	new /obj/item/clothing/accessory/arm_guard(src)
	new /obj/item/clothing/accessory/leg_guard(src)
	new /obj/item/clothing/head/helmet/security(src)
	//Tools
	new /obj/item/holowarrant(src)
	//Weapons
	new /obj/item/gun/projectile/sec/unloaded(src)
	for(var/i = 1 to 2)
		new /obj/item/ammo_magazine/c45m/rubber(src)

// Warden
/obj/structure/closet/secure_closet/security/warden
	name = "warden's locker"
	icon_state = "warden"

/obj/structure/closet/secure_closet/security/warden/fill()
	..()
	//Supply
	new /obj/item/storage/box/ids(src)
	new /obj/item/radio/headset/headset_warden(src)
	new /obj/item/radio/headset/headset_warden/alt(src)
	new /obj/item/radio/headset/alt/double/sec/warden(src)
	new /obj/item/radio/headset/wrist/sec/warden(src)
	new /obj/item/radio/headset/wrist/clip/sec/warden(src)
	//Clothing
	new /obj/item/clothing/accessory/badge/warden(src)
	//Belts
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/storage/belt/security/vestbelt(src)
	//Armour
	new /obj/item/clothing/suit/armor/carrier/officer(src)
	new /obj/item/clothing/accessory/arm_guard(src)
	new /obj/item/clothing/accessory/leg_guard(src)
	new /obj/item/clothing/head/helmet/security(src)
	//Tools
	new /obj/item/megaphone/sec(src)
	new /obj/item/ipc_tag_scanner(src)
	new /obj/item/holowarrant(src)
	//Weapons
	new /obj/item/gun/projectile/sec/unloaded(src)
	for(var/i = 1 to 2)
		new /obj/item/ammo_magazine/c45m/rubber(src)

// Head of Security
/obj/structure/closet/secure_closet/security/hos
	name = "head of security's locker"
	req_access = list(ACCESS_HOS)
	icon_state = "hos"

/obj/structure/closet/secure_closet/security/hos/fill()
	..()
	//Supply
	new /obj/item/storage/box/ids(src)
	new /obj/item/storage/box/fancy/keypouch/sec(src)
	new /obj/item/radio/headset/heads/hos(src)
	new /obj/item/radio/headset/heads/hos/alt(src)
	new /obj/item/radio/headset/alt/double/hos(src)
	new /obj/item/radio/headset/wrist/hos(src)
	new /obj/item/radio/headset/wrist/clip/hos(src)
	//Clothing
	new /obj/item/clothing/under/rank/head_of_security(src)
	new /obj/item/clothing/suit/storage/security/hos(src)
	new /obj/item/clothing/head/hos(src)
	new /obj/item/clothing/head/beret/security/hos(src)
	new /obj/item/clothing/accessory/badge/hos(src)
	//Belts
	new /obj/item/storage/belt/security/full/hos(src)
	new /obj/item/storage/belt/security/vestbelt(src)
	//Armour
	new /obj/item/clothing/suit/armor/carrier/hos(src)
	new /obj/item/clothing/accessory/leg_guard(src)
	new /obj/item/clothing/accessory/arm_guard(src)
	new /obj/item/clothing/head/helmet/hos(src)
	//Tools
	new /obj/item/megaphone/command(src)
	new /obj/item/ipc_tag_scanner(src)
	new /obj/item/holowarrant(src)
	new /obj/item/shield/riot/tact(src)
	//Weapons
	new /obj/item/gun/projectile/sec/wood/unloaded(src)
	for(var/i = 1 to 2)
		new /obj/item/ammo_magazine/c45m/rubber(src)
	new /obj/item/ammo_magazine/c45m(src)


// Investigator
/obj/structure/closet/secure_closet/security/investigator
	name = "investigator's locker"
	req_access = list(ACCESS_FORENSICS_LOCKERS)

/obj/structure/closet/secure_closet/security/investigator/fill()
	..()
	//Supply
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/radio/headset/alt/double/sec(src)
	new /obj/item/radio/headset/wrist/sec(src)
	new /obj/item/radio/headset/wrist/clip/sec(src)
	//Clothing
	new /obj/item/clothing/accessory/badge/investigator(src)
	//Belts
	new /obj/item/storage/belt/security/full/investigator(src)
	//Armour
	new /obj/item/clothing/suit/armor/carrier/officer(src)
	//Tools
	new /obj/item/laser_pointer/blue(src)
	new /obj/item/stamp/investigations(src)
	//Weapons
	new /obj/item/gun/projectile/revolver/security/unloaded(src)
	for(var/i = 1 to 2)
		new /obj/item/ammo_magazine/c45/revolver/rubber(src)

// Cadet
/obj/structure/closet/secure_closet/security/cadet
	name = "security cadet's locker"
	req_access = list(ACCESS_SECURITY)
	icon_door = "seccadet"

/obj/structure/closet/secure_closet/security/cadet/fill()
	//Supply
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/radio/headset/alt/double/sec(src)
	new /obj/item/radio/headset/wrist/sec(src)
	new /obj/item/radio/headset/wrist/clip/sec(src)
	//Belts
	new /obj/item/storage/belt/security/full/cadet(src)
	new /obj/item/storage/belt/security/vestbelt(src)
	//Armour
	new /obj/item/clothing/suit/armor/carrier/officer(src)

//

/obj/structure/closet/secure_closet/injection
	name = "lethal injections locker"
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/injection/fill()
	new /obj/item/reagent_containers/syringe/large/ld50_syringe/chloral(src)
	new /obj/item/reagent_containers/syringe/large/ld50_syringe/chloral(src)


// These are special snowflakes that need to be in a global list.
/obj/structure/closet/secure_closet/brig
	name = "brig locker"
	req_access = list(ACCESS_BRIG)
	anchored = TRUE
	canbemoved = TRUE
	var/id = null

/obj/structure/closet/secure_closet/brig/Initialize()
	. = ..()
	GLOB.brig_closets += src

/obj/structure/closet/secure_closet/brig/Destroy()
	GLOB.brig_closets -= src
	return ..()

/obj/structure/closet/secure_closet/brig/fill()
	new /obj/item/clothing/under/color/orange( src )
	new /obj/item/clothing/shoes/sneakers/orange( src )

/obj/structure/closet/secure_closet/courtroom
	name = "courtroom locker"
	req_access = list(ACCESS_LAWYER)

/obj/structure/closet/secure_closet/courtroom/fill()
	..()
	//Appearance
	new /obj/item/clothing/head/powdered_wig (src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/suit/judgerobe (src)
	//Tools
	new /obj/item/paper/Court (src)
	new /obj/item/paper/Court (src)
	new /obj/item/paper/Court (src)
	new /obj/item/pen (src)
	new /obj/item/storage/briefcase(src)

/obj/structure/closet/secure_closet/bridge_crew
	name = "bridge crew's locker"
	req_access = list(ACCESS_BRIDGE_CREW)
	icon_state = "sec"
	icon_door = "hop"

/obj/structure/closet/secure_closet/bridge_crew/fill()
	..()
	new /obj/item/clothing/under/rank/bridge_crew(src)
	new /obj/item/clothing/head/caphat/bridge_crew(src)
	new /obj/item/clothing/head/caphat/bridge_crew/alt(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/accessory/holster/waist(src)
	new /obj/item/gun/projectile/sec(src)
	new /obj/item/radio/headset/headset_com(src)
	new /obj/item/radio/headset/headset_com/alt(src)
	new /obj/item/radio/off(src)
	new /obj/item/gps(src)

// Evidence Storage Locker
/obj/structure/closet/secure_closet/evidence
	name = "evidence storage locker"
	anchored = TRUE
	canbemoved = TRUE
	req_one_access = list(ACCESS_BRIG, ACCESS_ARMORY, ACCESS_FORENSICS_LOCKERS)

// Contraband Storage Locker
/obj/structure/closet/secure_closet/contraband
	name = "contraband weapons and ammunition storage locker"
	anchored = TRUE
	canbemoved = TRUE
	req_access = list(ACCESS_ARMORY)

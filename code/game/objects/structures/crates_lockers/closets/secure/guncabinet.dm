/obj/structure/closet/secure_closet/guncabinet
	name = "gun cabinet"
	req_access = list(ACCESS_ARMORY)
	icon = 'icons/obj/containers/guncabinet.dmi'
	icon_state = "base"
	anchored = TRUE
	canbemoved = TRUE

	door_underlay = TRUE
	door_anim_squish = 0.12
	door_anim_angle = 119
	door_hinge_x = -9.5

/obj/structure/closet/secure_closet/guncabinet/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/closet/secure_closet/guncabinet/LateInitialize()
	..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/toggle()
	..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/update_icon()
	ClearOverlays()
	var/lazors = 0
	var/shottas = 0
	for (var/obj/item/gun/G in contents)
		if (istype(G, /obj/item/gun/energy))
			lazors++
		if (istype(G, /obj/item/gun/projectile/))
			shottas++
	if (lazors || shottas)
		for (var/i = 0 to 2)
			if (lazors > 0 && (shottas <= 0 || prob(50)))
				lazors--
				AddOverlays("laser[i]")
			else if (shottas > 0)
				shottas--
				AddOverlays("projectile[i]")
	. = ..()

/obj/structure/closet/secure_closet/guncabinet/sci
	name = "science gun cabinet"
	req_access = list(ACCESS_TOX_STORAGE)
	icon_state = "sci"

/obj/structure/closet/secure_closet/guncabinet/peac
	name = "weapons locker - Anti-Materiel Weapons Platform"

/obj/structure/closet/secure_closet/guncabinet/peac/fill()
	new /obj/item/gun/projectile/peac/unloaded(src)
	for(var/i = 1 to 4)
		new /obj/item/ammo_casing/peac(src)

/obj/structure/closet/secure_closet/guncabinet/station/lessthanlethals
	name = "munitions locker - Less than Lethal"

/obj/structure/closet/secure_closet/guncabinet/station/lessthanlethals/fill()
	for(var/i = 1 to 15)
		new /obj/item/ammo_magazine/c45m/rubber(src)
	for(var/i = 1 to 4)
		new /obj/item/ammo_magazine/c45/revolver/rubber(src)
	for(var/i = 1 to 8)
		new /obj/item/ammo_magazine/mc9mmt/rubber(src)
	for(var/i = 1 to 4)
		new /obj/item/storage/box/shells/beanbags(src)
	for(var/i = 1 to 2)
		new /obj/item/storage/box/tactical/beanbags(src)
	new /obj/item/storage/box/shells/flashshells(src)
	new /obj/item/storage/box/shells/stunshells(src)
	new /obj/item/storage/box/shells/trackingslugs(src)

/obj/structure/closet/secure_closet/guncabinet/station/lethals
	name = "munitions locker - Lethal"

/obj/structure/closet/secure_closet/guncabinet/station/lethals/fill()
	for(var/i = 1 to 10)
		new /obj/item/ammo_magazine/c45m(src)
	for(var/i = 1 to 4)
		new /obj/item/ammo_magazine/c45/revolver(src)
	for(var/i = 1 to 6)
		new /obj/item/ammo_magazine/mc9mmt(src)
		new /obj/item/ammo_magazine/a556/carbine/polymer(src)
	for(var/i = 1 to 4)
		new /obj/item/storage/box/shells/buckshot(src)

/obj/structure/closet/secure_closet/guncabinet/station/pistols
	name = "weapons locker - Pistols"

/obj/structure/closet/secure_closet/guncabinet/station/pistols/fill()
	for(var/i = 1 to 4)
		new /obj/item/gun/energy/taser(src)
	for(var/i = 1 to 2)
		new /obj/item/gun/energy/stunrevolver(src)
	for(var/i = 1 to 4)
		new /obj/item/gun/projectile/sec/unloaded(src)
	for(var/i = 1 to 2)
		new /obj/item/gun/projectile/revolver/security/unloaded(src)

/obj/structure/closet/secure_closet/guncabinet/station/riot
	name = "armour locker - Riot"

/obj/structure/closet/secure_closet/guncabinet/station/riot/fill()
	for(var/i = 1 to 4)
		new /obj/item/clothing/suit/armor/carrier/riot(src)
		new /obj/item/clothing/head/helmet/riot(src)
		new /obj/item/shield/riot(src)

/obj/structure/closet/secure_closet/guncabinet/station/heavy
	name = "armour locker - Heavy"

/obj/structure/closet/secure_closet/guncabinet/station/heavy/fill()
	for(var/i = 1 to 4)
		new /obj/item/clothing/suit/armor/carrier/heavy/sec(src)
		new /obj/item/clothing/head/helmet/security/heavy(src)

/obj/structure/closet/secure_closet/guncabinet/station/ablative
	name = "armour locker - Ablative"

/obj/structure/closet/secure_closet/guncabinet/station/ablative/fill()
	for(var/i = 1 to 4)
		new /obj/item/clothing/suit/armor/carrier/ablative(src)
		new /obj/item/clothing/head/helmet/ablative(src)

/obj/structure/closet/secure_closet/guncabinet/station/ballistic
	name = "armour locker - Ballistic"

/obj/structure/closet/secure_closet/guncabinet/station/ballistic/fill()
	for(var/i = 1 to 4)
		new /obj/item/clothing/suit/armor/carrier/ballistic(src)
		new /obj/item/clothing/head/helmet/ballistic(src)

/obj/structure/machinery/ship_weapon/vertical_launching_system
	name = "Mk 22 vertical launching system"
	desc = "Mark 22."
	icon = 'icons/obj/machinery/ship_guns/vls.dmi'
	icon_state = "weapon_base"
	max_ammo = 6
	projectile_type = /obj/projectile/ship_ammo/missile
	mobile_platform = TRUE // a missile fired from the VLS begins its flight trajectory after launching

/obj/structure/machinery/ship_weapon/vertical_launching_system/pre_fire(/atom/target, /obj/effect/landmark/landmark)
	for(var/mob/M in GLOB.living_mob_list)
		if(AreConnectedZLevels(GET_Z(M), z))
			sound_to(M, sound('sound/weapons/rocketlaunch.ogg'))
	flick("weapon_charging", src)
	sleep(1.1 SECONDS)
	. = ..()

/obj/structure/machinery/ammunition_loader/sol/vertical_launching_system
	name = "vertical launching system missile loader"

/obj/item/ship_ammunition/missile
	name = "APKEP cruise missile"
	name_override = "APKEP cruise missile"
	desc = "Armour piercing kinetic energy penetrator"
	icon = 'icons/obj/guns/ship/ship_ammo_missile.dmi'
	icon_state = "vls_missile"
	projectile_type_override = /obj/item/ship_ammunition/missile
	caliber = SHIP_CALIBER_MISSILE_MULTI_PURPOSE
	impact_type = SHIP_AMMO_IMPACT_BUNKERBUSTER
	ammunition_flags = SHIP_AMMO_FLAG_VERY_HEAVY
	ammunition_behaviour = SHIP_AMMO_BEHAVIOUR_GUIDED
	overmap_behaviour = SHIP_AMMO_CAN_HIT_VISITABLES
	overmap_icon_state = "missile"
	range = OVERMAP_PROJECTILE_RANGE_MEDIUMHIGH

/obj/projectile/ship_ammo/missile
	name = "APKEP cruise missile"
	icon = 'icons/obj/guns/ship/physical_projectiles.dmi'
	icon_state = "rocket"
	damage = 1000
	armor_penetration = 1000 //Hypersonic kinetic energy penetrator
	penetrating = 100 //Hypersonic kinetic energy penetrator
	anti_materiel_potential = 10

/obj/item/ship_ammunition/missile/heat
	name = "HEAT-D cruise missile"
	name_override = "HEAT-D cruise missile"
	desc = "High Explosive Anti-Tank Dual-Charge"
	icon = 'icons/obj/guns/ship/ship_ammo_missile.dmi'
	icon_state = "vls_missile"
	projectile_type_override = /obj/item/ship_ammunition/missile/heat
	caliber = SHIP_CALIBER_MISSILE_ANTI_SHIP
	impact_type = SHIP_AMMO_IMPACT_HE
	ammunition_flags = SHIP_AMMO_FLAG_INFLAMMABLE|SHIP_AMMO_FLAG_VERY_HEAVY|SHIP_AMMO_FLAG_VULNERABLE
	ammunition_behaviour = SHIP_AMMO_BEHAVIOUR_GUIDED
	overmap_behaviour = SHIP_AMMO_CAN_HIT_HAZARDS|SHIP_AMMO_CAN_HIT_VISITABLES
	overmap_icon_state = "missile"
	range = OVERMAP_PROJECTILE_RANGE_MEDIUMHIGH

/obj/projectile/ship_ammo/missile/heat
	name = "HEAT-D cruise missile"
	icon = 'icons/obj/guns/ship/physical_projectiles.dmi'
	icon_state = "missile"
	damage = 1000
	armor_penetration = 1000 //Shaped/dual charge shell
	penetrating = 50 //Shaped/dual charge shell
	anti_materiel_potential = 10
	explosion_strength = list(3, 6, 8)

/obj/item/ship_ammunition/missile/hebf
	name = "HEBF-P cruise missile"
	name_override = "HEBF-P cruise missile"
	desc = "High Explosive Blast-Fragmentation Proximity Fuse"
	icon = 'icons/obj/guns/ship/ship_ammo_missile.dmi'
	icon_state = "vls_missile"
	projectile_type_override = /obj/item/ship_ammunition/missile/hebf
	caliber = SHIP_CALIBER_MISSILE_ANTI_SHIP
	impact_type = SHIP_AMMO_IMPACT_HE
	ammunition_flags = SHIP_AMMO_FLAG_INFLAMMABLE|SHIP_AMMO_FLAG_VERY_HEAVY|SHIP_AMMO_FLAG_VULNERABLE
	ammunition_behaviour = SHIP_AMMO_BEHAVIOUR_GUIDED
	overmap_behaviour = SHIP_AMMO_CAN_HIT_HAZARDS|SHIP_AMMO_CAN_HIT_VISITABLES
	overmap_icon_state = "missile"
	range = OVERMAP_PROJECTILE_RANGE_MEDIUMHIGH

/obj/projectile/ship_ammo/missile/hebf
	name = "HEBF-P cruise missile"
	icon = 'icons/obj/guns/ship/physical_projectiles.dmi'
	icon_state = "missile"
	damage = 1000
	armor_penetration = 500 //Blast-fragmentation shell
	penetrating = 0 //Proximity fuse shell
	anti_materiel_potential = 10
	explosion_strength = list(6, 8, 10)

/obj/item/ship_ammunition/missile/csgm
	name = "CSGM-PW cruise missile"
	name_override = "CSGM-PW cruise missile"
	desc = "Coffin Space Guided Missile Phoron Warhead"
	icon = 'icons/obj/guns/ship/ship_ammo_missile.dmi'
	icon_state = "vls_missile"
	projectile_type_override = /obj/item/ship_ammunition/missile/csgm
	caliber = SHIP_CALIBER_MISSILE_STRATEGIC
	impact_type = SHIP_AMMO_IMPACT_PLASMA
	ammunition_flags = SHIP_AMMO_FLAG_INFLAMMABLE|SHIP_AMMO_FLAG_VERY_FRAGILE|SHIP_AMMO_FLAG_VERY_HEAVY|SHIP_AMMO_FLAG_VULNERABLE
	ammunition_behaviour = SHIP_AMMO_BEHAVIOUR_GUIDED
	overmap_behaviour = SHIP_AMMO_CAN_HIT_HAZARDS|SHIP_AMMO_CAN_HIT_PLANETS|SHIP_AMMO_CAN_HIT_VISITABLES
	overmap_icon_state = "missile_alt"
	range = OVERMAP_PROJECTILE_RANGE_ULTRAHIGH

/obj/projectile/ship_ammo/missile/csgm
	name = "CSGM-PW cruise missile"
	icon = 'icons/obj/guns/ship/physical_projectiles.dmi'
	icon_state = "torpedo"
	damage = 10000
	armor_penetration = 1000
	penetrating = 0
	anti_materiel_potential = 10
	explosion_strength = list(6, 8, 12)

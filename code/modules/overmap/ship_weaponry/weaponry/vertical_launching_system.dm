/obj/structure/machinery/ship_weapon/vertical_launching_system
	name = "Mk 22 vertical launching system"
	desc = "Mark 22."
	icon = 'icons/obj/machinery/ship_guns/vls.dmi'
	icon_state = "weapon_base"
	idle_power_usage = 1500
	active_power_usage = 100000
	max_ammo = 6
	projectile_type = /obj/projectile/ship_ammo/missile
	caliber = SHIP_CALIBER_MISSILE_MULTI_PURPOSE
	screenshake_type = SHIP_GUN_SCREENSHAKE_SCREEN
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
	name = "multi-purpose kinetic missile"
	name_override = "kinetic missile"
	desc = "A hydrogen cell for use in a vertical_launch_system blaster repeater, carefully tuned for higher damage and spread at the cost of armour penetration."
	icon = 'icons/obj/guns/ship/ship_ammo_missile.dmi'
	icon_state = "vls_missile"
	overmap_icon_state = "missile"
	impact_type = SHIP_AMMO_IMPACT_BUNKERBUSTER
	ammunition_flags = SHIP_AMMO_FLAG_INFLAMMABLE|SHIP_AMMO_FLAG_VERY_HEAVY
	caliber = SHIP_CALIBER_MISSILE_MULTI_PURPOSE
	ammunition_behaviour = SHIP_AMMO_BEHAVIOUR_GUIDED
	overmap_behaviour = SHIP_AMMO_CAN_HIT_VISITABLES
	range = OVERMAP_PROJECTILE_RANGE_MEDIUMHIGH
	cookoff_heavy = 0
	projectile_type_override = /obj/item/ship_ammunition/missile

/obj/projectile/ship_ammo/missile
	name = "multi-purpose kinetic missile"
	icon = 'icons/obj/guns/ship/physical_projectiles.dmi'
	icon_state = "rocket"
	damage = 10000
	armor_penetration = 1000
	penetrating = 50
	anti_materiel_potential = 10
	explosion_strength = list(1, 5, 3)

/obj/item/ship_ammunition/missile/he
	name = "high-explosive shaped charge missile"
	name_override = "high-explosive shaped charge missile"
	desc = "A hydrogen cell for use in a vertical_launch_system blaster repeater, carefully tuned for higher armour penetration at the cost of damage."
	icon = 'icons/obj/guns/ship/ship_ammo_missile.dmi'
	icon_state = "vls_missile"
	impact_type = SHIP_AMMO_IMPACT_HE
	ammunition_flags = SHIP_AMMO_FLAG_VULNERABLE|SHIP_AMMO_FLAG_INFLAMMABLE|SHIP_AMMO_FLAG_VERY_HEAVY
	overmap_behaviour = SHIP_AMMO_CAN_HIT_HAZARDS|SHIP_AMMO_CAN_HIT_VISITABLES
	cookoff_heavy = 2
	burst = 15
	projectile_type_override = /obj/item/ship_ammunition/missile/he

/obj/projectile/ship_ammo/missile/he
	name = "high-explosive shaped charge missile"
	icon_state = "missile"
	damage = 20
	armor_penetration = 100
	penetrating = 4
	explosion_strength = list(0, 0, 0)

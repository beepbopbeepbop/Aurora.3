/datum/map_template/ruin/away_site/nralakk_monitor
	name = "Nralakk Federal Security Vessel"
	description = "x."

	prefix = "ships/nralakk_monitor/"
	suffix = "nralakk_monitor.dmm"

	sectors = list(
		SECTOR_BADLANDS,
		SECTOR_CRESCENT_EXPANSE_WEST
	)
	spawn_weight = 1
	ship_cost = 1
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/nralakk_shuttle)

	unit_test_groups = list(3)

singleton/submap_archetype/nralakk_monitor
	map = "Nralakk Federal Security Vessel"
	descriptor = "x."

/obj/effect/overmap/visitable/ship/nralakk_monitor
	name = "Nralakk Federal Security Vessel"
	class = "NFSV"
	desc = "x."
	icon_state = "tirakqi"
	moving_state = "tirakqi_moving"
	colors = list("#27e4ee", "#4febbf")
	scanimage = "skrell_freighter.png"
	designer = "Einstein Engines, Hang Tuah's Rest Orbital Shipyards"
	volume = "50 meters length, 36 meters beam/width, 13 meters vertical height"
	weapons = "Heavily modified ballistic gunnery pod starboard, shuttle bay portside"
	sizeclass = "Laksamana-class hauler"
	shiptype = "Remote hauling operations, long-term crew habitation"

	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL

	initial_restricted_waypoints = list(
		"NFSV Shuttle" = list("nav_hangar_nralakk")
	)

	initial_generic_waypoints = list(
		"nralakk_monitor_nav1",
		"nralakk_monitor_nav2",
		"nralakk_monitor_nav3",
		"nralakk_monitor_nav4",
		"nralakk_monitor_starboard_dock",
		"nralakk_monitor_port_dock",
		"nralakk_monitor_aft_dock",
		"nralakk_monitor_fore_dock"
	)

	invisible_until_ghostrole_spawn = TRUE

/obj/effect/overmap/visitable/ship/nralakk_monitor/New()
	designation = "[pick("jrugl number one", "glorsh two")]"
	..()

/obj/effect/overmap/visitable/ship/nralakk_monitor/get_skybox_representation()
	var/image/skybox_image = image('icons/skybox/subcapital_ships.dmi', "skrell_freighter")
	skybox_image.pixel_x = rand(0,64)
	skybox_image.pixel_y = rand(128,256)
	return skybox_image

// Custom stuff
/obj/structure/closet/secure_closet/medical/nralakk
	name = "medical supply closet"
	desc = "Contains various medical supplies."
	icon_state = "med"
	req_access = list(ACCESS_NRALAKK_MONITOR)

/obj/structure/closet/secure_closet/medical/nralakk/fill()
	..()
	new /obj/item/storage/box/syringes(src)
	new /obj/item/storage/box/autoinjectors(src)
	new /obj/item/storage/box/inhalers_auto(src)
	new /obj/item/storage/box/inhalers(src)
	new /obj/item/storage/box/inhalers_large(src)
	new /obj/item/storage/box/pillbottles(src)
	new /obj/item/storage/box/beakers(src)
	new /obj/item/storage/box/bloodpacks(src)
	new /obj/item/storage/box/bodybags(src)

/obj/structure/closet/secure_closet/medical/nralakk/life_support
	name = "medical life support closet"
	desc = "Contains various medical life support devices."

/obj/structure/closet/secure_closet/medical/nralakk/life_support/fill()
	..()
	new /obj/item/tank/oxygen(src)
	new /obj/item/tank/oxygen(src)
	new /obj/item/tank/oxygen(src)
	new /obj/item/tank/oxygen(src)
	new /obj/item/tank/oxygen(src)
	new /obj/item/clothing/mask/breath/medical(src)
	new /obj/item/clothing/mask/breath/medical(src)
	new /obj/item/clothing/mask/breath/medical(src)
	new /obj/item/clothing/mask/breath/medical(src)
	new /obj/item/clothing/mask/breath/medical(src)
	new /obj/item/vitals_monitor(src)
	new /obj/item/vitals_monitor(src)
	new /obj/item/vitals_monitor(src)
	new /obj/item/vitals_monitor(src)
	new /obj/item/bodybag/cryobag(src)
	new /obj/item/bodybag/cryobag(src)
	new /obj/item/bodybag/cryobag(src)
	new /obj/item/bodybag/cryobag(src)
	new /obj/item/auto_cpr(src)
	new /obj/item/auto_cpr(src)
	new /obj/item/defibrillator/compact/combat/loaded(src)
	new /obj/item/defibrillator/loaded(src)
	new /obj/item/advanced_healthanalyzer(src)

/obj/structure/closet/secure_closet/medical/nralakk/anaesthetic
	name = "anaesthetics closet"
	desc = "Contains various supplies for inducing anaesthesia."

/obj/structure/closet/secure_closet/medical/nralakk/anaesthetic/fill()
	..()
	new /obj/item/tank/oxygen(src)
	new /obj/item/tank/anesthetic(src)
	new /obj/item/clothing/mask/breath/medical(src)
	new /obj/item/reagent_containers/glass/bottle/polysomnine(src)

/obj/structure/closet/secure_closet/medical/nralakk/equipment
	name = "medical equipment closet"
	desc = "Contains various pieces of equipment for medical professionals."

/obj/structure/closet/secure_closet/medical/nralakk/equipment/fill()
	..()
	new /obj/item/healthanalyzer(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/breath_analyzer(src)
	new /obj/item/breath_analyzer(src)
	new /obj/item/flashlight/pen(src)
	new /obj/item/flashlight/pen(src)
	new /obj/item/clothing/accessory/stethoscope(src)
	new /obj/item/clothing/accessory/stethoscope(src)
	new /obj/item/clothing/gloves/latex/nitrile/zeng(src)
	new /obj/item/clothing/gloves/latex/nitrile/zeng(src)
	new /obj/item/clothing/accessory/armband/med(src)
	new /obj/item/clothing/accessory/armband/med(src)
	new /obj/item/storage/backpack/duffel/med(src)
// Physician
	new /obj/item/storage/belt/medical(src)
	new /obj/item/clothing/accessory/storage/pouches/white(src)
	new /obj/item/clothing/glasses/hud/health/zeng(src)
	new /obj/item/reagent_containers/hypospray/cmo(src)
	new /obj/item/reagent_containers/dropper/electronic_pipette(src)
// Medic
	new /obj/item/storage/belt/medical/paramedic/combat(src)
	new /obj/item/clothing/accessory/storage/white_vest(src)
	new /obj/item/clothing/glasses/safety/goggles/medical/zeng(src)
	new /obj/item/reagent_containers/hypospray/combat/empty(src)
// Patients
	new /obj/item/clothing/under/medical_gown/pink(src)
	new /obj/item/clothing/under/medical_gown/pink(src)

/obj/structure/closet/secure_closet/medical/nralakk/surgery
	name = "surgical closet"
	desc = "Contains scrubs for performing surgery in an operating theatre."

/obj/structure/closet/secure_closet/medical/nralakk/surgery/fill()
	..()
	new /obj/item/clothing/under/rank/medical/surgeon/zeng(src)
	new /obj/item/clothing/suit/storage/surgical_gown/zeng(src)
	new /obj/item/clothing/accessory/apron/surgery/zeng(src)
	new /obj/item/clothing/head/surgery/zeng(src)
	new /obj/item/clothing/shoes/sneakers/medsci/zeng(src)
	new /obj/item/storage/firstaid/surgery(src)

/obj/structure/closet/crate/freezer/nralakk
name = "iv supply freezer"
desc = "A temperature controlled crate containing blood products and crystalloids for intravenous infusion."

/obj/structure/closet/crate/freezer/nralakk/fill()
	..()
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/saline_plus(src)
	new /obj/item/reagent_containers/blood/saline_plus(src)

/obj/structure/closet/crate/freezer/nralakk/surgery
name = "surgical freezer"
desc = "A temperature controlled crate for surgical biopsy samples."

/obj/structure/closet/crate/freezer/nralakk/fill()
	..()
	new /obj/item/storage/box/unique/freezer/organcooler(src)
	new /obj/item/storage/box/unique/freezer/organcooler(src)
	new /obj/item/storage/box/unique/freezer/organcooler/psireceiver(src)
	new /obj/item/storage/box/unique/monkeycubes/neaeracubes(src)

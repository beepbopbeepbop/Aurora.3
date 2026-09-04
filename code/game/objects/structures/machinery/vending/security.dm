/**
 *	SecTech
 *	Tactical Express
 *	Nanosecurity Plus
 */

/obj/structure/machinery/vending/security
	name = "SecTech"
	desc = "A security equipment vendor."
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon_state = "sec"
	icon_vend = "sec-vend"
	req_access = list(ACCESS_SECURITY)
	vend_id = "security"
	products = list(
		/obj/item/handcuffs = 20,
		/obj/item/flash = 6,
		/obj/item/reagent_containers/spray/pepper = 6,
		/obj/item/storage/box/evidence = 6,
		/obj/item/holowarrant = 6,
		/obj/item/flashlight/maglight = 6,
		/obj/item/hailer = 6,
		/obj/item/reagent_containers/food/snacks/donut/normal = 6
	)
	premium = list(
		/obj/item/storage/box/fancy/donut = 2
	)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/grenade/flashbang = 4,
		/obj/item/grenade/stinger = 4
	)
	restock_blocked_items = list(
		/obj/item/storage/box/fancy/donut,
		/obj/item/storage/box/evidence,
		/obj/item/flash,
		/obj/item/reagent_containers/spray/pepper
		)
	restock_items = TRUE
	random_itemcount = 0
	light_color = COLOR_BABY_BLUE
	manufacturer = "zavodskoi"

/obj/structure/machinery/vending/security/low_supply
	products = list(
		/obj/item/handcuffs = 2,
		/obj/item/flash = 2,
		/obj/item/reagent_containers/spray/pepper = 2,
		/obj/item/storage/box/evidence = 4,
		/obj/item/holowarrant = 3,
		/obj/item/flashlight/maglight = 2,
		/obj/item/hailer = 1
	)

/obj/item/vending_refill/robust
	name = "security resupply canister"
	vend_id = "security"
	charges = 25


/obj/structure/machinery/vending/tacticool //Tried not to go overboard with the amount of fun security has access to.
	name = "Tactical Express"
	desc = "Everything you need to ensure corporate bureaucracy makes it another day."
	icon_state = "tact"
	req_access = list(ACCESS_SECURITY)
	vend_id = "tactical" // Refill cartridge DNE 2025/07
	products = list(
		/obj/item/clothing/accessory/storage/bandolier = 4,
		/obj/item/clothing/accessory/storage/modular_pouch/large = 4,
		/obj/item/clothing/gloves/swat/tactical = 6,
		/obj/item/clothing/accessory/goon_coif = 6,
		/obj/item/clothing/mask/gas/tactical = 6,
		/obj/item/clothing/glasses/safety/goggles/goon = 6,
		/obj/item/clothing/ears/earmuffs = 6,
		/obj/item/clothing/head/leader_headband = 2,
		/obj/item/ammo_display = 8,
		/obj/item/handcuffs/legcuffs = 2,
	)
	contraband = list(
		/obj/item/grenade/flashbang/clusterbang = 1 //this can only go well.
	)
	premium = list(
		/obj/item/grenade/chem_grenade/gas = 2
	)
	restock_items = TRUE
	random_itemcount = 0
	light_color = COLOR_BROWN
	manufacturer = "zavodskoi"

/obj/structure/machinery/vending/tacticool/ert //Slightly more !FUN!
	name = "Nanosecurity Plus"
	desc = "For when shit really goes down; the private contractor's personal armory."
	req_access = list(ACCESS_SECURITY)
	vend_id = "ert" // Refill cartridge DNE 2025/07
	products = list(
		/obj/item/storage/box/shells/slugs = 2,
		/obj/item/storage/box/shells/buckshot = 2,
		/obj/item/grenade/chem_grenade/gas = 6,
		/obj/item/clothing/mask/gas/tactical = 8,
		/obj/item/shield/riot/tact = 4,
		/obj/item/handcuffs/ziptie = 6,
		/obj/item/ammo_magazine/mc9mmt = 6,
		/obj/item/ammo_magazine/mc9mmt/rubber = 4,
		/obj/item/gun/projectile/automatic/x9 = 2,
		/obj/item/ammo_magazine/c45m/auto = 6,
		/obj/item/ammo_magazine/a556 = 12,
		/obj/item/ammo_magazine/a556/ap = 4,
		/obj/item/material/knife/tacknife = 4,
		/obj/item/firing_pin = 12
	)
	contraband = list(
		/obj/item/gun/bang/deagle = 1
	)
	premium = list(
		/obj/item/shield/riot/tact = 2
	)
	random_itemcount = 0
	manufacturer = "zavodskoi"

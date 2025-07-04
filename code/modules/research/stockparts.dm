#define STOCK_PART_BASIC 1
#define STOCK_PART_ADVANCED 2
#define STOCK_PART_SUPER 3

/*
	Stock parts (as of 2025/06) are only able to be installed in machinery objects.

	They improve the functionality of the machine in various ways, scaling with their rating. The
	impact any given part type has on a machine should be described in a var/hint_[parttype].

	By default, higher-rated parts will also increase machine power usage- refer to energy_rating()
	to see the multiplier the total energy rating will apply to power usage.

	By assigning a machinery the variable "parts_power_mgmt = FALSE", bespoke power usage code can
	be applied (i.e. upgrades that reduce power usage). This should be modified in the future to
	accommodate more flexible and intuitive power draw changes due to stock parts, but was implemented
	this way by Bat just to accommodate existing machine upgrades. Future changes will entail a more
	in-depth balance pass.

	Tcomms stock parts are somewhat weirder, not following the same 'rank' behavior as the standard
	cluster of ranked five. They are also no longer used exclusively in Tcomms machinery- for example,
	the Hull Shield Generator requires both standard and Tcomms stock parts. This should also be
	addressed in future.
*/

/obj/item/storage/bag/stockparts_box
	name = "stock parts box"
	desc = "A low-tech method of storing stock parts used in machinery."
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "empty_box"
	w_class = WEIGHT_CLASS_NORMAL
	display_contents_with_number = TRUE
	storage_slots = 25
	can_hold = list(
				/obj/item/stock_parts,
				/obj/item/device/multitool,
				/obj/item/stack/cable_coil
					)
	max_w_class = WEIGHT_CLASS_SMALL
	max_storage_space = 60
	matter = list(DEFAULT_WALL_MATERIAL = 750)

/obj/item/storage/bag/stockparts_box/basic
	name = "basic stock parts box"
	starts_with = list(
					/obj/item/stock_parts/console_screen = 5,
					/obj/item/stock_parts/capacitor = 3,
					/obj/item/stock_parts/scanning_module = 3,
					/obj/item/stock_parts/manipulator = 3,
					/obj/item/stock_parts/micro_laser = 3,
					/obj/item/stock_parts/matter_bin = 3
					)

/obj/item/storage/bag/stockparts_box/advanced
	name = "advanced stock parts box"
	starts_with = list(
					/obj/item/stock_parts/console_screen = 5,
					/obj/item/stock_parts/capacitor/adv = 3,
					/obj/item/stock_parts/scanning_module/adv = 3,
					/obj/item/stock_parts/manipulator/nano = 3,
					/obj/item/stock_parts/micro_laser/high = 3,
					/obj/item/stock_parts/matter_bin/adv = 3
					)

/obj/item/storage/bag/stockparts_box/super
	name = "super stock parts box"
	starts_with = list(
					/obj/item/stock_parts/console_screen = 5,
					/obj/item/stock_parts/capacitor/super = 3,
					/obj/item/stock_parts/scanning_module/phasic = 3,
					/obj/item/stock_parts/manipulator/pico = 3,
					/obj/item/stock_parts/micro_laser/ultra = 3,
					/obj/item/stock_parts/matter_bin/super = 3
					)

/obj/item/storage/bag/stockparts_box/telecomms
	name = "telecommunications stock parts box"
	starts_with = list(
					"/obj/item/stock_parts/console_screen" = 2,
					"/obj/item/stock_parts/subspace/ansible" = 5,
					"/obj/item/stock_parts/subspace/filter" = 5,
					"/obj/item/stock_parts/subspace/amplifier" = 5,
					"/obj/item/stock_parts/subspace/treatment" = 5,
					"/obj/item/stock_parts/subspace/analyzer" = 5,
					"/obj/item/stock_parts/subspace/crystal" = 5,
					"/obj/item/stock_parts/subspace/transmitter" = 5
					)

/obj/item/stock_parts
	name = "stock part"
	var/parent_stock_name = "stock part" // this will show up on the protolathe to show what the base version was called
	desc = "What?"
	gender = PLURAL
	icon = 'icons/obj/stock_parts.dmi'
	randpixel = 5
	w_class = WEIGHT_CLASS_SMALL
	var/rating = STOCK_PART_BASIC
	drop_sound = 'sound/items/drop/component.ogg'
	pickup_sound = 'sound/items/pickup/component.ogg'
	recyclable = TRUE

/obj/item/stock_parts/Initialize()
	. = ..()
	randpixel_xy()

/obj/item/stock_parts/proc/energy_rating()
	switch(rating)
		if(STOCK_PART_BASIC)
			return 1
		if(STOCK_PART_ADVANCED)
			return 3
		if(STOCK_PART_SUPER)
			return 5
		else
			return 0

//Rank 1

/obj/item/stock_parts/console_screen
	name = "console screen"
	desc = "Used in the construction of computers and other devices with a interactive console."
	icon_state = "screen"
	origin_tech = list(TECH_MATERIAL = 1)
	matter = list(MATERIAL_GLASS = 200)
	drop_sound = 'sound/items/drop/glass.ogg'
	pickup_sound = 'sound/items/pickup/glass.ogg'

/obj/item/stock_parts/capacitor
	name = "capacitor"
	parent_stock_name = "capacitor"
	desc = "A basic capacitor used in the construction of a variety of devices."
	icon_state = "capacitor"
	origin_tech = list(TECH_POWER = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 50, MATERIAL_GLASS = 50)

/obj/item/stock_parts/scanning_module
	name = "scanning module"
	parent_stock_name = "scanning module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "scan_module"
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 50, MATERIAL_GLASS = 20)

/obj/item/stock_parts/manipulator
	name = "micro-manipulator"
	parent_stock_name = "micro-manipulator"
	desc = "A tiny micrometer-scale manipulator used in the construction of certain devices."
	icon_state = "micro_mani"
	origin_tech = list(TECH_MATERIAL = 1, TECH_DATA = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 30)

/obj/item/stock_parts/micro_laser
	name = "micro-laser"
	parent_stock_name = "micro-laser"
	desc = "A tiny laser used in certain devices."
	icon_state = "micro_laser"
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 10, MATERIAL_GLASS = 20)
	drop_sound = 'sound/items/drop/glass_small.ogg'
	pickup_sound = 'sound/items/pickup/glass_small.ogg'

/obj/item/stock_parts/matter_bin
	name = "matter bin"
	parent_stock_name = "matter bin"
	desc = "A container for holding compressed matter awaiting re-construction."
	icon_state = "matter_bin"
	origin_tech = list(TECH_MATERIAL = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 80)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

//Rank 2

/obj/item/stock_parts/capacitor/adv
	name = "advanced capacitor"
	desc = "A compact, ultra-high resolution scanning module used in the construction of certain devices."
	icon_state = "adv_capacitor"
	origin_tech = list(TECH_POWER = 3)
	rating = STOCK_PART_ADVANCED
	matter = list(DEFAULT_WALL_MATERIAL = 50, MATERIAL_GLASS = 50)

/obj/item/stock_parts/scanning_module/adv
	name = "advanced scanning module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "adv_scan_module"
	origin_tech = list(TECH_MAGNET = 3)
	rating = STOCK_PART_ADVANCED
	matter = list(DEFAULT_WALL_MATERIAL = 50, MATERIAL_GLASS = 20)

/obj/item/stock_parts/manipulator/nano
	name = "nano-manipulator"
	desc = "A tiny nanometer-scale manipulator used in the construction of certain devices."
	icon_state = "nano_mani"
	origin_tech = list(TECH_MATERIAL = 3, TECH_DATA = 2)
	rating = STOCK_PART_ADVANCED
	matter = list(DEFAULT_WALL_MATERIAL = 30)

/obj/item/stock_parts/micro_laser/high
	name = "high-power micro-laser"
	desc = "A tiny, high-powered laser used in certain devices."
	icon_state = "high_micro_laser"
	origin_tech = list(TECH_MAGNET = 3)
	rating = STOCK_PART_ADVANCED
	matter = list(DEFAULT_WALL_MATERIAL = 10, MATERIAL_GLASS = 20)

/obj/item/stock_parts/matter_bin/adv
	name = "advanced matter bin"
	icon_state = "advanced_matter_bin"
	origin_tech = list(TECH_MATERIAL = 3)
	rating = STOCK_PART_ADVANCED
	matter = list(DEFAULT_WALL_MATERIAL = 80)

//Rating 3

/obj/item/stock_parts/capacitor/super
	name = "super capacitor"
	desc = "A super-high capacity capacitor used in the construction of a variety of devices."
	icon_state = "super_capacitor"
	origin_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	rating = STOCK_PART_SUPER
	matter = list(DEFAULT_WALL_MATERIAL = 50, MATERIAL_GLASS = 50)

/obj/item/stock_parts/scanning_module/phasic
	name = "phasic scanning module"
	desc = "A compact, ultra-high resolution phasic scanning module used in the construction of certain devices."
	icon_state = "super_scan_module"
	origin_tech = list(TECH_MAGNET = 5)
	rating = STOCK_PART_SUPER
	matter = list(DEFAULT_WALL_MATERIAL = 50, MATERIAL_GLASS = 20)

/obj/item/stock_parts/manipulator/pico
	name = "pico-manipulator"
	desc = "A tiny picometer-scale manipulator used in the construction of certain devices."
	icon_state = "pico_mani"
	origin_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	rating = STOCK_PART_SUPER
	matter = list(DEFAULT_WALL_MATERIAL = 30)

/obj/item/stock_parts/micro_laser/ultra
	name = "ultra-high-power micro-laser"
	desc = "A tiny, alarmingly high-powered laser used in certain devices."
	icon_state = "ultra_high_micro_laser"
	origin_tech = list(TECH_MAGNET = 5)
	rating = STOCK_PART_SUPER
	matter = list(DEFAULT_WALL_MATERIAL = 10, MATERIAL_GLASS = 20)

/obj/item/stock_parts/matter_bin/super
	name = "super matter bin"
	desc = "A container for holding compressed matter awaiting reconstruction. Fortunately, this is a super 'matter bin', not a 'super matter' bin."
	icon_state = "super_matter_bin"
	origin_tech = list(TECH_MATERIAL = 5)
	rating = STOCK_PART_SUPER
	matter = list(DEFAULT_WALL_MATERIAL = 80)

//TCOMS stock parts

/obj/item/stock_parts/subspace/ansible
	name = "subspace ansible"
	icon_state = "subspace_ansible"
	desc = "A compact module capable of sensing extradimensional activity."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 5 ,TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 30, MATERIAL_GLASS = 10)

/obj/item/stock_parts/subspace/filter
	name = "hyperwave filter"
	icon_state = "hyperwave_filter"
	desc = "A tiny device capable of filtering and converting super-intense radiowaves."
	origin_tech = list(TECH_DATA = 4, TECH_MAGNET = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 30, MATERIAL_GLASS = 10)

/obj/item/stock_parts/subspace/amplifier
	name = "subspace amplifier"
	icon_state = "subspace_amplifier"
	desc = "A compact micro-machine capable of amplifying weak subspace transmissions."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 30, MATERIAL_GLASS = 10)

/obj/item/stock_parts/subspace/treatment
	name = "subspace treatment disk"
	icon_state = "treatment_disk"
	desc = "A compact micro-machine capable of stretching out hyper-compressed radio waves."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 2, TECH_MATERIAL = 5, TECH_BLUESPACE = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 30, MATERIAL_GLASS = 10)

/obj/item/stock_parts/subspace/analyzer
	name = "subspace wavelength analyzer"
	icon_state = "wavelength_analyzer"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 30, MATERIAL_GLASS = 10)

/obj/item/stock_parts/subspace/crystal
	name = "ansible crystal"
	icon_state = "ansible_crystal"
	desc = "A crystal made from pure glass used to transmit laser databursts to subspace."
	origin_tech = list(TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(MATERIAL_GLASS = 50)

/obj/item/stock_parts/subspace/transmitter
	name = "subspace transmitter"
	icon_state = "subspace_transmitter"
	desc = "A large piece of equipment used to open a window into the subspace dimension."
	origin_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 5, TECH_BLUESPACE = 3)
	matter = list(DEFAULT_WALL_MATERIAL = 50)

#undef STOCK_PART_BASIC
#undef STOCK_PART_ADVANCED
#undef STOCK_PART_SUPER

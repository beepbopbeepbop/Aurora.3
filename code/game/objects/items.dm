/obj/item
	name = "item"
	icon = 'icons/obj/items.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	blocks_emissive = EMISSIVE_BLOCK_GENERIC

	/// This saves our blood splatter overlay, which will be processed not to go over the edges of the sprite
	var/image/blood_overlay

	var/randpixel = 6
	var/abstract = 0
	var/r_speed = 1.0
	var/health
	var/burn_point
	var/burning

	/// Generic hit sound
	var/hitsound = /singleton/sound_category/swing_hit_sound

	var/storage_cost

	var/storage_slot_sort_by_name = FALSE

	/// Dimensions of the icon file used when this item is worn, eg: hats.dmi (32x32 sprite, 64x64 sprite, etc.). Allows inhands/worn sprites to be of any size, but still centered on a mob properly
	var/worn_x_dimension = 32

	/// Dimensions of the icon file used when this item is worn, eg: hats.dmi (32x32 sprite, 64x64 sprite, etc.). Allows inhands/worn sprites to be of any size, but still centered on a mob properly
	var/worn_y_dimension = 32

	/**
	 * Determines which slots an item can fit, eg. `SLOT_BACK`
	 *
	 * See `code\__DEFINES\items_clothing.dm` for the list of defined slots
	 */
	var/slot_flags = 0

	///Boolean, determines if this object generates attack logs
	var/no_attack_log = FALSE

	pass_flags = PASSTABLE | PASSRAILING
	var/obj/item/master

	/**
	 * Flags which determine which body parts are protected from heat, eg. `HEAD` and `UPPER_TORSO`
	 *
	 * See `code\__DEFINES\items_clothing.dm` for the list of defined parts
	 */
	var/heat_protection = 0

	/**
	 * Flags which determine which body parts are protected from cold, eg. `HEAD` and `UPPER_TORSO`
	 *
	 * See `code\__DEFINES\items_clothing.dm` for the list of defined parts
	 */
	var/cold_protection = 0

	/**
	 * Set this variable to determine up to which temperature (IN KELVIN) the item protects against heat damage
	 *
	 * Keep at null to disable protection. Only protects areas set by heat_protection flags
	 */
	var/max_heat_protection_temperature = null

	/**
	 * Set this variable to determine down to which temperature (IN KELVIN) the item protects against cold damage
	 *
	 * 0 is NOT an acceptable number due to if(varname) tests!!
	 *
	 * Keep at null to disable protection. Only protects areas set by cold_protection flags
	 */
	var/min_cold_protection_temperature = null

	//Set this variable if the item protects its wearer against high pressures below an upper bound. Keep at null to disable protection
	var/max_pressure_protection

	/**
	 * Set this variable if the item protects its wearer against low pressures above a lower bound
	 * Keep at null to disable protection
	 *
	 * 0 represents protection against hard vacuum
	 */
	var/min_pressure_protection

	var/datum/action/item_action/action

	/**
	 * It is also the text which gets displayed on the action button
	 *
	 * If not set it defaults to 'Use [name]'
	 *
	 * If it's not set, there'll be no button
	 */
	var/action_button_name

	///Specify the default type and behavior of the action button for this atom
	var/default_action_type = /datum/action/item_action

	/**
	 * This flag is used to determine when items in someone's inventory cover others. IE helmets making it so you can't see glasses, etc.
	 *
	 * It should be used purely for appearance. For gameplay effects caused by items covering body parts, use body_parts_covered
	 */
	var/flags_inv = 0

	///What body parts are covered by the clothing when you wear it. See `code\__DEFINES\items_clothing.dm` for appropriate bit flags
	var/body_parts_covered = 0

	/// Miscellaneous flags pertaining to equippable objects. See `code\__DEFINES\flags.dm` for appropriate bit flags
	var/item_flags = 0

	//var/heat_transfer_coefficient = 1 //0 prevents all transfers, 1 is invisible

	/// For leaking gas from turf to mask and vice-versa
	var/gas_transfer_coefficient = 1
	/// For chemicals/diseases
	var/permeability_coefficient = 1
	/// For electrical admittance/conductance (eg. electrocution checks)
	var/siemens_coefficient = 1
	/// How much clothing is slowing you down. Negative values speeds you up
	var/slowdown = 0
	/// Updated on accessory add/remove. This is how much the current accessories slow you down.
	var/slowdown_accessory = 0

	/// Boolean, mostly for Ninja code at this point but basically will not allow the item to be removed if set to `FALSE`
	var/canremove = TRUE

	/// If `FALSE`, this item/weapon cannot become embedded in people when you hit them with it
	var/can_embed = TRUE

	/// Suit storage stuff.
	var/list/allowed = null

	/// All items can have an uplink hidden inside, just remember to add the triggers.
	var/obj/item/device/uplink/hidden/hidden_uplink

	/// Name used for message when binoculars/scope is used
	var/zoomdevicename
	/// Boolean, `TRUE` if item is actively being used to zoom. For scoped guns and binoculars.
	var/zoom = FALSE

	/// Boolean, if item_state, lefthand, righthand, and worn sprite are all in one dmi
	var/contained_sprite = FALSE

	/// Used when thrown into a mob
	var/mob_throw_hit_sound
	/// Sound used when equipping the item into a valid slot
	var/equip_sound = null
	/// Sound uses when picking the item up (into your hands)
	var/pickup_sound = /singleton/sound_category/generic_pickup_sound
	/// Sound uses when dropping the item, or when its thrown.
	var/drop_sound = /singleton/sound_category/generic_drop_sound

	var/list/armor
	/// How fast armor will degrade, multiplier to blocked damage to get armor damage value.
	var/armor_degradation_speed

	//Item_state definition moved to /obj
	//var/item_state = null // Used to specify the item state for the on-mob overlays.

	/// Overrides the default item_state for particular slots.
	var/item_state_slots
	/// Used in furniture for previews. Used in material weapons too
	var/base_icon
	/// Boolean, when it uses coloration and a part of it wants to remain uncolored. e.g., handle of the screwdriver is colored while the head is not.
	var/build_from_parts = FALSE
	/// Inhands overlay
	var/worn_overlay = null
	/// When you want your worn overlay to have colors. So you can have more than one modular coloring.
	var/worn_overlay_color = null
	/// When you want to slice out a chunk from a sprite
	var/alpha_mask
	/// Boolean, determines whether accent colour is applied or not
	var/has_accents = FALSE
	/// appearance_flags Bitflag, when has_accents is set to true, this will determine which flags will be applied to the accent image
	var/accent_flags = RESET_COLOR
	/// Used for accents which are coloured differently to the main body of the sprite
	var/accent_color = COLOR_GRAY

	/**
	 * ITEM_ICONS ARE DEPRECATED. USE CONTAINED SPRITES IN FUTURE
	 *
	 * Used to specify the icon file to be used when the item is worn. If not set the default icon for that slot will be used.
	 * If icon_override or sprite_sheets are set they will take precendence over this, assuming they apply to the slot in question.
	 * Only slot_l_hand/slot_r_hand are implemented at the moment. Others to be implemented as needed.
	 */
	var/list/item_icons

	/**
	 * These specify item/icon overrides for _species_
	 *
	 * Species-specific sprites definition, eg:
	 *
	 * ```
	 * sprite_sheets = list(
	 * 		BODYTYPE_TAJARA = 'icons/cat/are/bad'
	 * 		)
	 * ```
	 *
	 * If index term exists and icon_override is not set, this sprite sheet will be used.
	 */
	var/list/sprite_sheets

	/**
	 * Species-specific sprite sheets for inventory sprites
	 *
	 * Works similarly to worn sprite_sheets, except the alternate sprites are used when the clothing/refit_for_species() proc is called
	 */
	var/list/sprite_sheets_obj

	/// Used to override hardcoded clothing dmis in human clothing pr
	var/icon_override

	var/charge_failure_message = " cannot be recharged."
	var/held_maptext

	var/cleaving = FALSE

	/// Length of tiles it can reach, 1 is adjacent.
	var/reach = 1

	/// Used to determine whether something can pick a lock, and how well
	var/lock_picking_level = 0

	/// Used to determine what this item can be changed into with a modkit
	var/list/convert_options

	/// Tooltip vars
	var/in_inventory = FALSE //is this item equipped into an inventory slot or hand of a mob?
	var/tip_timer = 0

	// item hover FX
	/// Is this item inside a storage object?
	var/in_storage = FALSE
	/// Holder var for the item outline filter, null when no outline filter on the item.
	var/outline_filter

/obj/item/Initialize(mapload, ...)
	. = ..()
	if(islist(armor))
		for(var/type in armor)
			if(armor[type])
				AddComponent(/datum/component/armor, armor)
				break
	if(item_flags & ITEM_FLAG_HELD_MAP_TEXT)
		set_initial_maptext()
		check_maptext()

/obj/item/Destroy()
	if(ismob(loc))
		var/mob/m = loc
		m.drop_from_inventory(src)
		m.update_inv_r_hand()
		m.update_inv_l_hand()
		src.loc = null

	if(!QDELETED(action))
		QDEL_NULL(action) // /mob/living/proc/handle_actions() creates it, for ungodly reasons
	action = null

	if(!QDELETED(hidden_uplink))
		QDEL_NULL(hidden_uplink)
	hidden_uplink = null

	master = null
	. = ..()

/obj/item/update_icon()
	. = ..()
	if(build_from_parts || has_accents)
		ClearOverlays()
	if(build_from_parts)
		AddOverlays(overlay_image(icon,"[icon_state]_[worn_overlay]", flags=RESET_COLOR)) //add the overlay w/o coloration of the original sprite
	if(has_accents)
		AddOverlays(overlay_image(icon, "[icon_state]_acc", accent_color, accent_flags))

/obj/item/device
	pickup_sound = 'sound/items/pickup/device.ogg'
	drop_sound = 'sound/items/drop/device.ogg'
	contained_sprite = TRUE
	item_state = "electronic"

/atom/proc/get_cell()
	return DEVICE_NO_CELL

//Checks if the item is being held by a mob, and if so, updates the held icons
/obj/item/proc/update_held_icon()
	if(ismob(src.loc))
		var/mob/M = src.loc
		if(M.l_hand == src)
			M.update_inv_l_hand()
		if(M.r_hand == src)
			M.update_inv_r_hand()

/obj/item/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return
		if(3.0)
			if (prob(5))
				qdel(src)
				return

	return

/obj/item/verb/move_to_top(obj/item/I in range(1))
	set name = "Move To Top"
	set category = "Object"

	if (!(I in view(1, src)))
		return
	if(!istype(I.loc, /turf) || usr.stat || usr.restrained() )
		return
	var/turf/T = I.loc

	I.loc = null

	I.forceMove(T)

/obj/item/get_examine_text(mob/user, distance, is_adjacent, infix, suffix, get_extended = FALSE)
	var/size
	switch(src.w_class)
		if (WEIGHT_CLASS_HUGE to INFINITY)
			size = "huge"
		if (WEIGHT_CLASS_BULKY to WEIGHT_CLASS_HUGE)
			size = "bulky"
		if (WEIGHT_CLASS_NORMAL to WEIGHT_CLASS_BULKY)
			size = "normal-sized"
		if (WEIGHT_CLASS_SMALL to WEIGHT_CLASS_NORMAL)
			size = "small"
		if (0 to WEIGHT_CLASS_SMALL)
			size = "tiny"
	//Changed this switch to ranges instead of tiered values, to cope with granularity and also
	//things outside its range ~Nanako

	. = ..(user, distance, "", "It is a [size] item.", get_extended = get_extended)
	var/datum/component/armor/armor_component = GetComponent(/datum/component/armor)
	if(armor_component)
		. += FONT_SMALL(SPAN_NOTICE("\[?\] This item has armor values. <a href='byond://?src=[REF(src)];examine_armor=1'>\[Show Armor Values\]</a>"))

/obj/item/Topic(href, href_list)
	if(href_list["examine_armor"])
		var/datum/component/armor/armor_component = GetComponent(/datum/component/armor)
		var/list/armor_details = list()
		for(var/armor_type in armor_component.armor_values)
			armor_details[armor_type] = armor_component.armor_values[armor_type]
		var/datum/tgui_module/armor_values/AV = new /datum/tgui_module/armor_values(usr, capitalize_first_letters(name), armor_details)
		AV.ui_interact(usr)
	return ..()

/obj/item/attack_hand(mob/user)
	if(!user)
		return
	if(ishuman(user))
		if(iszombie(user))
			to_chat(user, SPAN_WARNING("You uselessly claw at \the [src], your rotting brain incapable of picking it up or operating it."))
			return
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/external/temp = H.organs_by_name[BP_R_HAND]
		if (user.hand)
			temp = H.organs_by_name[BP_L_HAND]
		if(temp && !temp.is_usable())
			to_chat(user, SPAN_NOTICE("You try to move your [temp.name], but cannot!"))
			return
		if(!temp)
			to_chat(user, SPAN_NOTICE("You try to use your hand, but realize it is no longer attached!"))
			return
	if(!do_additional_pickup_checks(user))
		return
	var/obj/item/storage/S
	var/storage_depth_matters = TRUE
	if(istype(src.loc, /obj/item/storage))
		S = src.loc
		if(!S.care_about_storage_depth)
			storage_depth_matters = FALSE
	if(storage_depth_matters && !src.Adjacent(user))
		to_chat(user, SPAN_NOTICE("\The [src] slips out of your grasp before you can grab it!")) // because things called before this can move it
		return // please don't pick things up
	src.pickup(user)
	if(S)
		S.remove_from_storage(src)
	QDEL_NULL(throwing)
	if (src.loc == user)
		if(!user.prepare_for_slotmove(src))
			return
	else if(isliving(src.loc))
		return

	// If equipping onto active hand fails, drop it on the floor.
	if (!user.put_in_active_hand(src))
		forceMove(user.loc)
	return

/obj/item/proc/do_additional_pickup_checks(var/mob/user)
	return TRUE

/obj/item/attack_ai(mob/user as mob)
	if (istype(src.loc, /obj/item/robot_module))
		//If the item is part of a cyborg module, equip it
		if(!isrobot(user))
			return
		var/mob/living/silicon/robot/R = user
		R.activate_module(src)
		R.hud_used.update_robot_modules_display()

/**
 * Called when the user alt-clicks on something with this item in their active hand
 *
 * This function is designed to be overridden by individual weapons
 *
 * A return value of `TRUE` continues on to do the normal alt-click action,
 * a return value of `FALSE` does not continue, and will not do the alt-click
 */
/obj/item/proc/alt_attack(var/atom/target, var/mob/user)
	return TRUE

/obj/item/proc/talk_into(mob/M as mob, text)
	return

/obj/item/proc/moved(mob/user as mob, old_loc as turf)
	return

/obj/item/proc/get_volume_by_throwforce_and_or_w_class()
		if(throwforce && w_class)
				return clamp((throwforce + w_class) * 5, 30, 100)// Add the item's throwforce to its weight class and multiply by 5, then clamp the value between 30 and 100
		else if(w_class)
				return clamp(w_class * 8, 20, 100) // Multiply the item's weight class by 8, then clamp the value between 20 and 100
		else
				return 0

/obj/item/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(QDELETED(hit_atom))
		return
	if(SEND_SIGNAL(src, COMSIG_MOVABLE_PRE_IMPACT, hit_atom, throwingdatum) & COMPONENT_MOVABLE_IMPACT_NEVERMIND)
		return
	if(SEND_SIGNAL(hit_atom, COMSIG_ATOM_PREHITBY, src, throwingdatum) & COMSIG_HIT_PREVENTED)
		return

	var/volume = get_volume_by_throwforce_and_or_w_class()
	if(isliving(hit_atom)) //Living mobs handle hit sounds differently.
		var/mob/living/L = hit_atom
		if(L.in_throw_mode)
			playsound(hit_atom, pickup_sound, PICKUP_SOUND_VOLUME, TRUE)
		else
			if(throwforce > 0)
				if(mob_throw_hit_sound)
					playsound(hit_atom, mob_throw_hit_sound, volume, TRUE, -1)
				else if(hitsound)
					playsound(hit_atom, hitsound, volume, TRUE, -1)
				else
					playsound(hit_atom, 'sound/weapons/Genhit.ogg', volume, TRUE, -1)
			else
				playsound(hit_atom, 'sound/weapons/throwtap.ogg', 1, volume, -1)
	else
		playsound(src, drop_sound, volume)

	var/itempush = TRUE
	if(w_class < WEIGHT_CLASS_NORMAL)
		itempush = FALSE //too light to push anything

	return hit_atom.hitby(src, 0, itempush, throwingdatum=throwingdatum)

/**
 * Called when an item is removed from a `/mob` inventory (including hands and whatnot),
 * for whatever reason (dropped on the floor, thrown, put in a container, etc.)
 *
 * This is called after the _new_ location (`loc`) is set on the object, so if it's eg. put in a container,
 * the loc inside here would point to the container, not the mob that had it in hand
 *
 * * user - The `/mob` that dropped the object (was removed from, not necessarily who clicked the button)
 */
/obj/item/proc/dropped(mob/user)
	SHOULD_CALL_PARENT(TRUE)

	remove_item_verbs(user)

	if(item_flags & ITEM_FLAG_HELD_MAP_TEXT)
		check_maptext()

	if(zoom)
		zoom(user) //binoculars, scope, etc

	SEND_SIGNAL(src, COMSIG_ITEM_DROPPED, user)

	in_inventory = FALSE

	if(user && (z_flags & ZMM_MANGLE_PLANES))
		addtimer(CALLBACK(user, /mob/proc/check_emissive_equipment), 0, TIMER_UNIQUE)

	user?.update_equipment_speed_mods()

/obj/item/proc/remove_item_verbs(mob/user)
	if(ismech(user)) //very snowflake, but necessary due to how mechs work
		return
	if(QDELETED(user))
		return
	var/list/verbs_to_remove = list()
	for(var/v in verbs)
		var/verbstring = "[v]"
		if(length(user.item_verbs[verbstring]) == 1)
			if(user.item_verbs[verbstring][1] == src)
				verbs_to_remove += v
		LAZYREMOVE(user.item_verbs[verbstring], src)
	remove_verb(user, verbs_to_remove)


// Called whenever an object is moved around inside the mob's contents.
// Linker proc: mob/proc/prepare_for_slotmove, which is referenced in proc/handle_item_insertion and obj/item/attack_hand.
// This shit exists so that dropped() could almost exclusively be called when an item is dropped.
/obj/item/proc/on_slotmove(var/mob/user, slot)
	if(zoom)
		zoom(user)
	SEND_SIGNAL(src, COMSIG_ITEM_REMOVE, src)

///Called just as an item is picked up (loc is not yet changed)
/obj/item/proc/pickup(mob/user)
	pixel_x = 0
	pixel_y = 0
	SEND_SIGNAL(src, COMSIG_ITEM_PICKUP, user)
	if(item_flags & ITEM_FLAG_HELD_MAP_TEXT)
		addtimer(CALLBACK(src, PROC_REF(check_maptext)), 1) // invoke async does not work here
	in_inventory = TRUE
	do_pickup_animation(user)

// called when this item is removed from a storage item, which is passed on as S. The loc variable is already set to the new destination before this is called.
/obj/item/proc/on_exit_storage(obj/item/storage/S as obj)
	do_drop_animation(S)
	in_storage = FALSE
	return

// called when this item is added into a storage item, which is passed on as S. The loc variable is already set to the storage item.
/obj/item/proc/on_enter_storage(obj/item/storage/S as obj)
	in_storage = TRUE
	return

// called when "found" in pockets and storage items. Returns 1 if the search should end.
/obj/item/proc/on_found(mob/finder as mob)
	return

/**
 * Called after an item is placed in an equipment slot. Runs equipped(), then sends a signal.
 * This should be called last or near-to-last, after all other inventory code stuff is handled.
 *
 * Arguments:
 * * user is mob that equipped it
 * * slot uses the slot_X defines found in setup.dm for items that can be placed in multiple slots
 * * initial is used to indicate whether or not this is the initial equipment (job datums etc) or just a player doing it
 */
/obj/item/proc/on_equipped(mob/user, slot, initial = FALSE)
	SHOULD_NOT_OVERRIDE(TRUE)
	equipped(user, slot, initial)
	if(SEND_SIGNAL(src, COMSIG_ITEM_POST_EQUIPPED, user, slot) && COMPONENT_EQUIPPED_FAILED)
		return FALSE
	return TRUE


/**
 * Called by on_equipped. Don't call this directly, we want the ITEM_POST_EQUIPPED signal to be sent after everything else.
 *
 * Note that hands count as slots.
 *
 * Arguments:
 * * user is mob that equipped it
 * * slot uses the slot_X defines found in setup.dm for items that can be placed in multiple slots
 * * initial is used to indicate whether or not this is the initial equipment (job datums etc) or just a player doing it
 */
/obj/item/proc/equipped(mob/user, slot, initial = FALSE)
	SHOULD_CALL_PARENT(TRUE)
	PROTECTED_PROC(TRUE)
	SEND_SIGNAL(src, COMSIG_ITEM_EQUIPPED, user, slot)
	SEND_SIGNAL(user, COMSIG_MOB_EQUIPPED_ITEM, src, slot)
	hud_layerise()
	equip_slot = slot
	if(user.client)	user.client.screen |= src
	if(user.pulling == src) user.stop_pulling()
	in_inventory = TRUE

	if(!initial)
		if(slot == slot_l_hand || slot == slot_r_hand)
			playsound(src, pickup_sound, PICKUP_SOUND_VOLUME)
		else if(slot_flags && slot)
			if(equip_sound)
				playsound(src, equip_sound, EQUIP_SOUND_VOLUME, TRUE, ignore_walls = FALSE)
			else
				playsound(src, drop_sound, DROP_SOUND_VOLUME, ignore_walls = FALSE)

	if(item_action_slot_check(user, slot))
		add_verb(user, verbs)
		for(var/v in verbs)
			LAZYDISTINCTADD(user.item_verbs["[v]"], src)
	else
		remove_item_verbs(user)

	//Ěent for observable
	SEND_SIGNAL(src, COMSIG_ITEM_REMOVE, src)

	if(user && (z_flags & ZMM_MANGLE_PLANES))
		addtimer(CALLBACK(user, /mob/proc/check_emissive_equipment), 0, TIMER_UNIQUE)

	user.update_equipment_speed_mods()

/obj/item/proc/check_equipped(var/mob/user, var/slot, var/assisted_equip = FALSE)
	return TRUE

//sometimes we only want to grant the item's action if it's equipped in a specific slot.
/obj/item/proc/item_action_slot_check(mob/user, slot)
	return TRUE

///Defines which slots correspond to which slot flags
GLOBAL_LIST_INIT(slot_flags_enumeration, list(
	"[slot_wear_mask]" = SLOT_MASK,
	"[slot_back]" = SLOT_BACK,
	"[slot_wear_suit]" = SLOT_OCLOTHING,
	"[slot_gloves]" = SLOT_GLOVES,
	"[slot_shoes]" = SLOT_FEET,
	"[slot_belt]" = SLOT_BELT,
	"[slot_glasses]" = SLOT_EYES,
	"[slot_head]" = SLOT_HEAD,
	"[slot_l_ear]" = SLOT_EARS|SLOT_TWOEARS,
	"[slot_r_ear]" = SLOT_EARS|SLOT_TWOEARS,
	"[slot_w_uniform]" = SLOT_ICLOTHING,
	"[slot_wear_id]" = SLOT_ID,
	"[slot_tie]" = SLOT_TIE,
	"[slot_wrists]" = SLOT_WRISTS,
	"[slot_pants]" = SLOT_PANTS
	))

//the mob M is attempting to equip this item into the slot passed through as 'slot'. Return 1 if it can do this and 0 if it can't.
//If you are making custom procs but would like to retain partial or complete functionality of this one, include a 'return ..()' to where you want this to happen.
//Set disable_warning to 1 if you wish it to not give you outputs.
//Should probably move the bulk of this into mob code some time, as most of it is related to the definition of slots and not item-specific
/obj/item/proc/mob_can_equip(M as mob, slot, disable_warning = FALSE, bypass_blocked_check = FALSE)
	if(!slot) return 0
	if(!M) return 0

	if(!ishuman(M)) return 0

	var/mob/living/carbon/human/H = M
	var/list/mob_equip = list()
	if(H.species.hud && H.species.hud.equip_slots)
		mob_equip = H.species.hud.equip_slots

	if(H.species && !(slot in mob_equip))
		return 0

	//First check if the item can be equipped to the desired slot.
	if("[slot]" in GLOB.slot_flags_enumeration)
		var/req_flags = GLOB.slot_flags_enumeration["[slot]"]
		if(!(req_flags & slot_flags))
			return 0

	//Next check that the slot is free
	if(H.get_equipped_item(slot))
		return 0

	//Next check if the slot is accessible.
	var/mob/_user = disable_warning? null : H
	if(!bypass_blocked_check && !H.slot_is_accessible(slot, src, _user))
		return 0

	//Lastly, check special rules for the desired slot.
	switch(slot)
		if(slot_l_ear, slot_r_ear)
			var/slot_other_ear = (slot == slot_l_ear)? slot_r_ear : slot_l_ear
			if( (w_class > 1) && !(slot_flags & SLOT_EARS) )
				return 0
			if( (slot_flags & SLOT_TWOEARS) && H.get_equipped_item(slot_other_ear) )
				return 0
		if(slot_wear_id)
			return 1
		if(slot_l_hand)
			var/obj/item/organ/external/O
			O = H.organs_by_name[BP_L_HAND]
			if(!O || !O.is_usable() || O.is_malfunctioning())
				return FALSE
		if(slot_r_hand)
			var/obj/item/organ/external/O
			O = H.organs_by_name[BP_R_HAND]
			if(!O || !O.is_usable() || O.is_malfunctioning())
				return FALSE
		if(slot_l_store, slot_r_store)
			if(!H.w_uniform && (slot_w_uniform in mob_equip))
				if(!disable_warning)
					to_chat(H, SPAN_WARNING("You need a jumpsuit before you can attach this [name]."))
				return 0
			if( w_class > 2 && !(slot_flags & SLOT_POCKET) )
				return 0
		if(slot_s_store)
			var/can_hold_s_store = (slot_flags & SLOT_S_STORE)
			if(!can_hold_s_store && H.species.can_hold_s_store(src))
				can_hold_s_store = TRUE
			if(can_hold_s_store)
				return TRUE
			if(!H.wear_suit && (slot_wear_suit in mob_equip))
				if(!disable_warning)
					to_chat(H, SPAN_WARNING("You need a suit before you can attach this [name]."))
				return 0
			if(H.wear_suit && !length(H.wear_suit.allowed))
				if(!disable_warning)
					to_chat(usr, SPAN_WARNING("You somehow have a suit with no defined allowed items for suit storage, stop that."))
				return 0
			if(!istype(src, /obj/item/modular_computer) && !ispen() && !is_type_in_list(src, H.wear_suit.allowed))
				return 0
		if(slot_handcuffed)
			if(!istype(src, /obj/item/handcuffs))
				return 0
		if(slot_legcuffed)
			if(!istype(src, /obj/item/handcuffs))
				return 0
		if(slot_in_backpack) //used entirely for equipping spawned mobs or at round start
			var/allow = 0
			if(H.back && istype(H.back, /obj/item/storage/backpack))
				var/obj/item/storage/backpack/B = H.back
				if(B.can_be_inserted(src,1))
					allow = 1
			if(!allow)
				return 0
		if(slot_in_belt)
			var/allow = 0
			if(istype(H.belt, /obj/item/storage/belt))
				var/obj/item/storage/belt/B = H.belt
				if(B.can_be_inserted(src,1))
					allow = 1
			if(!allow)
				return 0
		if(slot_tie)
			if(!H.w_uniform && (slot_w_uniform in mob_equip))
				if(!disable_warning)
					to_chat(H, SPAN_WARNING("You need a jumpsuit before you can attach this [name]."))
				return 0
			var/obj/item/clothing/under/uniform = H.w_uniform
			if(LAZYLEN(uniform.accessories) && !uniform.can_attach_accessory(src))
				if (!disable_warning)
					to_chat(H, SPAN_WARNING("You already have an accessory of this type attached to your [uniform]."))
				return 0
	return 1

/obj/item/proc/mob_can_unequip(mob/M, slot, disable_warning = 0)
	if(!slot) return 0
	if(!M) return 0

	if(!canremove)
		return 0
	if(!M.slot_is_accessible(slot, src, disable_warning? null : M))
		return 0
	return 1

// override for give shenanigans
/obj/item/proc/on_give(var/mob/giver, var/mob/receiver)
	if(item_flags & ITEM_FLAG_HELD_MAP_TEXT)
		check_maptext()

//This proc is executed when someone clicks the on-screen UI button. To make the UI button show, set the 'icon_action_button' to the icon_state of the image of the button in screen1_action.dmi
//The default action is attack_self().
//Checks before we get to here are: mob is alive, mob is not restrained, paralyzed, asleep, resting, laying, item is on the mob.
/obj/item/proc/ui_action_click()
	attack_self(usr)

/**
 * Called when a mob is hit by a projectile, item or by an attack
 *
 * Return one of the `BULLET_ACT_*` defines
 *
 * BULLET_ACT_HIT will let the attack continue, BULLET_ACT_BLOCK will block the attack
 */
/obj/item/proc/handle_shield(mob/user, var/on_back, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	SHOULD_NOT_SLEEP(TRUE)

	return BULLET_ACT_HIT

/obj/item/proc/can_shield_back()
	return

/obj/item/proc/get_loc_turf()
	var/atom/L = loc
	while(L && !istype(L, /turf/))
		L = L.loc
	return loc

/obj/item/proc/eyestab(mob/living/carbon/M, mob/living/carbon/user)
	if(M.eyes_protected(src, TRUE))
		return

	var/mob/living/carbon/human/H = M
	admin_attack_log(user, M, "attacked [key_name(M)] with [src]", "was attacked by [key_name(user)] using \a [src]", "used \a [src] to eyestab")

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	playsound(loc, hitsound, 70, TRUE)
	user.do_attack_animation(M)

	add_fingerprint(user)
	if(istype(H))
		var/obj/item/organ/internal/eyes/eyes = H.get_eyes()

		if(H != user)
			M.visible_message(
				SPAN_DANGER("[user] stabs [M] in the [eyes.singular_name] with [src]!"),
				SPAN_DANGER("[user] stabs you in the [eyes.singular_name] with [src]!")
			)
		else
			user.visible_message( \
				SPAN_DANGER("[user] stabs themself in the [eyes.singular_name] with [src]!"), \
				SPAN_DANGER("You stab yourself in the [eyes.singular_name] with [src]!") \
			)

		eyes.take_damage(rand(3,4))
		if(eyes.damage >= eyes.min_bruised_damage)
			if(H.stat != DEAD)
				if(eyes.robotic <= 1) //robot eyes bleeding might be a bit silly
					to_chat(H, SPAN_DANGER("Your eyes start to bleed profusely!"))
			if(prob(50))
				if(H.stat != DEAD)
					to_chat(H, SPAN_WARNING("You drop what you're holding and clutch at your eyes!"))
					H.drop_item()
				H.eye_blurry += 10
				H.Paralyse(1)
				H.Weaken(4)
			if (eyes.damage >= eyes.min_broken_damage)
				if(H.stat != DEAD)
					to_chat(H, SPAN_WARNING("You go blind!"))
		var/obj/item/organ/external/affecting = H.get_organ(BP_HEAD)
		if(affecting.take_damage(7, 0, damage_flags(), src))
			H.UpdateDamageIcon()
	else
		M.take_organ_damage(7)
	M.eye_blurry += rand(3,4)

/obj/item/proc/protects_eyestab(var/obj/stab_item, var/stabbed = FALSE) // if stabbed is set to true if we're being stabbed and not just checking
	if((item_flags & ITEM_FLAG_THICK_MATERIAL) && (body_parts_covered & EYES))
		return TRUE
	return FALSE

/obj/item/clean_blood()
	. = ..()
	if(blood_overlay)
		CutOverlays(blood_overlay, ATOM_ICON_CACHE_ALL)
	if(istype(src, /obj/item/clothing/gloves))
		var/obj/item/clothing/gloves/G = src
		G.transfer_blood = 0

	if(blood_color)
		blood_color = null

	update_icon()

/obj/item/reveal_blood()
	if(was_bloodied && !fluorescent)
		fluorescent = 1
		blood_color = COLOR_LUMINOL
		blood_overlay.color = COLOR_LUMINOL
		update_icon()

/obj/item/add_blood(mob/living/carbon/human/M as mob)
	if (!..())
		return 0

	if(istype(src, /obj/item/melee/energy))
		return

	//if we haven't made our blood_overlay already
	if(!blood_overlay)
		generate_blood_overlay()

	//apply the blood-splatter overlay if it isn't already in there
	if(!blood_DNA.len)
		blood_overlay.color = blood_color
		AddOverlays(blood_overlay, TRUE)	// Priority overlay so we don't lose it somehow.

	//if this blood isn't already in the list, add it
	if(istype(M))
		if(blood_DNA[M.dna.unique_enzymes])
			return 0 //already bloodied with this blood. Cannot add more.
		blood_DNA[M.dna.unique_enzymes] = M.dna.b_type
	return 1 //we applied blood to the item

/obj/item/proc/generate_blood_overlay()
	if(blood_overlay)
		return

	blood_overlay = SSicon_cache.bloody_cache[type]
	if (blood_overlay)
		blood_overlay = image(blood_overlay)	// Copy instead of getting a ref, we're going to mutate this.
		return

	var/icon/I = new /icon(icon, icon_state)
	I.Blend(new /icon('icons/effects/blood.dmi', rgb(255,255,255)),ICON_ADD) //fills the icon_state with white (except where it's transparent)
	I.Blend(new /icon('icons/effects/blood.dmi', "itemblood"),ICON_MULTIPLY) //adds blood and the remaining white areas become transparent

	blood_overlay = image(I)
	SSicon_cache.bloody_cache[type] = blood_overlay

/obj/item/proc/showoff(mob/user)
	var/list/viewers = get_hearers_in_view(world.view, src)
	user.langchat_speech("holds up [src].", viewers, GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
	for (var/mob/M in viewers)
		if(!user.is_invisible_to(M))
			M.show_message("<b>[user]</b> holds up [icon2html(src, viewers)] [src]. <a href='byond://?src=[REF(M)];lookitem=[REF(src)]'>Take a closer look.</a>",1)

/mob/living/carbon/verb/showoff()
	set name = "Show Held Item"
	set category = "Object"

	var/obj/item/I = get_active_hand()
	if(I && !I.abstract)
		I.showoff(src)

/*
For zooming with scope or binoculars. This is called from
modules/mob/mob_movement.dm if you move you will be zoomed out
modules/mob/living/carbon/human/life.dm if you die, you will be zoomed out.
*/
//Looking through a scope or binoculars should /not/ improve your periphereal vision. Still, increase viewsize a tiny bit so that sniping isn't as restricted to NSEW
/obj/item/proc/zoom(var/mob/M, var/tileoffset = 14, var/viewsize = 9, var/do_device_check = TRUE, var/show_zoom_message = TRUE) //tileoffset is client view offset in the direction the user is facing. viewsize is how far out this thing zooms. 7 is normal view
	if (!M)
		return
	if(!isliving(M))
		return
	var/mob/living/L = M
	if(L.z_eye)
		to_chat(L, SPAN_WARNING("You can't do that from here!"))
		return

	var/devicename

	if(zoomdevicename)
		devicename = zoomdevicename
	else
		devicename = src.name

	var/cannotzoom

	if(M.stat || !(ishuman(M)))
		to_chat(M, SPAN_WARNING("You are unable to focus through \the [devicename]!"))
		cannotzoom = 1
	else if(!zoom && (GLOB.global_hud.darkMask[1] in M.client.screen))
		to_chat(M, SPAN_WARNING("Your visor gets in the way of looking through the [devicename]!"))
		cannotzoom = 1
	else if(do_device_check && !zoom && M.get_active_hand() != src)
		to_chat(M, SPAN_WARNING("You are too distracted to look through the [devicename], perhaps if it was in your active hand this might work better."))
		cannotzoom = 1

	if(!zoom && !cannotzoom)
		if(M.hud_used.hud_shown)
			M.toggle_zoom_hud()	// If the user has already limited their HUD this avoids them having a HUD when they zoom in
		M.client.view = viewsize
		zoom = 1

		var/tilesize = 32
		var/viewoffset = tilesize * tileoffset

		switch(M.dir)
			if (NORTH)
				M.client.pixel_x = 0
				M.client.pixel_y = viewoffset
			if (SOUTH)
				M.client.pixel_x = 0
				M.client.pixel_y = -viewoffset
			if (EAST)
				M.client.pixel_x = viewoffset
				M.client.pixel_y = 0
			if (WEST)
				M.client.pixel_x = -viewoffset
				M.client.pixel_y = 0

		if(show_zoom_message)
			M.visible_message("<b>[M]</b> peers through \the [zoomdevicename ? "[zoomdevicename] of \the [src.name]" : "[src.name]"].")

	else
		M.client.view = world.view
		if(!M.hud_used.hud_shown)
			M.toggle_zoom_hud()
		zoom = 0

		M.client.pixel_x = 0
		M.client.pixel_y = 0

		if(!cannotzoom)
			if(show_zoom_message)
				M.visible_message("[zoomdevicename ? "<b>[M]</b> looks up from \the [src.name]" : "<b>[M]</b> lowers \the [src.name]"].")

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.handle_vision()

//a proc that any worn thing can call to update its itemstate
//Should be cheaper than calling regenerate icons on the mob
/obj/item/proc/update_worn_icon()
	if (!equip_slot || !istype(loc, /mob))
		return

	var/mob/M = loc
	switch (equip_slot)
		if (slot_back)
			M.update_inv_back()
		if (slot_wear_mask)
			M.update_inv_wear_mask()
		if (slot_l_hand)
			M.update_inv_l_hand()
		if (slot_r_hand)
			M.update_inv_r_hand()
		if (slot_belt)
			M.update_inv_belt()
		if (slot_wear_id)
			M.update_inv_wear_id()
		if (slot_l_ear)
			M.update_inv_l_ear()
		if (slot_r_ear)
			M.update_inv_r_ear()
		if (slot_glasses)
			M.update_inv_glasses()
		if (slot_gloves)
			M.update_inv_gloves()
		if (slot_head)
			M.update_inv_head()
		if (slot_shoes)
			M.update_inv_shoes()
		if (slot_wear_suit)
			M.update_inv_wear_suit()
		if (slot_w_uniform)
			M.update_inv_w_uniform()
		if (slot_l_store)
			M.update_inv_pockets()
		if (slot_r_store)
			M.update_inv_pockets()
		if (slot_s_store)
			M.update_inv_s_store()
		if (slot_wrists)
			M.update_inv_wrists()

// Attacks mobs that are adjacent to the target and user.
/obj/item/proc/cleave(var/mob/living/user, var/mob/living/target)
	if(cleaving)
		return // We're busy.
	cleaving = TRUE
	var/hit_mobs = 0
	for(var/mob/living/SA in orange(get_turf(target), 1))
		if(SA.stat == DEAD) // Don't beat a dead horse.
			continue
		if(SA == user) // Don't hit ourselves.  Simple mobs shouldn't be able to do this but that might change later to be able to hit all mob/living-s.
			continue
		if(SA == target) // We (presumably) already hit the target before cleave() was called.  orange() should prevent this but just to be safe...
			continue
		if(!SA.Adjacent(user) || !SA.Adjacent(target)) // Cleaving only hits mobs near the target mob and user.
			continue
		if(resolve_attackby(SA, user)) // Hit them with the weapon.  This won't cause recursive cleaving due to the cleaving variable being set to true.
			hit_mobs++

	if(hit_mobs)
		to_chat(user, SPAN_DANGER("You used \the [src] to attack [hit_mobs] other target\s!"))
	cleaving = FALSE

// Used for non-adjacent melee attacks with specific weapons capable of reaching more than one tile.
// This uses changeling range string A* but for this purpose its also applicable.
/obj/item/proc/attack_can_reach(var/atom/us, var/atom/them, var/range)
	if(us.Adjacent(them))
		return TRUE // Already adjacent.
	else if(range <= 1)
		return FALSE
	if(AStar(get_turf(us), get_turf(them), /turf/proc/AdjacentTurfsRanged, /turf/proc/Distance, max_nodes=25, max_node_depth=range))
		return TRUE
	return FALSE

/**
 * Randomizes the pixel_x and pixel_y variables of the item if they are not already set, based on `randpixel`
 *
 * Returns `TRUE` if the item was randomized, `FALSE` otherwise
 *
 * This should _not_ be called from `New()`, only from `Initialize()` or other procs that are called after the maploader has already finished loading the item
 */
/obj/item/proc/randpixel_xy()
	SHOULD_NOT_SLEEP(TRUE)

	#if defined(TESTING)
	if(!(src.flags_1 & INITIALIZED_1))
		stack_trace("Item [src] was not initialized before calling randpixel_xy()!")
		return FALSE
	#endif

	// If the item is qdel'd, has already been randomized or has already a pixel_x or pixel_y set, don't do anything and return FALSE
	if(QDELETED(src) || pixel_x || pixel_y)
		return FALSE

	pixel_x = rand(-randpixel, randpixel)
	pixel_y = rand(-randpixel, randpixel)
	return TRUE

/obj/item/do_simple_ranged_interaction(var/mob/user)
	if(user)
		attack_self(user)
	return TRUE

//Override this for items that can be flame sources.
/obj/item/proc/isFlameSource()
	return FALSE

/obj/item/proc/glasses_examine_atom(var/atom/A, var/user)
	return

/obj/item/verb/verb_pickup()
	set name = "Pick Up"
	set category = "Object"
	set src in view(1)

	if(use_check_and_message(usr))
		return
	if(!iscarbon(usr) || istype(usr, /mob/living/carbon/brain))
		to_chat(usr, SPAN_WARNING("You can't pick things up!"))
		return
	if(anchored)
		to_chat(usr, SPAN_WARNING("You can't pick that up!"))
		return
	if(!usr.hand && usr.r_hand)
		to_chat(usr, SPAN_WARNING("Your right hand is full."))
		return
	if(usr.hand && usr.l_hand)
		to_chat(usr, SPAN_WARNING("Your left hand is full."))
		return
	if(!isturf(loc))
		to_chat(usr, SPAN_WARNING("You can't pick that up!"))
		return
	usr.UnarmedAttack(src)

/obj/item/proc/use_tool(atom/target, mob/living/user, delay, amount = 0, volume = 0, datum/callback/extra_checks)
	// No delay means there is no start message, and no reason to call tool_start_check before use_tool.
	// Run the start check here so we wouldn't have to call it manually.

	//if(user.is_busy()) to be ported in future if we ever need it
	//	return

	if(!delay && !tool_start_check(user, amount))
		return

	delay /= toolspeed

	// Play tool sound at the beginning of tool usage.
	play_tool_sound(target, volume)

	if(delay)
		// Create a callback with checks that would be called every tick by do_after.
		var/datum/callback/tool_check = CALLBACK(src, PROC_REF(tool_check_callback), user, amount, extra_checks)

		if(ismob(target))
			if(!do_mob(user, target, delay, extra_checks = tool_check))
				return

		else
			if(!do_after(user, delay, target, extra_checks = tool_check))
				return
	else
		// Invoke the extra checks once, just in case.
		if(extra_checks && !extra_checks.Invoke())
			return

	// Use tool's fuel, stack sheets or charges if amount is set.
	if(amount && !use(amount))
		return

	// Play tool sound at the end of tool usage,
	// but only if the delay between the beginning and the end is not too small
	if(delay >= MIN_TOOL_SOUND_DELAY)
		play_tool_sound(target, volume)

	return TRUE

// Called before use_tool if there is a delay, or by use_tool if there isn't.
// Only ever used by welding tools and stacks, so it's not added on any other use_tool checks.
/obj/item/proc/tool_start_check(mob/living/user, amount=0)
	return tool_use_check(user, amount)

// A check called by tool_start_check once, and by use_tool on every tick of delay.
/obj/item/proc/tool_use_check(mob/living/user, amount)
	return TRUE

/// Plays item's usesound, if any
/obj/item/proc/play_tool_sound(atom/target, volume=null) // null, so default value of this proc won't override default value of the playsound.
	if(target && volume)
		var/played_sound
		if(usesound)
			played_sound = usesound
			if(islist(usesound))
				played_sound = pick(usesound)
		else if(hitsound) // use hitsound if there isn't a use sound.
			played_sound = hitsound
			if(islist(usesound))
				played_sound = pick(hitsound)

		//playsound(target, played_sound, VOL_EFFECTS_MASTER, volume) implement sound channel system in future
		playsound(target, played_sound, volume, TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)

// Generic use proc. Depending on the item, it uses up fuel, charges, sheets, etc.
// Returns TRUE on success, FALSE on failure.
/obj/item/proc/use(used, mob/M = null)
	return !used

// Used in a callback that is passed by use_tool into do_after call. Do not override, do not call manually.
/obj/item/proc/tool_check_callback(mob/living/user, amount, datum/callback/extra_checks)
	return tool_use_check(user, amount) && (!extra_checks || extra_checks.Invoke())

/obj/item/proc/catch_fire()
	return

/obj/item/proc/extinguish_fire()
	return

/obj/item/proc/get_print_info(var/no_clear = TRUE)
	if(no_clear)
		. = ""
	. += "Damage: [force]<br>"
	. += "Damage Type: [damtype]<br>"
	. += "Sharp: [sharp ? "yes" : "no"]<br>"
	. += "Dismemberment: [edge ? "likely to dismember" : "unlikely to dismember"]<br>"
	. += "Penetration: [armor_penetration]<br>"
	. += "Throw Force: [throwforce]<br>"

/obj/item/proc/use_resource(var/mob/user, var/use_amount)
	return

// this gets called when the item gets chucked by the vending machine
/obj/item/proc/vendor_action(var/obj/machinery/vending/V)
	return

/obj/item/proc/set_initial_maptext()
	return

/obj/item/proc/check_maptext(var/new_maptext)
	if(new_maptext)
		held_maptext = new_maptext
	if(ismob(loc) || (loc && ismob(loc.loc)))
		maptext = held_maptext
	else
		maptext = ""

/obj/item/throw_at()
	..()
	in_inventory = FALSE
	if(item_flags & ITEM_FLAG_HELD_MAP_TEXT)
		check_maptext()

// used to check whether the item is capable of popping things like balloons, inflatable barriers, or cutting police tape.
/obj/item/proc/can_puncture()
	if(sharp || edge)
		return TRUE
	if(isFlameSource())
		return TRUE
	return FALSE

/obj/item/proc/get_pressure_weakness(pressure, zone)
	. = 1
	if(pressure > ONE_ATMOSPHERE)
		if(max_pressure_protection != null)
			if(max_pressure_protection < pressure)
				return min(1, round((pressure - max_pressure_protection) / max_pressure_protection, 0.01))
			else
				return 0
	if(pressure < ONE_ATMOSPHERE)
		if(min_pressure_protection != null)
			if(min_pressure_protection > pressure)
				return min(1, round((min_pressure_protection - pressure) / min_pressure_protection, 0.01))
			else
				return 0

/obj/item/proc/in_slide_projector(var/mob/user)
	if(istype(loc, /obj/item/storage/slide_projector))
		var/obj/item/storage/slide_projector/SP = loc
		if(SP.current_slide == src && (SP.projection in view(world.view, user)))
			return TRUE
	return FALSE

/obj/item/proc/get_belt_overlay() //Returns the icon used for overlaying the object on a belt
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', icon_state)

/obj/item/proc/get_ear_examine_text(var/mob/user, var/ear_text = "left")
	return "on [user.get_pronoun("his")] [ear_text] ear"

/obj/item/proc/get_mask_examine_text(var/mob/user)
	return "on [user.get_pronoun("his")] face"

/obj/item/proc/get_head_examine_text(var/mob/user)
	return "on [user.get_pronoun("his")] head"

/obj/item/proc/get_wrist_examine_text(var/mob/user)
	return "around [user.get_pronoun("his")] [gender==PLURAL?"wrists":"wrist"]"

/obj/item/proc/should_equip() // when you press E with an empty hand, will this item be pulled from suit storage / back slot and put into your hand
	return FALSE

/obj/item/proc/can_swap_hands(var/mob/user)
	return TRUE

/obj/item/proc/throw_fail_consequences(var/mob/living/carbon/C)
	return

/obj/item/proc/openTip(location, control, params, user)
	openToolTip(user, src, params, title = name, content = "[desc]", theme = "")

/obj/item/MouseEntered(location, control, params)
	. = ..()
	if(in_inventory || in_storage)
		var/mob/user = usr
		if(!(user.client.prefs.toggles_secondary & HIDE_ITEM_TOOLTIPS))
			tip_timer = addtimer(CALLBACK(src, PROC_REF(openTip), location, control, params, user), 8, TIMER_STOPPABLE)
		if(QDELETED(src))
			return
		if(!(user.client.prefs.toggles_secondary & SEE_ITEM_OUTLINES))
			return
		var/mob/living/L = user
		if(istype(L) && L.incapacitated())
			apply_outline(L, COLOR_RED_GRAY) //if they're dead or handcuffed, let's show the outline as red to indicate that they can't interact with that right now
		else
			apply_outline(L) //if the player's alive and well we send the command with no color set, so it uses the theme's color

/obj/item/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	. = ..()
	remove_outline()

/obj/item/MouseExited()
	deltimer(tip_timer) //delete any in-progress timer if the mouse is moved off the item before it finishes
	closeToolTip(usr)
	remove_outline()
	return ..()

/obj/item/proc/apply_outline(mob/user, outline_color = null)
	if(!(in_inventory || in_storage) || QDELETED(src) || isobserver(user)) //cancel if the item isn't in an inventory, is being deleted, or if the person hovering is a ghost (so that people spectating you don't randomly make your items glow)
		return
	var/theme = lowertext(user.client.prefs.UI_style)
	if(!outline_color) //if we weren't provided with a color, take the theme's color
		switch(theme) //yeah it kinda has to be this way
			if("midnight")
				outline_color = COLOR_THEME_MIDNIGHT
			if("plasmafire")
				outline_color = COLOR_THEME_PLASMAFIRE
			if("retro")
				outline_color = COLOR_THEME_RETRO
			if("slimecore")
				outline_color = COLOR_THEME_SLIMECORE
			if("operative")
				outline_color = COLOR_THEME_OPERATIVE
			if("clockwork")
				outline_color = COLOR_THEME_CLOCKWORK
			else //this should never happen, hopefully
				outline_color = COLOR_WHITE
	if(color)
		outline_color = COLOR_WHITE //if the item is recolored then the outline will be too, let's make the outline white so it becomes the same color instead of some ugly mix of the theme and the tint
	if(outline_filter)
		filters -= outline_filter
	outline_filter = filter(type = "outline", size = 1, color = outline_color)
	filters += outline_filter

/obj/item/proc/remove_outline()
	if(outline_filter)
		filters -= outline_filter
		outline_filter = null

/**
 * Determines if the item can be used to cut down wood (trees and the likes)
 *
 * Return `TRUE` if it can, `FALSE` otherwise
 */
/obj/item/proc/can_woodcut()
	SHOULD_BE_PURE(TRUE)
	SHOULD_NOT_SLEEP(TRUE)

	return FALSE

/obj/item/proc/is_shovel()
	return FALSE

/obj/item/proc/gives_weather_protection()
	return FALSE

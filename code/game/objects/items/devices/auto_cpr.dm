#define EPP "Emergency Positive Pressure system"

/obj/item/auto_cpr
	name = "stabilizer harness"
	desc = "A specialized medical harness that gives regular compressions to the patient's ribcage for cases of urgent heart issues, and functions as an emergency \
	artificial respirator for cases of urgent lung issues."
	icon = 'icons/obj/med_harness.dmi'
	icon_state = "med_harness"
	item_state = "med_harness"
	contained_sprite = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	origin_tech = list(TECH_MAGNET = 5, TECH_BIO = 3)
	slot_flags = SLOT_OCLOTHING
	var/panel_open = FALSE
	var/last_pump
	var/last_bm_check

	var/obj/item/cell/battery = null
	var/battery_level = 0
	var/charge_cost = 7 // 7 for 1 active function. Total of 14 if both CPR and EPP are doing their thing
	var/cpr_mode = TRUE // Auto-Compressor system. Can be toggled on/off

	var/mob/living/carbon/human/breather = null
	var/obj/item/clothing/mask/breath/breath_mask = null
	var/obj/item/tank/emergency_oxygen/tank = null
	var/tank_level = 0
	var/tank_type = null
	var/mask_on = FALSE
	var/epp_mode = FALSE // Emergency Positive Pressure system. Can be toggled on/off
	var/epp_active = FALSE

	var/list/mask_blacklist = list(
		/obj/item/clothing/mask/gas/vaurca,
		/obj/item/clothing/mask/breath/skrell,
		/obj/item/clothing/mask/breath/lyodsuit,
		/obj/item/clothing/mask/breath/infiltrator)

/obj/item/auto_cpr/mechanics_hints(mob/user, distance, is_adjacent)
	. += ..()
	. += "The Stabilizer Harness' CPR mode is capable of restarting the heart much like manual CPR with a chance for rib cracking ONLY IF the patient is flatlining. Uses battery power."
	. += "The EPP mode can keep the patient breathing during transport for as long as there's appropriate air in the installed tank. Uses battery power."
	. += "Use this item in your hand to toggle the CPR or EPP modes on/off."

/obj/item/auto_cpr/assembly_hints(mob/user, distance, is_adjacent)
	. += ..()
	if(panel_open)
		. += "The panel for adding/removing items is open and could be closed with some <b>screws</b>."

/obj/item/auto_cpr/disassembly_hints(mob/user, distance, is_adjacent)
	. += ..()
	if(!panel_open)
		. += "The panel for adding/removing items is <b>screwed</b> shut."
	else
		if(battery)
			. += "The battery could be <b>pried</b> out."
		if(tank_type)
			. += "The tank is secured with several <b>bolts</b>."
		if(breath_mask)
			. += "The breath mask could be removed <b>by hand</b>."

/obj/item/auto_cpr/feedback_hints(mob/user, distance, is_adjacent)
	if(distance > 2)
		return
	. += ..()
	. += "\The [src]'s [EPP] is currently <b>[epp_mode ? "on" : "off"]</b>, while the Auto CPR is <b>[cpr_mode ? "on" : "off"]</b>."
	if(battery)
		if(battery.percent() > 10)
			. += "It currently has a battery with <b>[battery.percent()]%</b> charge."
		else if(battery.percent() > 0)
			. += SPAN_ALERT("It currently has a battery with <b>[battery.percent()]%</b> charge.")
		else
			. += SPAN_DANGER("It currently has a battery with no charge left!")
	if(tank)
		. += "It has \the [tank] installed. The meter shows <b>[round(tank.air_contents.return_pressure())] kPa</b>, \
		with the pressure set to <b>[round(tank.distribute_pressure)] kPa</b>.[epp_active ? " The [EPP] is active." : ""]"
	if(breath_mask)
		. += "It has \the [breath_mask] installed."

/obj/item/auto_cpr/Initialize()
	. = ..()
	battery = new /obj/item/cell(src)
	breath_mask = new /obj/item/clothing/mask/breath/medical(src)
	tank = new /obj/item/tank/emergency_oxygen/engi(src)
	update_icon()

/obj/item/auto_cpr/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	QDEL_NULL(battery)
	if(breather)
		breath_mask_off()
	QDEL_NULL(breath_mask)
	QDEL_NULL(tank)
	return ..()

/obj/item/auto_cpr/build_additional_parts(H, mob_icon, slot)
	var/image/I = ..()
	if(!I)
		I = image(null)
	var/c_icon = 'icons/obj/med_harness.dmi'
	if(battery)
		var/c_state = "battery[battery_level][contained_sprite ? slot_str_to_contained_flag(slot) : ""]"
		var/image/battery_overlay = image(c_icon, c_state)
		battery_overlay.appearance_flags = RESET_ALPHA
		I.AddOverlays(battery_overlay)
	if(breath_mask)
		var/c_state = "mask_[mask_on ? "worn" : "idle"][contained_sprite ? slot_str_to_contained_flag(slot) : ""]"
		var/image/mask_overlay = image(c_icon, c_state)
		mask_overlay.appearance_flags = RESET_ALPHA
		I.AddOverlays(mask_overlay)
	if(tank)
		if(tank_level)
			var/c_state = "tank_indicator[tank_level][contained_sprite ? slot_str_to_contained_flag(slot) : ""]"
			var/image/tank_level_overlay = image(c_icon, c_state)
			tank_level_overlay.appearance_flags = RESET_ALPHA
			I.AddOverlays(tank_level_overlay)
		var/c_state = "tank_[tank_type][contained_sprite ? slot_str_to_contained_flag(slot) : ""]"
		var/image/tank_overlay = image(c_icon, c_state)
		tank_overlay.appearance_flags = RESET_ALPHA
		I.AddOverlays(tank_overlay)
	if(epp_active)
		var/c_state = "epp_active[cpr_mode ? "_cpr" : ""][contained_sprite ? slot_str_to_contained_flag(slot) : ""]"
		var/image/epp_overlay = image(c_icon, c_state)
		epp_overlay.appearance_flags = RESET_ALPHA
		I.AddOverlays(epp_overlay)
	return I

/obj/item/auto_cpr/update_icon()
	ClearOverlays()
	item_state = "[cpr_mode ? "med_harness_cpr" : "[initial(item_state)]"]"

	if(breath_mask)
		AddOverlays("mask_[mask_on ? "worn" : "idle"]")
	if(battery)
		switch(battery.percent())
			if(90 to INFINITY)	battery_level = 6
			if(80 to 90)		battery_level = 5
			if(60 to 79)		battery_level = 4
			if(40 to 59)		battery_level = 3
			if(20 to 39)		battery_level = 2
			if(05 to 19)		battery_level = 1
			if(-INFINITY to 4)	battery_level = 0
		AddOverlays("battery[battery_level]")
	if(tank)
		switch(tank.percent())
			if(90 to INFINITY)	tank_level = 6
			if(80 to 90)		tank_level = 5
			if(60 to 79)		tank_level = 4
			if(40 to 59)		tank_level = 3
			if(20 to 39)		tank_level = 2
			if(05 to 19)		tank_level = 1
			if(-INFINITY to 4)	tank_level = 0
		AddOverlays("tank_indicator[tank_level]")

		if(istype(tank, /obj/item/tank/emergency_oxygen/engi))
			tank_type = "engi"
		else if(istype(tank, /obj/item/tank/emergency_oxygen))
			tank_type = "oxy"
		else
			tank_type = "other"
		AddOverlays("tank_[tank_type]")
	if(epp_active)
		AddOverlays("epp_active")
	if(panel_open)
		AddOverlays("panel_open[battery ? "_battery" : ""]")

/obj/item/auto_cpr/mob_can_equip(mob/living/carbon/human/H, slot, disable_warning = 0, force = 0)
	. = ..()
	if(slot == slot_wear_suit)
		if(panel_open)
			return FALSE
		return
	if(force || !istype(H) || slot != slot_wear_suit)
		return
	if(H.species.get_bodytype() in list(BODYTYPE_HUMAN, BODYTYPE_TAJARA, BODYTYPE_SKRELL, BODYTYPE_UNATHI)) //gtfo stinky bugs
		return
	else
		return FALSE

/obj/item/auto_cpr/attack(mob/living/target_mob, mob/living/user, target_zone)
	var/mob/living/carbon/human/H = target_mob
	if(istype(H) && user.a_intent == I_HELP)
		if(panel_open)
			to_chat(user, SPAN_WARNING("You must screw \the [src]'s panel closed before fitting it onto anyone!"))
			return 1
		if(H.wear_suit)
			to_chat(user, SPAN_WARNING("Their [H.wear_suit] is in the way, remove it first!"))
			return 1
		user.visible_message(SPAN_NOTICE("[user] starts fitting \the [src] onto [H]'s chest."))

		if(!do_after(user, 2 SECONDS, H))
			to_chat(user, SPAN_DANGER("Failed fitting \the [src] onto [H]! Both you and [H] must remain still for you to do that!"))
			return

		if(user.unEquip(src))
			if(!H.equip_to_slot_if_possible(src, slot_wear_suit, delete_on_fail = FALSE, disable_warning = TRUE, redraw_mob = TRUE))
				user.put_in_active_hand(src)
			return 1
	else
		return ..()

/obj/item/auto_cpr/attackby(obj/item/attacking_item, mob/user)
	if(attacking_item.isscrewdriver())
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			if(H.get_inventory_slot(src) == slot_wear_suit)
				to_chat(user, SPAN_WARNING("You must unequip \the [src] before doing that!"))
				return TRUE
		panel_open = !panel_open
		user.visible_message(SPAN_NOTICE("[user] screws \the [src]'s panel [panel_open ? "open" : "closed"]."), SPAN_NOTICE("You screw \the [src]'s panel [panel_open ? "open" : "closed"]."))
		update_icon()
		return TRUE

	if(panel_open)
		if(attacking_item.iswrench())
			if(!tank)
				to_chat(user, "There isn't a tank to remove!")
				return TRUE
			user.visible_message(SPAN_NOTICE("[user] removes \the [tank] from \the [src]."), SPAN_NOTICE("You remove \the [tank] from \the [src]."))
			tank.forceMove(user.loc)
			user.put_in_hands(tank)
			tank = null
			update_icon()
			return TRUE
		if(attacking_item.iscrowbar())
			if(!battery)
				to_chat(user, "There isn't a battery to remove!")
				return TRUE
			user.visible_message(SPAN_NOTICE("[user] removes \the [battery] from \the [src]."), SPAN_NOTICE("You remove \the [battery] from \the [src]."))
			battery.forceMove(user.loc)
			user.put_in_hands(battery)
			battery = null
			update_icon()
			return TRUE
		if(istype(attacking_item, /obj/item/cell))
			if(battery)
				to_chat(user, "There is already \a [battery] installed.")
				return TRUE
			user.drop_from_inventory(attacking_item, src)
			battery = attacking_item
			user.visible_message(SPAN_NOTICE("[user] places \the [attacking_item] in \the [src]."), SPAN_NOTICE("You place \the [attacking_item] in \the [src]."))
			update_icon()
			return TRUE
		if(istype(attacking_item, /obj/item/clothing/mask/breath))
			if(is_type_in_list(attacking_item, mask_blacklist))
				to_chat(user, "\The [attacking_item] is incompatible with \the [src].")
				return TRUE
			if(breath_mask)
				to_chat(user, "There is already \a [breath_mask] installed.")
				return TRUE
			user.drop_from_inventory(attacking_item, src)
			breath_mask = attacking_item
			user.visible_message(SPAN_NOTICE("[user] places \the [attacking_item] in \the [src]."), SPAN_NOTICE("You place \the [attacking_item] in \the [src]."))
			update_icon()
			return TRUE
		if(istype(attacking_item, /obj/item/tank/emergency_oxygen))
			if(tank)
				to_chat(user, "There is already \a [tank] installed!")
				return TRUE
			user.drop_from_inventory(attacking_item, src)
			tank = attacking_item
			user.visible_message(SPAN_NOTICE("[user] places \the [attacking_item] in \the [src]."), SPAN_NOTICE("You place \the [attacking_item] in \the [src]."))
			update_icon()
			return TRUE

/obj/item/auto_cpr/attack_self(mob/user)
	if(panel_open)
		if(!breath_mask)
			to_chat(user, "There isn't an installed mask to remove!")
			return
		user.visible_message(SPAN_NOTICE("[user] removes \the [breath_mask] from \the [src]."), SPAN_NOTICE("You remove \the [breath_mask] from \the [src]."))
		breath_mask.forceMove(user.loc)
		user.put_in_hands(breath_mask)
		breath_mask = null
		update_icon()
		return
	var/list/options = list(
		"Toggle CPR" = image('icons/mob/screen/radial.dmi', "cpr_mode"),
		"Toggle EPP" = image('icons/mob/screen/radial.dmi', "iv_epp"))
	var/chosen_action = show_radial_menu(user, src, options, require_near = TRUE, radius = 42, tooltips = TRUE)
	if(!chosen_action)
		return
	switch(chosen_action)
		if("Toggle CPR")
			toggle_cpr()
		if("Toggle EPP")
			toggle_epp()

/obj/item/auto_cpr/attack_hand(mob/user)
	..()

/obj/item/auto_cpr/emp_act(severity)
	. = ..()

	epp_off()
	cpr_mode = FALSE
	if(battery)
		battery.emp_act(severity)
	update_icon()

/obj/item/auto_cpr/get_cell()
	return battery

/obj/item/auto_cpr/equipped(mob/user, slot)
	..()
	START_PROCESSING(SSprocessing,src)

/obj/item/auto_cpr/dropped(mob/user)
	STOP_PROCESSING(SSprocessing,src)
	..()

/obj/item/auto_cpr/process()
	if(!ishuman(loc))
		return PROCESS_KILL

	var/mob/living/carbon/human/H = loc
	if(H.get_inventory_slot(src) != slot_wear_suit)
		if(mask_on)
			breath_mask_off()
		update_icon()
		return PROCESS_KILL
	if(!battery)
		return PROCESS_KILL
	if(battery.charge <= 0)
		if(epp_mode)
			epp_off()
		if(cpr_mode)
			cpr_mode = FALSE
		visible_message(SPAN_WARNING("\The [src] sputters as it runs out of charge!"))
		playsound(src, 'sound/machines/synth_no.ogg', 50)
		update_icon()
		return PROCESS_KILL

	if(cpr_mode)
		cpr_process(H)
	if(epp_mode)
		epp_process(H)
	H.update_inv_wear_suit()
	update_icon()

/obj/item/auto_cpr/proc/cpr_process(mob/living/carbon/human/H)
	if(world.time > last_pump + 10 SECONDS)
		last_pump = world.time
		playsound(src, 'sound/machines/pump.ogg', 25)
		var/obj/item/organ/internal/heart/heart = H.internal_organs_by_name[BP_HEART]
		if(heart)
			heart.external_pump = list(world.time, 0.6)
		battery.use(charge_cost)

	if(H.is_asystole())
		if(H.stat != DEAD && prob(10))
			H.resuscitate()
		if(prob(5 * rand(2, 3)))
			var/obj/item/organ/external/chest = H.get_organ(BP_CHEST)
			if(chest)
				chest.fracture()

/obj/item/auto_cpr/proc/epp_process(mob/living/carbon/human/H)
	if(!tank || !breath_mask)
		src.visible_message(SPAN_WARNING("Error! Vital component for \the [src]'s [EPP] missing! Turning function off."))
		epp_off()
		return
	if(H.species.flags & NO_BREATHE)
		epp_off()
		return
	if(!mask_on)
		if(world.time > last_bm_check + 7 SECONDS) // Give it a few seconds before trying again
			last_bm_check = world.time
			breath_mask_on(H)
		return

	var/mask_check = breath_mask.get_equip_slot()
	if(mask_check != slot_wear_mask)
		breath_mask_off()
		return
	if(breath_mask.hanging)
		breath_mask_off()
		return
	if(breath_mask.loc != breather)
		breath_mask_off()
		return

	var/obj/item/organ/internal/lungs/lungs = H.internal_organs_by_name[BP_LUNGS]
	var/safe_pressure_min = H.species.breath_pressure + 2
	safe_pressure_min *= 1 + rand(1,4) * lungs.damage/lungs.max_damage
	if(!lungs)
		epp_off()
		return
	if(lungs.checking_rupture == FALSE)
		src.visible_message(SPAN_WARNING("Error! Patient safety check triggered! Turning the [EPP] off."))
		epp_off()
		return
	if(tank.air_contents.return_pressure() <= 10)
		src.visible_message(SPAN_WARNING("Error! Installed [tank] is low or near empty! Turning the [EPP] off."))
		epp_off()
		return

	if(H.losebreath > 0)
		if(!epp_active)
			src.visible_message(SPAN_WARNING("\The [src] beeps, activating it's [EPP]!"))
			tank.forceMove(H)
			H.internal = tank
			if(H.internals)
				H.internals.icon_state = "internal1"
			playsound(H, 'sound/machines/windowdoor.ogg', 50)
			epp_active = TRUE
		tank.distribute_pressure = safe_pressure_min
		H.losebreath = 0
		to_chat(H, SPAN_NOTICE("You feel fresh air being pushed into your lungs."))
		battery.use(charge_cost)

/obj/item/auto_cpr/proc/breath_mask_on(mob/living/carbon/human/H)
	if(!H.organs_by_name[BP_HEAD])
		src.visible_message(SPAN_WARNING("Error! Patient lacks a head!"))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50)
		return
	if(!H.check_has_mouth())
		src.visible_message(SPAN_WARNING("Error! Patient lacks a mouth!"))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50)
		return
	if(H.head && (H.head.body_parts_covered & FACE))
		src.visible_message(SPAN_WARNING("Error! Access to patient's head is obstructed!"))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50)
		return
	if(H.wear_mask)
		src.visible_message(SPAN_WARNING("Error! Access to patient's mouth is obstructed!"))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50)
		return
	src.visible_message(SPAN_INFO("\The [src] automatically fastens \the [breath_mask] onto \the [H]."))
	playsound(H, 'sound/effects/buckle.ogg', 50)
	breath_mask.forceMove(H.loc)
	H.equip_to_slot(breath_mask, slot_wear_mask)
	H.update_inv_wear_mask()
	breather = H
	mask_on = TRUE
	update_icon()

/obj/item/auto_cpr/proc/breath_mask_off()
	src.visible_message(SPAN_WARNING("\The [src] automatically retracts \the [breath_mask]!"))
	if(epp_active)
		tank.forceMove(src)
		if(breather.internals)
			breather.internals.icon_state = "internal0"
		breather.internal = null
		epp_active = FALSE
	if(breath_mask.hanging)
		breath_mask.hanging = FALSE
		breath_mask.adjust_sprites()
	if(breath_mask.loc != breather)
		var/loc_check = breath_mask.loc
		if(ismob(loc_check))
			var/mob/living/carbon/human/holder = loc_check
			holder.remove_from_mob(breath_mask)
			holder.update_inv_wear_mask()
			holder.update_inv_l_hand()
			holder.update_inv_r_hand()
		breath_mask.forceMove(src)
		breather = null
		mask_on = FALSE
		return
	breather.remove_from_mob(breath_mask)
	breather.update_inv_wear_mask()
	breath_mask.forceMove(src)
	breather = null
	mask_on = FALSE

/obj/item/auto_cpr/proc/epp_off()
	if(mask_on)
		breath_mask_off()
	playsound(src, 'sound/machines/buzz-two.ogg', 50)
	epp_mode = FALSE

/obj/item/auto_cpr/proc/toggle_check(mob/user)
	if(!ishuman(user) && !issilicon(user))
		to_chat(user, SPAN_WARNING("This mob cannot use this!"))
		return
	if(user.stat || user.incapacitated())
		to_chat(user, SPAN_WARNING("You are in no shape to do this."))
		return
	return TRUE

/obj/item/auto_cpr/verb/toggle_epp()
	set category = "Object"
	set name = "Toggle EPP"
	set src in usr

	if(!toggle_check(usr))
		return
	if(battery?.charge <= 0)
		to_chat(usr, SPAN_WARNING("\The [src] doesn't have enough power for you to do that!"))
		playsound(src, 'sound/machines/synth_no.ogg', 50)
		return
	if(epp_mode)
		epp_off()
		to_chat(usr, SPAN_NOTICE("You toggle \the [src]'s [EPP] off."))
		return
	epp_mode = TRUE
	to_chat(usr, SPAN_NOTICE("You toggle \the [src]'s [EPP] on."))
	playsound(usr, 'sound/machines/click.ogg', 50)
	update_icon()

/obj/item/auto_cpr/verb/toggle_cpr()
	set category = "Object"
	set name = "Toggle CPR"
	set src in usr

	if(!toggle_check(usr))
		return
	if(battery?.charge <= 0)
		to_chat(usr, SPAN_WARNING("\The [src] doesn't have enough power for you to do that!"))
		playsound(src, 'sound/machines/synth_no.ogg', 50)
		return
	cpr_mode = !cpr_mode
	to_chat(usr, SPAN_NOTICE("You toggle \the [src]'s Auto CPR system [cpr_mode ? "on" : "off"]."))
	playsound(usr, 'sound/machines/click.ogg', 50)
	update_icon()

#undef EPP

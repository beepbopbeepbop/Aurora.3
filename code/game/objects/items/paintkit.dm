/obj/item/device/kit
	icon = 'icons/obj/item/device/modkit.dmi'
	icon_state = "modkit"
	item_state = "restock_unit"
	var/new_name = "exosuit"    //What is the variant called?
	var/new_desc = "An exosuit." //How is the new exosuit described?
	var/new_icon = "ripley"  //What base icon will the new exosuit use?
	var/new_icon_file
	var/uses = 1        // Uses before the kit deletes itself.

/obj/item/device/kit/feedback_hints(mob/user, distance, is_adjacent)
	. += ..()
	. += "It has <b>[uses] use\s</b> left."

/obj/item/device/kit/use(var/amt, var/mob/user)
	uses -= amt
	playsound(get_turf(user), 'sound/items/Screwdriver.ogg', 50, 1)
	if(uses<1)
		user.drop_from_inventory(src,get_turf(src))
		qdel(src)

// Root voidsuit kit defines.
// Icons for modified voidsuits need to be in the proper .dmis because suit cyclers may cock them up.
/obj/item/device/kit/suit
	name = "voidsuit modification kit"
	desc = "A kit for modifying a voidsuit."
	uses = 2
	var/new_light_overlay
	var/new_mob_icon_file

/obj/item/clothing/head/helmet/space/void/attackby(obj/item/attacking_item, mob/user)
	if(istype(attacking_item,/obj/item/device/kit/suit))
		var/obj/item/device/kit/suit/kit = attacking_item
		name = "[kit.new_name] suit helmet"
		desc = kit.new_desc
		icon_state = "[kit.new_icon]_helmet"
		item_state = "[kit.new_icon]_helmet"
		if(kit.new_icon_file)
			icon = kit.new_icon_file
		if(kit.new_mob_icon_file)
			icon_override = kit.new_mob_icon_file
		if(kit.new_light_overlay)
			light_overlay = kit.new_light_overlay
		to_chat(user, "You set about modifying the helmet into [src].")
		var/mob/living/carbon/human/H = user
		if(istype(H))
			species_restricted = list(H.species.get_bodytype())
		kit.use(1,user)
		return TRUE
	return ..()

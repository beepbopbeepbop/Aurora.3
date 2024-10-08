

/obj/item/device/animaltagger
	name = "animal tagger"
	desc = "Used for tagging animals to be identified by a ear tag."
	icon_state = "animal_tagger0"
	force = 11
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 5.0
	throw_range = 15
	throw_speed = 3
	var/animaltag = null

	matter = list(DEFAULT_WALL_MATERIAL = 50, MATERIAL_GLASS = 20)

	origin_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 1)


/obj/item/device/animaltagger/Destroy()
	return ..()


/obj/item/device/animaltagger/attack(mob/living/target_mob, mob/living/user, target_zone)
	return

/obj/item/device/animaltagger/afterattack(atom/A as mob|obj, mob/user as mob)

	if(isanimal(A))
		A.name = animaltag
		to_chat(user,SPAN_NOTICE("You tag the animal as [animaltag]."))

	else
		to_chat(user, SPAN_NOTICE("You can't tag non animals."))
		return

/obj/item/device/animaltagger/attack_self(mob/user as mob)

	var/inputtag = sanitizeSafe(input(user,"Label text?","Set label",""), MAX_NAME_LEN)
	if(!inputtag || !length(inputtag))
		to_chat(user, SPAN_NOTICE("Invalid tag line."))
		return
	animaltag = inputtag

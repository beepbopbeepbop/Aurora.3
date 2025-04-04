/obj/item/storage/briefcase
	name = "briefcase"
	desc = "It's made of AUTHENTIC faux-leather and has a price-tag still attached. Its owner must be a real professional."
	icon = 'icons/obj/storage/briefcase.dmi'
	icon_state = "briefcase"
	item_state = "briefcase"
	contained_sprite = TRUE
	obj_flags = OBJ_FLAG_CONDUCTABLE
	force = 18
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = DEFAULT_LARGEBOX_STORAGE
	use_sound = 'sound/items/storage/briefcase.ogg'
	drop_sound = 'sound/items/drop/backpack.ogg'
	pickup_sound = 'sound/items/pickup/backpack.ogg'

/obj/item/storage/briefcase/real
	desc = "A leather briefcase, made of real leather. Looks fancy, owner must be real proud."

/obj/item/storage/briefcase/black
	name = "black briefcase"
	icon_state = "briefcase_black"
	item_state = "briefcase_black"
	desc = "Named for lawyers carrying briefs in a case. It's about time they had something named for them, isn't it?"

/obj/item/storage/briefcase/aluminium
	name = "metal briefcase"
	desc = "A heavy-duty briefcase for your most important documents."
	icon_state = "briefcase_alum"
	item_state = "briefcase_alum"

/obj/item/storage/briefcase/nt
	name = "\improper NT briefcase"
	desc = "The NanoTrasen-branded briefcase is an elegant, yet functional upgrade to the traditional black briefcase. The logo is the only difference, though."
	icon_state = "briefcase_corpnt"
	item_state = "briefcase_corpnt"

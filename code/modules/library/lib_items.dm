/* Library Items
 *
 * Contains:
 *		Bookcase
 *		Book
 *		Barcode Scanner
 */


/*
 * Bookcase
 */

/obj/structure/bookcase
	name = "bookcase"
	icon = 'icons/obj/library.dmi'
	icon_state = "book-0"
	anchored = 1
	density = 1
	build_amt = 5

/obj/structure/bookcase/Initialize()
	. = ..()
	for(var/obj/item/I in loc)
		if(istype(I, /obj/item/book))
			I.forceMove(src)
	update_icon()

/obj/structure/bookcase/attackby(obj/item/attacking_item, mob/user)
	if(istype(attacking_item, /obj/item/book))
		user.drop_from_inventory(attacking_item,src)
		update_icon()
	else if(attacking_item.ispen())
		var/newname = sanitizeSafe(input("What would you like to title this bookshelf?"), MAX_NAME_LEN)
		if(!newname)
			return
		else
			name = ("bookcase ([newname])")
	else if(attacking_item.iswrench())
		attacking_item.play_tool_sound(get_turf(src), 100)
		to_chat(user, (anchored ? SPAN_NOTICE("You unfasten \the [src] from the floor.") : SPAN_NOTICE("You secure \the [src] to the floor.")))
		anchored = !anchored
	else if(attacking_item.isscrewdriver())
		to_chat(user, SPAN_NOTICE("You begin dismantling \the [src]."))
		if(attacking_item.use_tool(src, user, 25, volume = 50))
			to_chat(user, SPAN_NOTICE("You dismantle \the [src]."))
			for(var/obj/item/book/b in contents)
				b.forceMove((get_turf(src)))
			dismantle()
	else
		..()

/obj/structure/bookcase/attack_hand(var/mob/user)
	if(contents.len)
		var/obj/item/book/choice = tgui_input_list(user, "Which book would you like to remove from the shelf?", "Bookcase", contents)
		if(choice)
			if(!usr.canmove || usr.stat || usr.restrained() || !in_range(loc, usr))
				return
			if(ishuman(user))
				if(!user.get_active_hand())
					user.put_in_hands(choice)
			else
				choice.forceMove(get_turf(src))
			update_icon()

/obj/structure/bookcase/ex_act(severity)
	switch(severity)
		if(1.0)
			for(var/obj/item/book/b in contents)
				qdel(b)
			qdel(src)
			return
		if(2.0)
			for(var/obj/item/book/b in contents)
				if (prob(50)) b.forceMove(get_turf(src))
				else qdel(b)
			qdel(src)
			return
		if(3.0)
			if (prob(50))
				for(var/obj/item/book/b in contents)
					b.forceMove(get_turf(src))
				qdel(src)
			return

	return

/obj/structure/bookcase/update_icon()
	if(contents.len < 5)
		icon_state = "book-[contents.len]"
	else
		icon_state = "book-5"


/obj/structure/bookcase/libraryspawn
	var/spawn_category
	var/spawn_amount = 3

/obj/structure/bookcase/libraryspawn/Initialize()
	. = ..()
	name = "[initial(name)] ([spawn_category])"

	addtimer(CALLBACK(src, PROC_REF(populate_shelves)), 1)

/obj/structure/bookcase/libraryspawn/proc/populate_shelves()
	if (!establish_db_connection(GLOB.dbcon))
		return

	var/query_str = "SELECT author, title, content FROM ss13_library ORDER BY RAND() LIMIT :amount:"
	var/list/query_data = list("amount" = spawn_amount)

	if (spawn_category)
		query_str = "SELECT author, title, content FROM ss13_library WHERE category = :cat: ORDER BY RAND() LIMIT :amount:"
		query_data["cat"] = spawn_category

	var/DBQuery/query_books = GLOB.dbcon.NewQuery(query_str)
	query_books.Execute(query_data)

	while (query_books.NextRow())
		CHECK_TICK
		var/author = query_books.item[1]
		var/title = query_books.item[2]
		var/content = query_books.item[3]
		var/obj/item/book/B = new(src)
		B.name = "Book: [title]"
		B.title = title
		B.author = author
		B.dat = content
		var/randbook = "book[rand(1,16)]"
		B.icon_state = randbook
		B.item_state = randbook

	update_icon()

/obj/structure/bookcase/libraryspawn/fiction
	name = "bookcase" //Because SDMM doesn't recognise the name otherwise, for some reason
	spawn_category = "Fiction"

/obj/structure/bookcase/libraryspawn/nonfiction
	name = "bookcase" //Because SDMM doesn't recognise the name otherwise, for some reason
	spawn_category = "Non-Fiction"

/obj/structure/bookcase/libraryspawn/reference
	name = "bookcase" //Because SDMM doesn't recognise the name otherwise, for some reason
	spawn_category = "Reference"

/obj/structure/bookcase/libraryspawn/religion
	name = "bookcase" //Because SDMM doesn't recognise the name otherwise, for some reason
	spawn_category = "Religion"

/obj/structure/bookcase/manuals/medical
	name = "Medical Manuals bookcase"

/obj/structure/bookcase/manuals/medical/New()
	..()
	new /obj/item/book/manual/medical_diagnostics_manual(src)
	new /obj/item/book/manual/medical_diagnostics_manual(src)
	new /obj/item/book/manual/medical_diagnostics_manual(src)
	new /obj/item/book/manual/medical_diagnostics_manual(src)
	update_icon()


/obj/structure/bookcase/manuals/engineering
	name = "Engineering Manuals bookcase"

/obj/structure/bookcase/manuals/engineering/New()
	..()
	new /obj/item/book/manual/wiki/engineering_construction(src)
	new /obj/item/book/manual/engineering_particle_accelerator(src)
	new /obj/item/book/manual/wiki/engineering_hacking(src)
	new /obj/item/book/manual/wiki/engineering_guide(src)
	new /obj/item/book/manual/atmospipes(src)
	new /obj/item/book/manual/engineering_singularity_safety(src)
	new /obj/item/book/manual/evaguide(src)
	update_icon()

/obj/structure/bookcase/manuals/research_and_development
	name = "R&D Manuals bookcase"

/obj/structure/bookcase/manuals/research_and_development/New()
	..()
	new /obj/item/book/manual/research_and_development(src)
	update_icon()


/*
 * Book
 */
/obj/item/book
	name = "book"
	icon = 'icons/obj/library.dmi'
	contained_sprite = TRUE
	icon_state = "book"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL		 //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb = list("bashed", "whacked", "educated")
	var/dat			 // Actual page content
	var/due_date = 0 // Game time in 1/10th seconds
	var/author		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
	var/unique = 0   // 0 - Normal book, 1 - Should not be treated as normal book, unable to be copied, unable to be modified
	var/title		 // The real name of the book.
	var/carved = 0	 // Has the book been hollowed out for use as a secret storage item?
	var/obj/item/store	//What's in the book?
	drop_sound = 'sound/items/drop/book.ogg'
	pickup_sound = 'sound/items/pickup/book.ogg'

/obj/item/book/antagonist_hints(mob/user, distance, is_adjacent)
	. += ..()
	. += "As a Cultist, this item can be reforged to become a cult tome."

/obj/item/book/attack_self(var/mob/user as mob)
	if(carved)
		if(store)
			to_chat(user, SPAN_NOTICE("[store] falls out of [title]!"))
			store.forceMove(get_turf(src.loc))
			store = null
			return
		else
			to_chat(user, SPAN_NOTICE("The pages of [title] have been cut out!"))
			return
	if(src.dat)
		user << browse(HTML_SKELETON("<TT><I>Penned by [author].</I></TT> <BR>" + "[dat]"), "window=book")
		user.visible_message("[user] opens a book titled \"[src.title]\" and begins reading intently.")
		playsound(loc, 'sound/bureaucracy/bookopen.ogg', 50, TRUE)
		onclose(user, "book")
	else
		to_chat(user, "This book is completely blank!")

/obj/item/book/attackby(obj/item/attacking_item, mob/user)
	if(carved)
		if(!store)
			if(attacking_item.w_class < 3)
				user.drop_from_inventory(attacking_item,src)
				store = attacking_item
				to_chat(user, SPAN_NOTICE("You put [attacking_item] in [title]."))
				return
			else
				to_chat(user, SPAN_NOTICE("[attacking_item] won't fit in [title]."))
				return
		else
			to_chat(user, SPAN_NOTICE("There's already something in [title]!"))
			return
	if(attacking_item.ispen())
		if(unique)
			to_chat(user, "These pages don't seem to take the ink well. Looks like you can't modify it.")
			return
		var/choice = tgui_input_list(user, "What would you like to change?", "Book", list("Title", "Contents", "Author", "Cancel"), "Cancel")
		switch(choice)
			if("Title")
				var/newtitle = reject_bad_text(strip_html_full(tgui_input_text(user, "Write a new title:", "Title", encode = FALSE)))
				if(!newtitle)
					to_chat(usr, "The title is invalid.")
					return
				else
					src.name = html_decode(newtitle)
					src.title = newtitle
			if("Contents")
				var/content = strip_html_readd_newlines(tgui_input_text(user, "Write your book's contents (HTML NOT allowed):", "Content", multiline = TRUE, encode = FALSE), MAX_BOOK_MESSAGE_LEN)
				if(!content)
					to_chat(usr, "The content is invalid.")
					return
				else
					src.dat += content
			if("Author")
				var/newauthor = strip_html_full(tgui_input_text(user, "Write the author's name:", "Author", encode = FALSE))
				if(!newauthor)
					to_chat(usr, "The name is invalid.")
					return
				else
					src.author = newauthor
			else
				return
	else if(istype(attacking_item, /obj/item/barcodescanner))
		var/obj/item/barcodescanner/scanner = attacking_item
		if(!scanner.computer)
			to_chat(user, "[attacking_item]'s screen flashes: 'No associated computer found!'")
		else
			switch(scanner.mode)
				if(0)
					scanner.book = src
					to_chat(user, "[attacking_item]'s screen flashes: 'Book stored in buffer.'")
				if(1)
					scanner.book = src
					scanner.computer.buffer_book = src.name
					to_chat(user, "[attacking_item]'s screen flashes: 'Book stored in buffer. Book title stored in associated computer buffer.'")
				if(2)
					scanner.book = src
					for(var/datum/borrowbook/b in scanner.computer.checkouts)
						if(b.bookname == src.name)
							scanner.computer.checkouts.Remove(b)
							to_chat(user, "[attacking_item]'s screen flashes: 'Book stored in buffer. Book has been checked in.'")
							return
					to_chat(user, "[attacking_item]'s screen flashes: 'Book stored in buffer. No active check-out record found for current title.'")
				if(3)
					scanner.book = src
					for(var/obj/item/book in scanner.computer.inventory)
						if(book == src)
							to_chat(user, "[attacking_item]'s screen flashes: 'Book stored in buffer. Title already present in inventory, aborting to avoid duplicate entry.'")
							return
					scanner.computer.inventory.Add(src)
					to_chat(user, "[attacking_item]'s screen flashes: 'Book stored in buffer. Title added to general inventory.'")
	else if(istype(attacking_item, /obj/item/material/knife) || attacking_item.iswirecutter())
		if(carved)	return
		to_chat(user, SPAN_NOTICE("You begin to carve out [title]."))
		if(attacking_item.use_tool(src, user, 30, volume = 50))
			to_chat(user, SPAN_NOTICE("You carve out the pages from [title]! You didn't want to read it anyway."))
			playsound(loc, 'sound/bureaucracy/papercrumple.ogg', 50, 1)
			new /obj/item/shreddedp(get_turf(src))
			carved = 1
			return
	else
		..()

/obj/item/book/attack(mob/living/target_mob, mob/living/user, target_zone)
	if(target_zone == BP_EYES)
		user.visible_message(SPAN_NOTICE("You open up the book and show it to [target_mob]. "), \
			SPAN_NOTICE(" [user] opens up a book and shows it to [target_mob]. "))
		target_mob << browse(HTML_SKELETON("<TT><I>Penned by [author].</I></TT> <BR>" + "[dat]"), "window=book")
		user.setClickCooldown(DEFAULT_QUICK_COOLDOWN) //to prevent spam


/*
 * Barcode Scanner
 */
/obj/item/barcodescanner
	name = "book scanner"
	icon = 'icons/obj/library.dmi'
	icon_state ="scanner"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/obj/machinery/librarycomp/computer // Associated computer - Modes 1 to 3 use this
	var/obj/item/book/book //  Currently scanned book
	var/mode = 0 // 0 - Scan only, 1 - Scan and Set Buffer, 2 - Scan and Attempt to Check In, 3 - Scan and Attempt to Add to Inventory

/obj/item/barcodescanner/attack_self(mob/user as mob)
	mode += 1
	if(mode > 3)
		mode = 0
	to_chat(user, "[src] Status Display:")
	var/modedesc
	switch(mode)
		if(0)
			modedesc = "Scan book to local buffer."
		if(1)
			modedesc = "Scan book to local buffer and set associated computer buffer to match."
		if(2)
			modedesc = "Scan book to local buffer, attempt to check in scanned book."
		if(3)
			modedesc = "Scan book to local buffer, attempt to add book to general inventory."
		else
			modedesc = "ERROR"
	to_chat(user, " - Mode [mode] : [modedesc]")
	if(src.computer)
		to_chat(user, SPAN_NOTICE("Computer has been associated with this unit."))
	else
		to_chat(user, SPAN_WARNING("No associated computer found. Only local scans will function properly."))
	to_chat(user, "\n")

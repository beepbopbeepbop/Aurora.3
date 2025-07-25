//This file defines variables and functions specific to diona worker gestalts, not used by nymphs


//Initialisation Section
//===========================
#define COLD_DAMAGE_LEVEL_1 0.5 //Copied from life.dm
#define COLD_DAMAGE_LEVEL_2 1.5
#define COLD_DAMAGE_LEVEL_3 3

/mob/living/carbon/human
	var/datum/dionastats/DS


/mob/living/carbon/human/proc/setup_gestalt()
	composition_reagent = /singleton/reagent/nutriment //Dionae aren't animals, so eating them doesn't give animal protein
	setup_dionastats()
	add_verb(src, /mob/living/carbon/human/proc/check_light)
	add_verb(src, /mob/living/carbon/human/proc/diona_split_nymph)
	add_verb(src, /mob/living/carbon/human/proc/diona_detach_nymph)
	add_verb(src, /mob/living/carbon/human/proc/pause_regen_process)

	spawn(10)
	//This is delayed after a gestalt is spawned, to allow nymphs to be added to it before extras are created
	//These initial nymphs are the nymph which grows into a gestalt, and any others it had inside it
	//There are no initial nymphs for a newly spawned diona player

		if (mind?.name && mind.name != real_name)
			add_verb(src, /mob/living/carbon/human/proc/gestalt_set_name)
			var/datum/language/L = locate(/datum/language/diona) in languages
			var/newname
			if (L)
				newname = L.get_random_name()
			else
				newname = "Diona Gestalt ([rand(100,999)])"
			real_name = newname
			name = newname
			to_chat(src, "<span class=notice>We are named [real_name] for now, but we can choose a new name for our gestalt. (Check the Abilities Tab)</span>")
			//This allows a gestalt to rename itself -once- upon reforming

		verbs.Add(/mob/living/carbon/proc/absorb_nymph)

		topup_nymphs()

/mob/living/carbon/human/proc/topup_nymphs()
	var/added = 0
	var/list/exclude = list(BP_GROIN, BP_L_HAND, BP_R_HAND, BP_L_FOOT, BP_R_FOOT) // becase these are supposed to be whole as their join parts
	for(var/thing in organs_by_name)
		if(thing in exclude)
			continue

		if(!add_nymph())
			return added
		added += 1

	return added

/mob/living/carbon/human/proc/add_nymph()
	var/count = 0
	for(var/mob/living/carbon/alien/nymph in contents)
		count += 1
	if(count >= 6)
		return FALSE
	var/mob/living/carbon/alien/diona/M = new /mob/living/carbon/alien/diona(src)
	M.gestalt = src
	M.set_stat(CONSCIOUS)
	M.update_verbs()
	M.sync_languages(src)
	return TRUE

//Environmental Functions
//================================

/**
This function is called when a gestalt is cold enough to take damage from icy temperatures.
It will also deal damage to contained nymphs, making them much less likely to survive and split if the diona dies of cold.
Damage is slightly randomised for each nymph, some will live longer than others, but in the long run all will die eventually.
Nymphs are slightly insulated from the cold within a gestalt. The temperature to hurt a nymph is 40k lower than what hurts the gestalt.
*/
/mob/living/carbon/human/proc/diona_contained_cold_damage()
	if (bodytemperature < (species.cold_level_1-40))
		var/damage
		if(bodytemperature > (species.cold_level_2-40))
			damage = COLD_DAMAGE_LEVEL_1
		else if(bodytemperature > (species.cold_level_3-40))
			damage = COLD_DAMAGE_LEVEL_2
		else
			damage = COLD_DAMAGE_LEVEL_3

		for (var/mob/living/carbon/alien/diona/D in src)
			D.adjustFireLoss(damage*(rand(30,150)/100))
			D.updatehealth()


/**
This is called when a gestalt is hit by an explosion. Nymphs will take damage too!
Damage to nymphs depends on the severity of the blast, and on explosive-resistant armor worn by the gestalt.
A severity 1 explosion without armor will usually kill all nymphs in the gestalt.
Damage is randomised for each nymph, often some will survive and others wont.
Nymphs have 100 health, so without armor there is a small possibility for each nymph to survive a severity 1 blast.
*/
/mob/living/carbon/human/proc/diona_contained_explosion_damage(var/severity)
	var/damage = 0
	var/damage_factor = 0.1 //Safety value
	if (severity)
		damage_factor = (1 / severity)

	var/armorval = get_blocked_ratio(BP_CHEST, DAMAGE_BRUTE, DAMAGE_FLAG_DISPERSED, damage = damage)
	if (armorval)
		damage_factor *= (1 - (armorval * 0.01))


	if (damage_factor > 0)
		for(var/mob/living/carbon/alien/diona/D in src)
			damage = (rand(95,200)*damage_factor)
			D.adjustBruteLoss(damage)
			D.updatehealth()

/mob/living/carbon/human/proc/check_light()
	set category = "Abilities"
	set name = "Check Light Level"

	var/light = get_lightlevel_diona(DS)
	if (light <= -0.75)
		to_chat(usr, SPAN_DANGER("It is pitch black here! This is extremely dangerous, we must find light, or death will soon follow!"))
	else if (light <= 0)
		to_chat(usr, SPAN_DANGER("This area is too dim to sustain us for long, we should move closer to the light, or we will shortly be in danger!"))
	else if (light > 0 && light < 1.5)
		to_chat(usr, SPAN_WARNING("The light here can sustain us, barely. It feels cold and distant."))
	else if (light <= 3)
		to_chat(usr, SPAN_NOTICE("This light is comfortable and warm, Quite adequate for our needs."))
	else
		to_chat(usr, SPAN_NOTICE("This warm radiance is bliss. Here we are safe and energised! Stay a while.."))



//1.5 is the maximum energy that can be lost per proc
//2.1 is the approximate delay between procs
/mob/living/carbon/human/proc/setup_dionastats()
	// Diona time variables. These differ slightly between a gestalt and a nymph. All values are times in seconds.

	/// How long this diona can exist in total darkness before its energy runs out.
	var/energy_duration = 120
	/// How long this diona can stay on its feet and keep moving in darkness after energy is gone.
	var/dark_consciousness = 120
	/// How long this diona can survive in darkness after energy is gone, before it dies.
	var/dark_survival = 180

	/// Maximum (energy) lost per second, in total darkness.
	var/MLS = (1.5 / 2.1)
	DS = new/datum/dionastats()
	DS.max_energy = energy_duration * MLS
	DS.max_health = maxHealth*2
	DS.stored_energy = DS.max_energy
	DS.pain_factor = (100 / dark_consciousness) / MLS
	DS.trauma_factor = (DS.max_health / dark_survival) / MLS
	DS.dionatype = 2//Gestalt

//Splitting functions
//====================

/// A verb accessible to Diona players, calls the split proc.
/mob/living/carbon/human/proc/diona_split_nymph()
	set name = "Split"
	set desc = "Split your humanoid form into its constituent nymphs."
	set category = "Abilities"

	var/response = alert(src, "Are you sure you want to split? This will break your gestalt into many smaller nymphs, but you will only control one.","Confirm Split","Split","Not now")
	if(response != "Split") return

	diona_split_into_nymphs()

/// Allows a newly reformed gestalt to set their name, but only once. This isn't available to gestalts that haven't reformed.
/mob/living/carbon/human/proc/gestalt_set_name()
	set name = "Set Gestalt Name"
	set desc = "Choose a name for your new collective."
	set category = "Abilities"

	var/newname
	var/suggestion = ""
	var/textbox = ""
	var/datum/language/L = locate(/datum/language/diona) in languages
	if (L)
		suggestion = L.get_random_name()


	textbox	= "What shall we name our new collective? Type in a name, or leave blank to cancel. We recall that we were once part of a collective named [mind.name] but it is not necessary to return to that"

	newname = input(src, textbox, "Choosing a name.", suggestion)
	if (newname)
		real_name = newname
		name = newname
		mind.name = newname
		to_chat(src, "<span class=notice>Our collective shall now be known as [real_name] !</span>")
		verbs.Remove(/mob/living/carbon/human/proc/gestalt_set_name)

/// Halts regeneration, so you don't grow a new limb when you don't wish to.
/mob/living/carbon/human/proc/pause_regen_process()
	set name = "Halt Metabolism"
	set desc = "Allows you to pause any regeneration process."
	set category = "Abilities"

	if(DS)
		DS.pause_regen = !DS.pause_regen
		to_chat(usr, SPAN_NOTICE("You have [!DS.pause_regen ? "started" : "paused"] regeneration process."))

/// Allows the player to detach a single nymph from their head or hands and control it seperately.
/mob/living/carbon/human/proc/diona_detach_nymph()
	set name = "Detach Nymph"
	set desc = "Allows you to detach specific nymph, and control it."
	set category = "Abilities"

	if(use_check_and_message(src))
		return

	if(nutrition <= 150)
		to_chat(src, SPAN_WARNING("You lack nutrition to perform this action!"))
		return
	if(DS.stored_energy <= 60)
		to_chat(src, SPAN_WARNING("You lack energy to perform this action!"))
		return
	// Choose our limb to detach
	var/list/exclude = organs_by_name - list(BP_GROIN, BP_CHEST, BP_L_ARM, BP_R_ARM, BP_L_LEG, BP_R_LEG)
	var/list/organ_list = list()
	for(var/organ in exclude)
		organ_list += parse_zone(organ)
	var/choice =  tgui_input_list(src, "Choose a limb to detach.", "Limb Detach", organ_list)
	if(!choice)
		return
	var/obj/item/organ/external/O = organs_by_name[reverse_parse_zone(choice)]
	if(!O || O.is_stump())
		to_chat(src, SPAN_WARNING("You cannot detach that!"))
		return

	// Get rid of our limb and replace it with a stump.
	var/obj/item/organ/external/stump/stump = new(src, 0, O)
	O.removed(null, TRUE)
	O.post_droplimb(src)
	stump.replaced(src)

	// If we have parent organ, drop it too.
	if(O.parent_organ && O.parent_organ != BP_CHEST)
		var/obj/item/organ/external/parent = organs_by_name[O.parent_organ]
		parent.removed(src, TRUE)
		var/obj/item/organ/external/stump/parent_stump = new (src, 0, parent)
		parent_stump.replaced(src)
		parent_stump.post_droplimb(src)
		qdel(parent)
	to_chat(src, SPAN_NOTICE("You detach \the [O.name] nymph from your body."))
	qdel(O)

	var/mob/living/carbon/alien/diona/M = locate(/mob/living/carbon/alien/diona) in contents
	if(!M)
		return

	M.forceMove(get_turf(src))

	// Switch control to nymph
	M.key = src.key
	teleop = TRUE
	M.teleop = TRUE
	src.key = "@[M.key]"
	src.ajourn = 0
	DS.nym = WEAKREF(M)
	M.gestalt = src
	add_verb(M, /mob/living/carbon/alien/diona/proc/merge_back_to_gestalt)
	add_verb(M, /mob/living/carbon/alien/diona/proc/switch_to_gestalt)
	M.detached = TRUE
	M.update_verbs(TRUE)
	M.languages = languages.Copy()
	M.accent = accent
	M.client.init_verbs()

	nutrition -= REGROW_FOOD_REQ
	DS.stored_energy -= REGROW_ENERGY_REQ
	diona_handle_regeneration(DS)
	playsound(src, 'sound/species/diona/gestalt_grow.ogg', 30, 1)

/// Allows the player to switch between their gestalt and a nymph they've split off.
/mob/living/carbon/human/proc/switch_to_nymph()
	set name = "Switch to Nymph"
	set desc = "Allows you to switch control back to your detached Nymph."
	set category = "Abilities"

	var/mob/living/carbon/alien/diona/nymph = DS.nym.resolve()

	if(!nymph)
		to_chat(src, SPAN_WARNING("You have no nymph!"))
		return
	else if(nymph.stat == DEAD)
		to_chat(src, SPAN_DANGER("Your nymph is not responding! Something could have happened to it!"))
		return
	else
		nymph.key = key
		remove_verb(nymph, /mob/living/carbon/human/proc/switch_to_nymph)
		add_verb(nymph, /mob/living/carbon/alien/diona/proc/switch_to_gestalt)
		nymph.client.init_verbs()

/mob/living/carbon/human/proc/diona_split_into_nymphs()
	var/turf/T = get_turf(src)
	var/mob/living/carbon/alien/diona/bestNymph = null
	var/gestalt_health = (300 -  getFireLoss() - getBruteLoss() - getToxLoss()) / 6

	var/nymphs_to_kill_off = 0

	//We iterate through all the nymphs and find which one is healthiest and not controlled
	//The gestalt's player will control that nymph

	//Start the splitting sound
	playsound(src.loc, 'sound/species/diona/gestalt_split.ogg', 100, 1)
	sleep(20)
	var/list/nymphos = list()

	var/list/organ_removal_priorities = list(BP_L_ARM,BP_R_ARM,BP_L_LEG,BP_R_LEG)
	for(var/organ_name in organ_removal_priorities)
		var/obj/item/organ/external/O = organs_by_name[organ_name]
		if(!O || O.is_stump())
			nymphs_to_kill_off += 1

	var/total_nymph = 0
	for(var/mob/living/carbon/alien/diona/D in src)
		if(nymphs_to_kill_off > 0)
			D.set_stat(DEAD)
			nymphs_to_kill_off -= 1
			qdel(D)
			continue
		if ((!D.mind) && bestNymph == null)
			//As a safety, we choose the first unkeyed one to begin with, even if its dead.
			//We'll replace this choice when/if we find a better one
			bestNymph = D
		nymphos += D
		D.forceMove(T)
		if(gestalt_health >= D.maxHealth * 0.20)
			D.health = gestalt_health
		else
			D.health = D.maxHealth * 0.20
		D.split_languages(src)
		D.set_dir(pick(NORTH, SOUTH, EAST, WEST))
		D.gestalt = null
		total_nymph += 1
		D.set_stat(CONSCIOUS)
		D.stunned = 0
		D.update_verbs()

	for(var/obj/item/W in src)
		drop_from_inventory(W)

	if (bestNymph)
		var/split_reag_volume = src.reagents.total_volume /  total_nymph // All nymps needs to get reagents of Gestal split between.
		for(var/mob/living/carbon/alien/diona/D in nymphos)
			src.reagents.trans_to_mob(D, split_reag_volume, CHEM_BLOOD)
			if(!D.mind)
				D.master_nymph = bestNymph
				D.birds_of_feather += nymphos
				D.pixel_y += rand(-10,10)
				D.pixel_x += rand(-10,10)
		bestNymph.set_dir(dir)
		transfer_languages(src, bestNymph)
		if(mind)
			mind.transfer_to(bestNymph)
			bestNymph.stunned = 0//Switching mind seems to temporarily stun mobs
			message_admins("\The [src] has split into nymphs; player now controls [key_name_admin(bestNymph)]")
			log_admin("\The [src] has split into nymphs; player now controls [key_name(bestNymph)]")

	//If bestNymph is still null at this point, it could only mean every nymph in the gestalt was a player
	//In this unfathomably rare case, the gestalt player simply dies as its mob is qdel'd.
	//We will generally prevent this from happening by ensuring any nymph-joining functions leave one free for the host

	visible_message(SPAN_WARNING("\The [src] quivers slightly, then splits apart with a wet slithering noise."))
	qdel(src)

// Miscellaneous abilities
//================================

/**
This verb lets the Diona anchor themselves to the ground, giving them magboot properties.
Slows you down while being used, and will be automatically retracted if both feet are severed.
*/
/mob/living/carbon/human/proc/root_to_ground()
	set name = "Extend Roots"
	set desc = "Extend your roots to keep yourself upright in case of pressure changes."
	set category = "Abilities"

	if(use_check_and_message(src))
		return
	if(last_special > world.time)
		to_chat(src, SPAN_WARNING("You've used an ability too recently! Wait a bit."))
		return
	if(!has_organ(BP_R_FOOT) && !has_organ(BP_L_FOOT))
		to_chat(src, SPAN_WARNING("You have no supporting limbs to extend your roots from!"))
		return

	last_special = world.time + 2 SECONDS

	// Checks whether we want to disable or enable the ability with this call.
	if(HAS_TRAIT_FROM(src, TRAIT_SHOE_GRIP, TRAIT_SOURCE_SPECIES_VERB))
		root_disable()
	else
		root_enable()

/// Movespeed modifier used in the root_to_ground proc. This determines how much the ability slows you down by.
/datum/movespeed_modifier/root_to_ground
	multiplicative_slowdown = 1.5

/// Engages Diona magboot roots.
/mob/living/carbon/human/proc/root_enable()
	RegisterSignal(src, COMSIG_LIMB_LOSS, PROC_REF(check_roots))

	visible_message(SPAN_NOTICE("[src] extends an array of roots out from their feet, clutching at any available surface!")
	, SPAN_NOTICE("You extend strong roots from your feet, serving as natural braces to keep your footing secure."))
	ADD_TRAIT(src, TRAIT_SHOE_GRIP, TRAIT_SOURCE_SPECIES_VERB)
	add_movespeed_modifier(/datum/movespeed_modifier/root_to_ground)
	playsound(src, 'sound/species/diona/gestalt_grow.ogg', 30, extrarange = SILENCED_SOUND_EXTRARANGE)

/// Disables Diona magboot roots.
/mob/living/carbon/human/proc/root_disable()
	UnregisterSignal(src, COMSIG_LIMB_LOSS)

	visible_message(SPAN_NOTICE("[src] retracts the roots growing from their body.")
	, SPAN_NOTICE("You retract your roots back into your body."))
	REMOVE_TRAIT(src, TRAIT_SHOE_GRIP, TRAIT_SOURCE_SPECIES_VERB)
	remove_movespeed_modifier(/datum/movespeed_modifier/root_to_ground)
	playsound(src, 'sound/species/diona/gestalt_split.ogg', 20, extrarange = SILENCED_SOUND_EXTRARANGE)

/**
Checks if the roots should still be enabled or not, proccing whenever any limb is lost. The roots will retract if you have neither foot.
*/
/mob/living/carbon/human/proc/check_roots()
	SIGNAL_HANDLER

	if(!has_organ(BP_R_FOOT) && !has_organ(BP_L_FOOT))
		root_disable()

#undef COLD_DAMAGE_LEVEL_1
#undef COLD_DAMAGE_LEVEL_2
#undef COLD_DAMAGE_LEVEL_3

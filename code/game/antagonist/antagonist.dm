/datum/antagonist

	// Text shown when becoming this antagonist.
	var/list/restricted_jobs =     list()   // Jobs that cannot be this antagonist (depending on config)
	var/list/protected_jobs =      list()   // As above.
	var/list/restricted_species =   list()  // species that cannot be this antag - Ryan784
	var/required_age = null                 // how old should player clients be before being allowed to play this antag

	// Strings.
	var/welcome_text = "Cry havoc and let slip the dogs of war!"
	var/antag_sound = 'sound/effects/antag_notice/general_baddie_alert.ogg' // The sound file to play when someone gets this role. Only they can hear it.
	var/leader_welcome_text                 // Text shown to the leader, if any.
	var/victory_text                        // World output at roundend for victory.
	var/loss_text                           // As above for loss.
	var/victory_feedback_tag                // Used by the database for end of round loss.
	var/loss_feedback_tag                   // Used by the database for end of round loss.

	// Role data.
	var/id = "traitor"                      // Unique datum identifier.
	var/role_type                           // Preferences option for this role. Defaults to the id if unset
	var/role_text = "Traitor"               // special_role text.
	var/role_text_plural = "Traitors"       // As above but plural.

	// Visual references.
	var/antaghud_indicator = "hudsyndicate" // Used by the ghost antagHUD.
	var/antag_indicator                     // icon_state for icons/mob/mob.dm visual indicator.
	var/faction_indicator                   // See antag_indicator, but for factionalized people only.
	var/faction_invisible                   // Can members of the faction identify other antagonists?

	// Faction data.
	var/faction_role_text                   // Role for sub-antags. Mandatory for faction role.
	var/faction_descriptor                  // Description of the cause. Mandatory for faction role.
	var/list/faction_verbs                  // Verbs added when becoming a member of the faction, if any.
	var/faction_welcome                     // Message shown to faction members.
	var/faction = "neutral"			// Faction name, mostly used for simple animals.

	// Spawn values (autotraitor and game mode)
	var/hard_cap = 3                        // Autotraitor var. Won't spawn more than this many antags.
	var/hard_cap_round = 5                  // As above but 'core' round antags ie. roundstart.
	var/initial_spawn_req = 1               // Gamemode using this template won't start without this # candidates.
	var/initial_spawn_target = 3            // Gamemode will attempt to spawn this many antags.
	var/announced                           // Has an announcement been sent?
	var/spawn_announcement                  // When the datum spawn proc is called, does it announce to the world? (ie. xenos)
	var/spawn_announcement_title            // Report title.
	var/spawn_announcement_sound            // Report sound clip.
	var/spawn_announcement_delay            // Time between initial spawn and round announcement.

	// Misc.
	var/landmark_id                         // Spawn point identifier.
	var/mob_path = /mob/living/carbon/human // Mobtype this antag will use if none is provided.
	var/feedback_tag = "traitor_objective"  // End of round
	var/bantype = "Syndicate"               // Ban to check when spawning this antag.
	var/suspicion_chance = 50               // Prob of being on the initial Command report
	var/flags = 0                           // Various runtime options.
	var/db_log_id = null                    // ID of the db entry used to track that antagonist
	var/allow_no_mob = FALSE                // This antagonist allows ghosts as antag, or other mobs that don't fill out the current var.

	// Used for setting appearance.
	var/list/valid_species =       list(SPECIES_UNATHI,SPECIES_TAJARA,SPECIES_SKRELL,SPECIES_SKRELL_AXIORI,SPECIES_HUMAN)

	// Runtime vars.
	var/datum/mind/leader                   // Current leader, if any.
	var/cur_max = 0                         // Autotraitor current effective maximum.
	var/spawned_nuke                        // Has a bomb been spawned?
	var/nuke_spawn_loc                      // If so, where should it be placed?
	var/list/current_antagonists = list()   // All marked antagonists for this type.
	var/list/pending_antagonists = list()   // Candidates that are awaiting finalized antag status.
	var/list/starting_locations =  list()   // Spawn points.
	var/list/global_objectives =   list()   // Universal objectives if any.
	var/list/candidates =          list()   // Potential candidates.
	var/list/faction_members =     list()   // Semi-antags (in-round revs, borer thralls)

	// ID card stuff.
	var/default_access = list()
	var/id_type = /obj/item/card/id
	var/id_card // a reference to the id_card we spawned with

	var/has_idris_account = TRUE
	var/idris_account_min = 100
	var/idris_account_max = 500


/datum/antagonist/New()
	..()
	if(!role_type)
		role_type = id

	cur_max = hard_cap

	if(!role_text_plural)
		role_text_plural = role_text
	if(GLOB.config.protect_roles_from_antagonist)
		restricted_jobs |= protected_jobs
	if(antaghud_indicator)
		if(!GLOB.hud_icon_reference)
			GLOB.hud_icon_reference = list()
		if(role_text)
			GLOB.hud_icon_reference[role_text] = antaghud_indicator
		if(faction_role_text)
			GLOB.hud_icon_reference[faction_role_text] = antaghud_indicator

// Get the raw list of potential players.
/datum/antagonist/proc/build_candidate_list(var/ghosts_only, var/allow_animals = 0)
	candidates = list() // Clear.

	// Prune restricted status. Broke it up for readability.
	// Note that this is done before jobs are handed out.
	for(var/datum/mind/player in SSticker.mode.get_players_for_role(role_type, id))
		if(ghosts_only && !istype(player.current, /mob/abstract))
			log_traitor("[key_name(player)] is not eligible to become a [role_text]: Only ghosts may join as this role!")
		else if(!allow_animals && isanimal(player.current))
			log_traitor("[key_name(player)] is not eligible to become a [role_text]: Simple animals cannot be this role!")
		else if(player.special_role)
			log_traitor("[key_name(player)] is not eligible to become a [role_text]: They already have a special role ([player.special_role])!")
		else if(player in pending_antagonists)
			log_traitor("[key_name(player)] is not eligible to become a [role_text]: They have already been selected for this role!")
		else if(!can_become_antag(player))
			log_traitor("[key_name(player)] is not eligible to become a [role_text]: They are blacklisted for this role!")
		else if(player_is_antag(player))
			log_traitor("[key_name(player)] is not eligible to become a [role_text]: They are already an antagonist!")
		else if(establish_db_connection(GLOB.dbcon) && required_age && required_age > player.current.client?.player_age)
			log_traitor("[key_name(player)] is not eligible to become a [role_text]: Their playtime age is too low!")
		else
			candidates += player

	return candidates

/datum/antagonist/proc/attempt_random_spawn()
	update_current_antag_max()
	build_candidate_list(flags & (ANTAG_OVERRIDE_MOB|ANTAG_OVERRIDE_JOB))
	attempt_spawn()
	finalize_spawn()

/datum/antagonist/proc/attempt_auto_spawn()
	if(!can_late_spawn())
		return 0

	update_current_antag_max()
	var/active_antags = get_active_antag_count()
	log_traitor("[uppertext(id)]: Found [active_antags]/[cur_max] active [role_text_plural].")

	if(active_antags >= cur_max)
		log_traitor("Could not auto-spawn a [role_text], active antag limit reached.")
		return 0

	build_candidate_list(flags & (ANTAG_OVERRIDE_MOB|ANTAG_OVERRIDE_JOB))
	if(!candidates.len)
		log_traitor("Could not auto-spawn a [role_text], no candidates found.")
		return 0

	attempt_spawn(1) //auto-spawn antags one at a time
	if(!pending_antagonists.len)
		log_traitor("Could not auto-spawn a [role_text], none of the available candidates could be selected.")
		return 0

	var/datum/mind/player = pending_antagonists[1]
	if(!add_antagonist(player,0,0,0,1,1))
		log_traitor("Could not auto-spawn a [role_text], failed to add antagonist.")
		return 0

	pending_antagonists -= player

	reset_antag_selection()

	return 1

//Selects players that will be spawned in the antagonist role from the potential candidates
//Selected players are added to the pending_antagonists lists.
//Attempting to spawn an antag role with ANTAG_OVERRIDE_JOB should be done before jobs are assigned,
//so that they do not occupy regular job slots. All other antag roles should be spawned after jobs are
//assigned, so that job restrictions can be respected.
/datum/antagonist/proc/attempt_spawn(var/spawn_target = null)
	if(spawn_target == null)
		spawn_target = initial_spawn_target

	// Update our boundaries.
	if(!candidates.len)
		return 0

	//Grab candidates until we have enough.
	while(candidates.len && pending_antagonists.len < spawn_target)
		var/datum/mind/player = candidates[1]
		candidates -= player
		draft_antagonist(player)

	return 1

/datum/antagonist/proc/draft_antagonist(var/datum/mind/player)
	SHOULD_NOT_SLEEP(TRUE)

	//Check if the player can join in this antag role, or if the player has already been given an antag role.
	if(!can_become_antag(player))
		log_traitor("[player.key] was selected for [role_text] by lottery, but is not allowed to be that role.")
		return 0
	if(player.special_role)
		log_traitor("[player.key] was selected for [role_text] by lottery, but they already have a special role.")
		return 0
	if(!(flags & ANTAG_OVERRIDE_JOB) && (!player.current || istype(player.current, /mob/abstract/new_player)))
		log_traitor("[player.key] was selected for [role_text] by lottery, but they have not joined the game.")
		return 0

	pending_antagonists |= player
	log_traitor("[player.key] has been selected for [role_text] by lottery.")

	//Ensure that antags with ANTAG_OVERRIDE_JOB do not occupy job slots.
	if(flags & ANTAG_OVERRIDE_JOB)
		player.assigned_role = role_text
		player.role_alt_title = role_text

	//Ensure that a player cannot be drafted for multiple antag roles, taking up slots for antag roles that they will not fill.
	player.special_role = role_text

	return 1

//Spawns all pending_antagonists. This is done separately from attempt_spawn in case the game mode setup fails.
/datum/antagonist/proc/finalize_spawn()
	if(!pending_antagonists)
		return

	for(var/datum/mind/player in pending_antagonists)
		if (add_antagonist(player,0,0,1))
			pending_antagonists -= player

	reset_antag_selection()

//Resets the antag selection, clearing all pending_antagonists and their special_role
//(and assigned_role if ANTAG_OVERRIDE_JOB is set) as well as clearing the candidate list.
//Existing antagonists are left untouched.
/datum/antagonist/proc/reset_antag_selection()
	for(var/datum/mind/player in pending_antagonists)
		if(flags & ANTAG_OVERRIDE_JOB)
			player.assigned_role = null
		player.special_role = null

		if (!check_rights(R_ADMIN|R_MOD|R_CCIAA, 0, player.current))
			remove_verb(player.current.client, /client/proc/aooc)
	pending_antagonists.Cut()
	candidates.Cut()


var/global/BSACooldown = 0
var/global/enabled_spooking = 0

////////////////////////////////
/proc/message_admins(var/msg)
	msg = "<span class=\"log_message\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message\">[msg]</span></span>"
	for(var/s in GLOB.staff)
		var/client/C = s
		if((R_ADMIN|R_MOD) & C.holder.rights)
			to_chat(C, msg)

/proc/message_cciaa(var/msg)
	msg = "<span class=\"log_message\"><span class=\"prefix\">CCIA LOG:</span> <span class=\"message\">[msg]</span></span>"
	for(var/s in GLOB.staff)
		var/client/C = s
		if(R_CCIAA & C.holder.rights)
			to_chat(C, msg)

/proc/msg_admin_attack(var/text,var/ckey="",var/ckey_target="") //Toggleable Attack Messages
	log_attack(text)
	var/rendered = "<span class=\"log_message\"><span class=\"prefix\">ATTACK:</span> <span class=\"message\">[text]</span></span>"
	for(var/s in GLOB.staff)
		var/client/C = s
		if((R_ADMIN|R_MOD) & C.holder.rights)
			if(C.prefs.toggles & CHAT_ATTACKLOGS)
				var/msg = rendered
				to_chat(C, msg)

/proc/admin_notice(var/message, var/rights)
	for(var/mob/M in GLOB.mob_list)
		if(check_rights(rights, 0, M))
			to_chat(M, message)

///////////////////////////////////////////////////////////////////////////////////////////////Panels

/datum/admins/proc/show_player_panel(var/mob/M in GLOB.mob_list)
	set category = "Admin"
	set name = "Show Player Panel"
	set desc="Edit player (respawn, ban, heal, etc)"

	if(!M)
		to_chat(usr, "You seem to be selecting a mob that doesn't exist anymore.")
		return
	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		to_chat(usr, "Error: you are not an admin!")
		return

	var/ui_scale = owner.prefs?.ui_scale

	var/body = "<html><head><title>Options for [M.key]</title></head>"
	body += "<body>Options panel for <b>[M]</b>"
	if(M.client)
		body += " played by <b>[M.client]</b> "
		body += "\[<A href='byond://?src=[REF(src)];editrights=show'>[M.client.holder ? M.client.holder.rank : "Player"]</A>\]"

	if(istype(M, /mob/abstract/new_player))
		body += " <B>Hasn't Entered Game</B> "
	else
		body += " \[<A href='byond://?src=[REF(src)];revive=[REF(M)]'>Heal</A>\] "

	body += {"
		<br><br>\[
		<a href='byond://?_src_=vars;Vars=[REF(M)]'>VV</a> -
		<a href='byond://?src=[REF(src)];traitor=[REF(M)]'>TP</a> -
		<a href='byond://?src=[REF(usr)];priv_msg=[REF(M)]'>PM</a> -
		<a href='byond://?src=[REF(src)];subtlemessage=[REF(M)]'>SM</a> -
		[admin_jump_link(M, src)]\] <br>
		<b>Mob type</b> = [M.type]<br><br>
		<A href='byond://?src=[REF(src)];boot2=[REF(M)]'>Kick</A> |
		<A href='byond://?_src_=holder;warn=[M.ckey]'>Warn</A> |
		<a href='byond://?src=[REF(src)];warnsearchckey=[M.ckey]'>Warnings</a> |
		<A href='byond://?src=[REF(src)];newban=[REF(M)]'>Ban</A> |
		<A href='byond://?src=[REF(src)];jobban_panel=[REF(M)]'>Jobban</A> |
		<A href='byond://?src=[REF(src)];notes=show;mob=[REF(M)]'>Notes</A>
	"}

	if(M.client)
		body += "| <a href='byond://?src=[REF(src)];admin_wind_player=[REF(M)]'>Wind</a> | "
		body += "\ <A href='byond://?src=[REF(src)];sendbacktolobby=[REF(M)]]'>Send back to Lobby</A>"
		var/muted = M.client.prefs.muted
		body += {"<br><b>Mute: </b>
			\[<A href='byond://?src=[REF(src)];mute=[REF(M)];mute_type=[MUTE_IC]'><font color='[(muted & MUTE_IC)?"red":"blue"]'>IC</font></a> |
			<A href='byond://?src=[REF(src)];mute=[REF(M)];mute_type=[MUTE_OOC]'><font color='[(muted & MUTE_OOC)?"red":"blue"]'>OOC</font></a> |
			<A href='byond://?src=[REF(src)];mute=[REF(M)];mute_type=[MUTE_PRAY]'><font color='[(muted & MUTE_PRAY)?"red":"blue"]'>PRAY</font></a> |
			<A href='byond://?src=[REF(src)];mute=[REF(M)];mute_type=[MUTE_ADMINHELP]'><font color='[(muted & MUTE_ADMINHELP)?"red":"blue"]'>ADMINHELP</font></a> |
			<A href='byond://?src=[REF(src)];mute=[REF(M)];mute_type=[MUTE_DEADCHAT]'><font color='[(muted & MUTE_DEADCHAT)?"red":"blue"]'>DEADCHAT</font></a> |
			<A href='byond://?src=[REF(src)];mute=[REF(M)];mute_type=[MUTE_AOOC]'><font color='[(muted & MUTE_AOOC) ? "red" : "blue"]'>AOOC</font></a>\]
			(<A href='byond://?src=[REF(src)];mute=[REF(M)];mute_type=[MUTE_ALL]'><font color='[(muted & MUTE_ALL)?"red":"blue"]'>toggle all</font></a>)
		"}

	body += {"<br><br>
		<A href='byond://?src=[REF(src)];jumpto=[REF(M)]'><b>Jump to</b></A> |
		<A href='byond://?src=[REF(src)];getmob=[REF(M)]'>Get</A> |
		<A href='byond://?src=[REF(src)];sendmob=[REF(M)]'>Send To</A>
		<br><br>
		[check_rights(R_ADMIN|R_MOD,0) ? "<A href='byond://?src=[REF(src)];traitor=[REF(M)]'>Traitor panel</A> | " : "" ]
		<A href='byond://?src=[REF(src)];narrateto=[REF(M)]'>Narrate to</A> |
		<A href='byond://?src=[REF(src)];subtlemessage=[REF(M)]'>Subtle message</A>
	"}

	body += "<br><br>"
	body += "<b>Psionics:</b><br/>"
	if(isliving(M))
		var/mob/living/psyker = M
		if(psyker.psi)
			body += "<a href='byond://?src=[REF(src)];remove_psionics=[REF(psyker.psi)]'>Remove psionics.</a><br/><br/>"
		body += "<table width = '100%'>"
		for(var/psi_rank in list(PSI_RANK_SENSITIVE, PSI_RANK_HARMONIOUS, PSI_RANK_APEX, PSI_RANK_LIMITLESS))
			var/owner_rank = psyker.psi ? psyker.psi.get_rank() : 0
			var/psi_title = GLOB.psychic_ranks_to_strings[psi_rank]
			if(psi_rank == owner_rank)
				psi_title = "<b>[psi_title]</b>"
			if(psi_rank != PSI_RANK_LIMITLESS)
				body += "<tr><a href='byond://?src=[REF(psyker.mind)];set_psi_rank=[psi_rank]'>[psi_title]</a></tr>"
			else
				body += "<tr><a href='byond://?src=[REF(psyker.mind)];set_psi_rank_limitless=1'><font color='red'>[psi_title]</font></a></tr>"
		body += "</table>"

	if (M.client)
		if(!istype(M, /mob/abstract/new_player))
			body += "<br><br>"
			body += "<b>Transformation:</b>"
			body += "<br>"

			//Monkey
			if(issmall(M))
				body += "<B>Monkeyized</B> | "
			else
				body += "<A href='byond://?src=[REF(src)];monkeyone=[REF(M)]'>Monkeyize</A> | "

			//Corgi
			if(iscorgi(M))
				body += "<B>Corgized</B> | "
			else
				body += "<A href='byond://?src=[REF(src)];corgione=[REF(M)]'>Corgize</A> | "

			//AI / Cyborg
			if(isAI(M))
				body += "<B>Is an AI</B> "
			else if(ishuman(M))
				body += {"<A href='byond://?src=[REF(src)];makeai=[REF(M)]'>Make AI</A> |
					<A href='byond://?src=[REF(src)];makerobot=[REF(M)]'>Make Robot</A> |
					<A href='byond://?src=[REF(src)];makeslime=[REF(M)]'>Make slime</A>
				"}

			//Simple Animals
			if(isanimal(M))
				body += "<A href='byond://?src=[REF(src)];makeanimal=[REF(M)]'>Re-Animalize</A> | "
			else
				body += "<A href='byond://?src=[REF(src)];makeanimal=[REF(M)]'>Animalize</A> | "

			// DNA2 - Admin Hax
			if(M.dna && iscarbon(M))
				body += "<br><br>"
				body += "<b>DNA Blocks:</b><br><table border='0'><tr><th>&nbsp;</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th>"
				var/bname
				for(var/block=1;block<=DNA_SE_LENGTH;block++)
					if(((block-1)%5)==0)
						body += "</tr><tr><th>[block-1]</th>"
					bname = assigned_blocks[block]
					body += "<td>"
					if(bname)
						var/bstate=M.dna.GetSEState(block)
						var/bcolor="[(bstate)?"#006600":"#ff0000"]"
						body += "<A href='byond://?src=[REF(src)];togmutate=[REF(M)];block=[block]' style='color:[bcolor];'>[bname]</A><sub>[block]</sub>"
					else
						body += "[block]"
					body+="</td>"
				body += "</tr></table>"

			body += {"<br><br>
				<b>Rudimentary transformation:</b><font size=2><br>These transformations only create a new mob type and copy stuff over. They do not take into account MMIs and similar mob-specific things. The buttons in 'Transformations' are preferred, when possible.</font><br>
				<A href='byond://?src=[REF(src)];simplemake=observer;mob=[REF(M)]'>Observer</A> |
				\[ Crew: <A href='byond://?src=[REF(src)];simplemake=human;mob=[REF(M)]'>Choose Species</A>\] | \[
				<A href='byond://?src=[REF(src)];simplemake=nymph;mob=[REF(M)]'>Nymph</A>\] |
				\[ slime: <A href='byond://?src=[REF(src)];simplemake=slime;mob=[REF(M)]'>Baby</A>\]|
				<A href='byond://?src=[REF(src)];simplemake=ai;mob=[REF(M)]'>AI</A> |
				<A href='byond://?src=[REF(src)];simplemake=robot;mob=[REF(M)]'>Cyborg</A> |
				<A href='byond://?src=[REF(src)];simplemake=cat;mob=[REF(M)]'>Cat</A> |
				<A href='byond://?src=[REF(src)];simplemake=runtime;mob=[REF(M)]'>Runtime</A> |
				<A href='byond://?src=[REF(src)];simplemake=corgi;mob=[REF(M)]'>Corgi</A> |
				<A href='byond://?src=[REF(src)];simplemake=ian;mob=[REF(M)]'>Ian</A> |
				<A href='byond://?src=[REF(src)];simplemake=crab;mob=[REF(M)]'>Crab</A> |
				<A href='byond://?src=[REF(src)];simplemake=coffee;mob=[REF(M)]'>Coffee</A> |
				\[ Construct: <A href='byond://?src=[REF(src)];simplemake=constructarmored;mob=[REF(M)]'>Armored</A> ,
				<A href='byond://?src=[REF(src)];simplemake=constructbuilder;mob=[REF(M)]'>Builder</A> ,
				<A href='byond://?src=[REF(src)];simplemake=constructwraith;mob=[REF(M)]'>Wraith</A> \]
				<A href='byond://?src=[REF(src)];simplemake=shade;mob=[REF(M)]'>Shade</A>
				<A href='byond://?src=[REF(src)];simplemake=meme;mob=[REF(M)]'>Meme</A>
				<br>
			"}
	body += {"<br><br>
			<b>Other actions:</b>
			<br>
			<A href='byond://?src=[REF(src)];forcespeech=[REF(M)]'>Forcesay</A>
			"}
	if (M.client)
		body += {" |
			<A href='byond://?src=[REF(src)];tdome1=[REF(M)]'>Thunderdome 1</A> |
			<A href='byond://?src=[REF(src)];tdome2=[REF(M)]'>Thunderdome 2</A> |
			<A href='byond://?src=[REF(src)];tdomeadmin=[REF(M)]'>Thunderdome Admin</A> |
			<A href='byond://?src=[REF(src)];tdomeobserve=[REF(M)]'>Thunderdome Observer</A> |
		"}
	// language toggles
	body += "<br><br><b>Languages:</b><br>"
	var/f = 1
	for(var/k in GLOB.all_languages)
		var/datum/language/L = GLOB.all_languages[k]
		if(!(L.flags & INNATE))
			if(!f) body += " | "
			else f = 0
			if(L in M.languages)
				body += "<a href='byond://?src=[REF(src)];toglang=[REF(M)];lang=[html_encode(k)]' style='color:#006600'>[k]</a>"
			else
				body += "<a href='byond://?src=[REF(src)];toglang=[REF(M)];lang=[html_encode(k)]' style='color:#ff0000'>[k]</a>"

	body += {"<br>
		</body></html>
	"}

	var/window_size = "size=550x515"
	if(owner.window_scaling && ui_scale)
		window_size = "size=[550 * owner.window_scaling]x[515 * owner.window_scaling]"

	usr << browse(body, "window=adminplayeropts;[window_size]")
	feedback_add_details("admin_verb","SPP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/datum/player_info/var/author // admin who authored the information
/datum/player_info/var/rank //rank of admin who made the notes
/datum/player_info/var/content // text content of the information
/datum/player_info/var/timestamp // Because this is bloody annoying

#define PLAYER_NOTES_ENTRIES_PER_PAGE 50
/datum/admins/proc/PlayerNotes()
	set category = "Admin"
	set name = "Player Notes"
	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		to_chat(usr, "Error: you are not an admin!")
		return
	if (!check_rights(R_ADMIN|R_MOD))
		return
	if (GLOB.config.ban_legacy_system)
		PlayerNotesPage(1)
	else
		show_notes_sql()

/datum/admins/proc/PlayerNotesPage(page)
	var/dat = "<B>Player notes</B><HR>"
	var/savefile/S=new("data/player_notes.sav")
	var/list/note_keys
	S >> note_keys
	if(!note_keys)
		dat += "No notes found."
	else
		dat += "<table>"
		note_keys = sortList(note_keys)

		// Display the notes on the current page
		var/number_pages = note_keys.len / PLAYER_NOTES_ENTRIES_PER_PAGE
		// Emulate ceil(why does BYOND not have ceil)
		if(number_pages != round(number_pages))
			number_pages = round(number_pages) + 1
		var/page_index = page - 1
		if(page_index < 0 || page_index >= number_pages)
			return

		var/lower_bound = page_index * PLAYER_NOTES_ENTRIES_PER_PAGE + 1
		var/upper_bound = (page_index + 1) * PLAYER_NOTES_ENTRIES_PER_PAGE
		upper_bound = min(upper_bound, note_keys.len)
		for(var/index = lower_bound, index <= upper_bound, index++)
			var/t = note_keys[index]
			dat += "<tr><td><a href='byond://?src=[REF(src)];notes=show;ckey=[t]'>[t]</a></td></tr>"

		dat += "</table><br>"

		// Display a footer to select different pages
		for(var/index = 1, index <= number_pages, index++)
			if(index == page)
				dat += "<b>"
			dat += "<a href='byond://?src=[REF(src)];notes=list;index=[index]'>[index]</a> "
			if(index == page)
				dat += "</b>"

	usr << browse(HTML_SKELETON(dat), "window=player_notes;size=400x400")


/datum/admins/proc/player_has_info(var/key as text)
	var/savefile/info = new("data/player_saves/[copytext(key, 1, 2)]/[key]/info.sav")
	var/list/infos
	info >> infos
	if(!infos || !infos.len) return 0
	else return 1


/datum/admins/proc/show_player_info(var/key as text)
	set category = "Admin"
	set name = "Show Player Info"
	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		to_chat(usr, "Error: you are not an admin!")
		return

	if (GLOB.config.ban_legacy_system)
		var/dat = "<html><head><title>Info on [key]</title></head>"
		dat += "<body>"

		var/p_age = "unknown"
		for(var/client/C in GLOB.clients)
			if(C.ckey == key)
				p_age = C.player_age
				break
		dat +="<span style='color:#000000; font-weight: bold'>Player age: [p_age]</span><br>"

		var/savefile/info = new("data/player_saves/[copytext(key, 1, 2)]/[key]/info.sav")
		var/list/infos
		info >> infos
		if(!infos)
			dat += "No information found on the given key.<br>"
		else
			var/update_file = 0
			var/i = 0
			for(var/datum/player_info/I in infos)
				i += 1
				if(!I.timestamp)
					I.timestamp = "Pre-4/3/2012"
					update_file = 1
				if(!I.rank)
					I.rank = "N/A"
					update_file = 1
				dat += "<font color=#008800>[I.content]</font> <i>by [I.author] ([I.rank])</i> on <i><font color=blue>[I.timestamp]</i></font> "
				if(I.author == usr.key || I.author == "Adminbot")
					dat += "<A href='byond://?src=[REF(src)];remove_player_info=[key];remove_index=[i]'>Remove</A>"
				dat += "<br><br>"
			if(update_file) info << infos

		dat += "<br>"
		dat += "<A href='byond://?src=[REF(src)];add_player_info=[key]'>Add Comment</A><br>"

		dat += "</body></html>"
		show_browser(usr, HTML_SKELETON(dat), "window=adminplayerinfo;size=480x480")
	else
		show_notes_sql(key)

/datum/admins/proc/access_news_network() //MARKER
	set category = "Fun"
	set name = "Access Newscaster Network"
	set desc = "Allows you to view, add and edit news feeds."

	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		to_chat(usr, "Error: you are not an admin!")
		return

	if (!admincaster_signature)
		update_newscaster_sig()
	var/dat
	dat = "<H3>Admin Newscaster Unit</H3>"

	switch(admincaster_screen)
		if(0)
			dat += {"Welcome to the admin newscaster.<BR> Here you can add, edit and censor every newspiece on the network.
				<BR>Feed channels and stories entered through here will be uneditable and handled as official news by the rest of the units.
				<BR>Note that this panel allows full freedom over the news network, there are no constrictions except the few basic ones. Don't break things!
			"}
			if(SSnews.wanted_issue)
				dat+= "<HR><A href='byond://?src=[REF(src)];ac_view_wanted=1'>Read Wanted Issue</A>"

			dat+= {"<HR><BR><A href='byond://?src=[REF(src)];ac_create_channel=1'>Create Feed Channel</A>
				<BR><A href='byond://?src=[REF(src)];ac_view=1'>View Feed Channels</A>
				<BR><A href='byond://?src=[REF(src)];ac_create_feed_story=1'>Submit new Feed story</A>
				<BR><BR><A href='byond://?src=[REF(usr)];mach_close=newscaster_main'>Exit</A>
			"}

			var/wanted_already = 0
			if(SSnews.wanted_issue)
				wanted_already = 1

			dat+={"<HR><B>Feed Security functions:</B><BR>
				<BR><A href='byond://?src=[REF(src)];ac_menu_wanted=1'>[(wanted_already) ? ("Manage") : ("Publish")] \"Wanted\" Issue</A>
				<BR><A href='byond://?src=[REF(src)];ac_menu_censor_story=1'>Censor Feed Stories</A>
				<BR><A href='byond://?src=[REF(src)];ac_menu_censor_channel=1'>Mark Feed Channel with [SSatlas.current_map.company_name] D-Notice (disables and locks the channel.</A>
				<BR><HR><A href='byond://?src=[REF(src)];ac_set_signature=1'>The newscaster recognises you as:<BR> <FONT COLOR='green'>[src.admincaster_signature]</FONT></A>
			"}
		if(1)
			dat+= "Feed Channels<HR>"
			if( isemptylist(SSnews.network_channels) )
				dat+="<I>No active channels found...</I>"
			else
				for(var/channel in SSnews.network_channels)
					var/datum/feed_channel/FC = SSnews.GetFeedChannel(channel)
					if(FC.is_admin_channel)
						dat+="<B><FONT style='BACKGROUND-COLOR: LightGreen'><A href='byond://?src=[REF(src)];ac_show_channel=[REF(FC)]'>[FC.channel_name]</A></FONT></B><BR>"
					else
						dat+="<B><A href='byond://?src=[REF(src)];ac_show_channel=[REF(FC)]'>[FC.channel_name]</A> [(FC.censored) ? (SPAN_WARNING("***")) : null]<BR></B>"
			dat+={"<BR><HR><A href='byond://?src=[REF(src)];ac_refresh=1'>Refresh</A>
				<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Back</A>
			"}

		if(2)
			dat+={"
				Creating new Feed Channel...
				<HR><B><A href='byond://?src=[REF(src)];ac_set_channel_name=1'>Channel Name</A>:</B> [src.admincaster_feed_channel.channel_name]<BR>
				<B><A href='byond://?src=[REF(src)];ac_set_signature=1'>Channel Author</A>:</B> <FONT COLOR='green'>[src.admincaster_signature]</FONT><BR>
				<B><A href='byond://?src=[REF(src)];ac_set_channel_lock=1'>Will Accept Public Feeds</A>:</B> [(src.admincaster_feed_channel.locked) ? ("NO") : ("YES")]<BR><BR>
				<BR><A href='byond://?src=[REF(src)];ac_submit_new_channel=1'>Submit</A><BR><BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Cancel</A><BR>
			"}
		if(3)
			dat+={"
				Creating new Feed Message...
				<HR><B><A href='byond://?src=[REF(src)];ac_set_channel_receiving=1'>Receiving Channel</A>:</B> [src.admincaster_feed_channel.channel_name]<BR>" //MARK
				<B>Message Author:</B> <FONT COLOR='green'>[src.admincaster_signature]</FONT><BR>
				<B><A href='byond://?src=[REF(src)];ac_set_new_message=1'>Message Body</A>:</B> [src.admincaster_feed_message.body] <BR>
				<BR><A href='byond://?src=[REF(src)];ac_submit_new_message=1'>Submit</A><BR><BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Cancel</A><BR>
			"}
		if(4)
			dat+={"
					Feed story successfully submitted to [src.admincaster_feed_channel.channel_name].<BR><BR>
					<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Return</A><BR>
				"}
		if(5)
			dat+={"
				Feed Channel [src.admincaster_feed_channel.channel_name] created successfully.<BR><BR>
				<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Return</A><BR>
			"}
		if(6)
			dat+="<B><FONT COLOR='maroon'>ERROR: Could not submit Feed story to Network.</B></FONT><HR><BR>"
			if(src.admincaster_feed_channel.channel_name=="")
				dat+="<FONT COLOR='maroon'>Invalid receiving channel name.</FONT><BR>"
			if(src.admincaster_feed_message.body == "" || src.admincaster_feed_message.body == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid message body.</FONT><BR>"
			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[3]'>Return</A><BR>"
		if(7)
			dat+="<B><FONT COLOR='maroon'>ERROR: Could not submit Feed Channel to Network.</B></FONT><HR><BR>"
			if(src.admincaster_feed_channel.channel_name =="" || src.admincaster_feed_channel.channel_name == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid channel name.</FONT><BR>"
			var/check = 0
			for(var/channel in SSnews.network_channels)
				var/datum/feed_channel/FC = SSnews.GetFeedChannel(channel)
				if(FC.channel_name == src.admincaster_feed_channel.channel_name)
					check = 1
					break
			if(check)
				dat+="<FONT COLOR='maroon'>Channel name already in use.</FONT><BR>"
			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[2]'>Return</A><BR>"
		if(9)
			dat+="<B>[src.admincaster_feed_channel.channel_name]: </B><FONT SIZE=1>\[created by: <FONT COLOR='maroon'>[src.admincaster_feed_channel.author]</FONT>\]</FONT><HR>"
			if(src.admincaster_feed_channel.censored)
				dat+={"
					<span class='warning'><B>ATTENTION: </B></span>This channel has been deemed as threatening to the welfare of the [station_name(TRUE)], and marked with a [SSatlas.current_map.company_name] D-Notice.<BR>
					No further feed story additions are allowed while the D-Notice is in effect.<BR><BR>
				"}
			else
				if( isemptylist(src.admincaster_feed_channel.messages) )
					dat+="<I>No feed messages found in channel...</I><BR>"
				else
					var/i = 0
					for(var/datum/feed_message/MESSAGE in src.admincaster_feed_channel.messages)
						i++
						dat+="<BLOCKQUOTE style=\"padding:4px;border-left:4px #797979 solid\">[MESSAGE.body] <FONT SIZE=1>\[Likes: <A href='byond://?src=[REF(src)];ac_setlikes=1;'><FONT COLOR='DarkGreen'>[MESSAGE.likes]</FONT></A> Dislikes: <A href='byond://?src=[REF(src)];ac_setdislikes=1;'><FONT COLOR='maroon'>[MESSAGE.dislikes]</FONT></A>\]</FONT><BR>"
						if(MESSAGE.img)
							send_rsc(usr, MESSAGE.img, "tmp_photo[i].png")
							dat+="<img src='tmp_photo[i].png' width = '180'><BR><BR>"
						dat+="<FONT SIZE=1><A href='byond://?src=[REF(src)];ac_view_comments=1;ac_story=[REF(MESSAGE)]'>View Comments</A> <A href='byond://?src=[REF(src)];ac_add_comment=1;ac_story=[REF(MESSAGE)]'>Add Comment</A> <A href='byond://?src=[REF(src)];ac_like=1;ac_story=[REF(MESSAGE)]'>Like Story</A> <A href='byond://?src=[REF(src)];ac_dislike=1;ac_story=[REF(MESSAGE)]'>Dislike Story</A></FONT><BR>"
						dat+="<FONT SIZE=1>\[Story by <FONT COLOR='maroon'>[MESSAGE.author] - [MESSAGE.time_stamp]</FONT>\]</FONT></BLOCKQUOTE><BR>"
			dat+={"
				<BR><HR><A href='byond://?src=[REF(src)];ac_refresh=1'>Refresh</A>
				<BR><A href='byond://?src=[REF(src)];ac_setScreen=[1]'>Back</A>
			"}
		if(10)
			dat+={"
				<B>[SSatlas.current_map.company_name] Feed Censorship Tool</B><BR>
				<FONT SIZE=1>NOTE: Due to the nature of news Feeds, total deletion of a Feed Story is not possible.<BR>
				Keep in mind that users attempting to view a censored feed will instead see the \[REDACTED\] tag above it.</FONT>
				<HR>Select Feed channel to get Stories from:<BR>
			"}
			if(isemptylist(SSnews.network_channels))
				dat+="<I>No feed channels found active...</I><BR>"
			else
				for(var/channel in SSnews.network_channels)
					var/datum/feed_channel/FC = SSnews.GetFeedChannel(channel)
					dat+="<A href='byond://?src=[REF(src)];ac_pick_censor_channel=[REF(FC)]'>[FC.channel_name]</A> [(FC.censored) ? (SPAN_WARNING("***")) : null]<BR>"
			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Cancel</A>"
		if(11)
			dat+={"
				<B>[SSatlas.current_map.company_name] D-Notice Handler</B><HR>
				<FONT SIZE=1>A D-Notice is to be bestowed upon the channel if the handling Authority deems it as harmful for the [station_name(TRUE)]'s
				morale, integrity or disciplinary behaviour. A D-Notice will render a channel unable to be updated by anyone, without deleting any feed
				stories it might contain at the time. You can lift a D-Notice if you have the required access at any time.</FONT><HR>
			"}
			if(isemptylist(SSnews.network_channels))
				dat+="<I>No feed channels found active...</I><BR>"
			else
				for(var/channel in SSnews.network_channels)
					var/datum/feed_channel/FC = SSnews.GetFeedChannel(channel)
					dat+="<A href='byond://?src=[REF(src)];ac_pick_d_notice=[REF(FC)]'>[FC.channel_name]</A> [(FC.censored) ? (SPAN_WARNING("***")) : null]<BR>"

			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Back</A>"
		if(12)
			dat+={"
				<B>[src.admincaster_feed_channel.channel_name]: </B><FONT SIZE=1>\[ created by: <FONT COLOR='maroon'>[src.admincaster_feed_channel.author]</FONT> \]</FONT><BR>
				<FONT SIZE=2><A href='byond://?src=[REF(src)];ac_censor_channel_author=[REF(src.admincaster_feed_channel)]'>[(src.admincaster_feed_channel.author=="\[REDACTED\]") ? ("Undo Author censorship") : ("Censor channel Author")]</A></FONT><HR>
			"}
			if( isemptylist(src.admincaster_feed_channel.messages) )
				dat+="<I>No feed messages found in channel...</I><BR>"
			else
				for(var/datum/feed_message/MESSAGE in src.admincaster_feed_channel.messages)
					dat+={"
						-[MESSAGE.body] <BR><FONT SIZE=1>\[Story by <FONT COLOR='maroon'>[MESSAGE.author]</FONT>\]</FONT><BR>
						<FONT SIZE=2><A href='byond://?src=[REF(src)];ac_censor_channel_story_body=[REF(MESSAGE)]'>[(MESSAGE.body == "\[REDACTED\]") ? ("Undo story censorship") : ("Censor story")]</A>  -  <A href='byond://?src=[REF(src)];ac_censor_channel_story_author=[REF(MESSAGE)]'>[(MESSAGE.author == "\[REDACTED\]") ? ("Undo Author Censorship") : ("Censor message Author")]</A></FONT><BR>
					"}
			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[10]'>Back</A>"
		if(13)
			dat+={"
				<B>[src.admincaster_feed_channel.channel_name]: </B><FONT SIZE=1>\[ created by: <FONT COLOR='maroon'>[src.admincaster_feed_channel.author]</FONT> \]</FONT><BR>
				Channel messages listed below. If you deem them dangerous to the [station_name(TRUE)], you can <A href='byond://?src=[REF(src)];ac_toggle_d_notice=[REF(src.admincaster_feed_channel)]'>Bestow a D-Notice upon the channel</A>.<HR>
			"}
			if(src.admincaster_feed_channel.censored)
				dat+={"
					<span class='warning'><B>ATTENTION: </B></span>This channel has been deemed as threatening to the welfare of the [station_name(TRUE)], and marked with a [SSatlas.current_map.company_name] D-Notice.<BR>
					No further feed story additions are allowed while the D-Notice is in effect.<BR><BR>
				"}
			else
				if( isemptylist(src.admincaster_feed_channel.messages) )
					dat+="<I>No feed messages found in channel...</I><BR>"
				else
					for(var/datum/feed_message/MESSAGE in src.admincaster_feed_channel.messages)
						dat+="-[MESSAGE.body] <BR><FONT SIZE=1>\[Story by <FONT COLOR='maroon'>[MESSAGE.author]</FONT>\]</FONT><BR>"

			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[11]'>Back</A>"
		if(14)
			dat+="<B>Wanted Issue Handler:</B>"
			var/wanted_already = 0
			var/end_param = 1
			if(SSnews.wanted_issue)
				wanted_already = 1
				end_param = 2
			if(wanted_already)
				dat+="<FONT SIZE=2><BR><I>A wanted issue is already in Feed Circulation. You can edit or cancel it below.</FONT></I>"
			dat+={"
				<HR>
				<A href='byond://?src=[REF(src)];ac_set_wanted_name=1'>Criminal Name</A>: [src.admincaster_feed_message.author] <BR>
				<A href='byond://?src=[REF(src)];ac_set_wanted_desc=1'>Description</A>: [src.admincaster_feed_message.body] <BR>
			"}
			if(wanted_already)
				dat+="<B>Wanted Issue created by:</B><FONT COLOR='green'> [SSnews.wanted_issue.backup_author]</FONT><BR>"
			else
				dat+="<B>Wanted Issue will be created under prosecutor:</B><FONT COLOR='green'> [src.admincaster_signature]</FONT><BR>"
			dat+="<BR><A href='byond://?src=[REF(src)];ac_submit_wanted=[end_param]'>[(wanted_already) ? ("Edit Issue") : ("Submit")]</A>"
			if(wanted_already)
				dat+="<BR><A href='byond://?src=[REF(src)];ac_cancel_wanted=1'>Take down Issue</A>"
			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Cancel</A>"
		if(15)
			dat+={"
				<FONT COLOR='green'>Wanted issue for [src.admincaster_feed_message.author] is now in Network Circulation.</FONT><BR><BR>
				<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Return</A><BR>
			"}
		if(16)
			dat+="<B><FONT COLOR='maroon'>ERROR: Wanted Issue rejected by Network.</B></FONT><HR><BR>"
			if(src.admincaster_feed_message.author =="" || src.admincaster_feed_message.author == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid name for person wanted.</FONT><BR>"
			if(src.admincaster_feed_message.body == "" || src.admincaster_feed_message.body == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid description.</FONT><BR>"
			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Return</A><BR>"
		if(17)
			dat+={"
				<B>Wanted Issue successfully deleted from Circulation</B><BR>
				<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Return</A><BR>
			"}
		if(18)
			dat+={"
				<B><FONT COLOR ='maroon'>-- STATIONWIDE WANTED ISSUE --</B></FONT><BR><FONT SIZE=2>\[Submitted by: <FONT COLOR='green'>[SSnews.wanted_issue.backup_author]</FONT>\]</FONT><HR>
				<B>Criminal</B>: [SSnews.wanted_issue.author]<BR>
				<B>Description</B>: [SSnews.wanted_issue.body]<BR>
				<B>Photo:</B>:
			"}
			if(SSnews.wanted_issue.img)
				send_rsc(usr, SSnews.wanted_issue.img, "tmp_photow.png")
				dat+="<BR><img src='tmp_photow.png' width = '180'>"
			else
				dat+="None"
			dat+="<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Back</A><BR>"
		if(19)
			dat+={"
				<FONT COLOR='green'>Wanted issue for [src.admincaster_feed_message.author] successfully edited.</FONT><BR><BR>
				<BR><A href='byond://?src=[REF(src)];ac_setScreen=[0]'>Return</A><BR>
			"}
		if(20) //comments but with more censorship!
			dat+="<B>Comments:</B></BR>"
			if(isemptylist(src.admincaster_viewing_message.comments))
				dat+="No comments on this story yet!</BR>"
			else
				for(var/datum/feed_comment/COMMENT in src.admincaster_viewing_message.comments)
					dat+="<BLOCKQUOTE style=\"padding:2px 4px;border-left:4px #797979 solid;\"><B>\[[world.time]\] [COMMENT.author]:</B>[COMMENT.message]<BR><A href='byond://?src=[REF(src)];ac_censorcomment=1;ac_comment=[REF(COMMENT)]'>Censor Comment</A></BLOCKQUOTE>"
			dat+="<A href='byond://?src=[REF(src)];ac_setScreen=[9]'>Return</A>"
		else
			dat+="Please report this on GitHub, along with what you did to make this appear."


	usr << browse(HTML_SKELETON(dat), "window=admincaster_main;size=400x600")
	onclose(usr, "admincaster_main")



/datum/admins/proc/Jobbans()
	if(!check_rights(R_BAN))
		return

	// RIP whoever uses this panel. It's going to be amazingly painful!
	var/dat = "<B>Job Bans!</B><HR>"
	dat += "<a href='byond://?src=[REF(src)];jobban_search=1'>Search via ckey</a><br>"
	dat += "<table>"
	for (var/ckey in GLOB.jobban_keylist)
		for (var/job in GLOB.jobban_keylist[ckey])
			var/list/ban = GLOB.jobban_keylist[ckey][job]
			if (!jobban_isexpired(ban, null, job, ckey))
				dat += "<tr><td>[ckey] - [ban[2]] - (<a href='byond://?src=[REF(src)];jobban_tgt=[ckey];jobban_job=[job];'>unban</a>)</td></tr>"

	dat += "</table>"
	usr << browse(HTML_SKELETON(dat), "window=ban;size=400x400")

/datum/admins/proc/Game()
	if(!check_rights(0))	return

	var/dat = {"
		<center><B>Game Panel</B></center><hr>\n
		<A href='byond://?src=[REF(src)];c_mode=1'>Change Game Mode</A><br>
		"}
	if(GLOB.master_mode == ROUNDTYPE_STR_SECRET || GLOB.master_mode == ROUNDTYPE_STR_MIXED_SECRET)
		dat += "<A href='byond://?src=[REF(src)];f_secret=1'>(Force Secret Mode)</A><br>"

	dat += {"
		<BR>
		<A href='byond://?src=[REF(src)];create_object=1'>Create Object</A><br>
		<A href='byond://?src=[REF(src)];create_turf=1'>Create Turf</A><br>
		<A href='byond://?src=[REF(src)];create_mob=1'>Create Mob</A><br>
		<br><A href='byond://?src=[REF(src)];vsc=airflow'>Edit Airflow Settings</A><br>
		<A href='byond://?src=[REF(src)];vsc=phoron'>Edit Phoron Settings</A><br>
		<A href='byond://?src=[REF(src)];vsc=default'>Choose a default ZAS setting</A><br>
		"}

	usr << browse(HTML_SKELETON(dat), "window=admin2;size=210x280")
	return

/datum/admins/proc/Secrets()
	if(!check_rights(0))	return

	var/dat = "<B>The first rule of adminbuse is: you don't talk about the adminbuse.</B><HR>"
	for(var/datum/admin_secret_category/category in admin_secrets.categories)
		if(!category.can_view(usr))
			continue
		dat += "<B>[category.name]</B><br>"
		if(category.desc)
			dat += "<I>[category.desc]</I><BR>"
		for(var/datum/admin_secret_item/item in category.items)
			if(!item.can_view(usr))
				continue
			dat += "<A href='byond://?src=[REF(src)];admin_secrets=[REF(item)]'>[item.name()]</A><BR>"
		dat += "<BR>"
	usr << browse(HTML_SKELETON(dat), "window=secrets")
	return



/////////////////////////////////////////////////////////////////////////////////////////////////admins2.dm merge
//i.e. buttons/verbs


/datum/admins/proc/restart()
	set category = "Server"
	set name = "Restart"
	set desc="Restarts the world"
	if (!usr.client.holder)
		return
	var/confirm = alert("Restart the game world?", "Restart", "Yes", "Cancel")
	if(confirm == "Cancel")
		return
	if(confirm == "Yes")
		to_world(SPAN_DANGER("Restarting world!</span> <span class='notice'>Initiated by [usr.client.holder.fakekey ? "Admin" : usr.key]!"))
		log_admin("[key_name(usr)] initiated a reboot.")

		feedback_set_details("end_error","admin reboot - by [usr.key] [usr.client.holder.fakekey ? "(stealth)" : ""]")
		feedback_add_details("admin_verb","R") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

		sleep(50)
		world.Reboot()


/datum/admins/proc/announce()
	set category = "Special Verbs"
	set name = "Announce"
	set desc="Announce your desires to the world"

	if (!check_rights(R_ADMIN))
		return

	var/message = tgui_input_text(usr, "Enter a global message to send.", "Admin Announce", multiline = TRUE)
	if(message)
		if(!check_rights(R_SERVER, 0))
			message = sanitize(message, 500, extra = 0)
		message = replacetext(message, "\n", "<br>") // required since we're putting it in a <p> tag
		to_world("<span class=notice><b>[usr.client.holder.fakekey ? "Administrator" : usr.key] Announces:</b><p style='text-indent: 50px'>[message]</p></span>")
		log_admin("Announce: [key_name(usr)] : [message]")
	feedback_add_details("admin_verb","A") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleooc()
	set category = "Server"
	set desc="Globally Toggles OOC"
	set name="Toggle OOC"

	if(!check_rights(R_ADMIN))
		return

	GLOB.config.ooc_allowed = !(GLOB.config.ooc_allowed)
	if (GLOB.config.ooc_allowed)
		to_world("<B>The OOC channel has been globally enabled!</B>")
	else
		to_world("<B>The OOC channel has been globally disabled!</B>")
	log_and_message_admins("toggled OOC.")
	feedback_add_details("admin_verb","TOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/togglelooc()
	set category = "Server"
	set desc="Globally Toggles LOOC"
	set name="Toggle LOOC"

	if(!check_rights(R_ADMIN))
		return

	GLOB.config.looc_allowed = !(GLOB.config.looc_allowed)
	if (GLOB.config.looc_allowed)
		to_world("<B>The LOOC channel has been globally enabled!</B>")
	else
		to_world("<B>The LOOC channel has been globally disabled!</B>")
	log_and_message_admins("toggled LOOC.")
	feedback_add_details("admin_verb","TLOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/datum/admins/proc/toggledsay()
	set category = "Server"
	set desc="Globally Toggles DSAY"
	set name="Toggle DSAY"

	if(!check_rights(R_ADMIN))
		return

	GLOB.config.dsay_allowed = !(GLOB.config.dsay_allowed)
	if (GLOB.config.dsay_allowed)
		to_world("<B>Deadchat has been globally enabled!</B>")
	else
		to_world("<B>Deadchat has been globally disabled!</B>")
	log_admin("[key_name(usr)] toggled deadchat.")
	message_admins("[key_name_admin(usr)] toggled deadchat.", 1)
	feedback_add_details("admin_verb","TDSAY") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc

/datum/admins/proc/toggleoocdead()
	set category = "Server"
	set desc="Toggle Dead OOC."
	set name="Toggle Dead OOC"

	if(!check_rights(R_ADMIN))
		return

	GLOB.config.dooc_allowed = !( GLOB.config.dooc_allowed )
	log_and_message_admins("toggled dead (global) OOC. (New state: [GLOB.config.dooc_allowed])")
	feedback_add_details("admin_verb","TDOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggle_dead_looc()
	set category = "Server"
	set desc = "Toggle Dead LOOC."
	set name = "Toggle Dead LOOC"

	if (!check_rights(R_ADMIN))
		return

	GLOB.config.dead_looc_allowed = !GLOB.config.dead_looc_allowed
	log_and_message_admins("toggled dead LOOC. (New state: [GLOB.config.dead_looc_allowed])")

/datum/admins/proc/togglehubvisibility()
	set category = "Server"
	set desc="Globally Toggles Hub Visibility"
	set name="Toggle Hub Visibility"

	if(!check_rights(R_SERVER))
		return

	world.visibility = !(world.visibility)
	var/long_message = " toggled hub visibility. The server is now [world.visibility ? "visible" : "invisible"] ([world.visibility])."

	SSdiscord.post_webhook_event(WEBHOOK_ADMIN, list("title"="Hub visibility has been toggled", "message"="**[key_name(src)]**" + long_message))
	SSdiscord.send_to_admins("[key_name(src)]" + long_message)
	message_admins("[key_name_admin(usr)]" + long_message, 1)
	log_admin("[key_name(usr)] toggled hub visibility.")
	feedback_add_details("admin_verb","THUB") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc

/datum/admins/proc/toggletraitorscaling()
	set category = "Server"
	set desc="Toggle traitor scaling"
	set name="Toggle Traitor Scaling"
	GLOB.config.traitor_scaling = !GLOB.config.traitor_scaling
	log_admin("[key_name(usr)] toggled Traitor Scaling to [GLOB.config.traitor_scaling].")
	message_admins("[key_name_admin(usr)] toggled Traitor Scaling [GLOB.config.traitor_scaling ? "on" : "off"].", 1)
	feedback_add_details("admin_verb","TTS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/startnow()
	set category = "Server"
	set desc="Start the round RIGHT NOW"
	set name="Start Now"
	if(!MC_RUNNING())
		to_chat(usr, SPAN_NOTICE("The round will be started automatically as soon as ready."))
		UNTIL(SSticker?.current_state == GAME_STATE_PREGAME)
	if(SSticker.current_state == GAME_STATE_PREGAME)
		SSticker.current_state = GAME_STATE_SETTING_UP
		log_admin("[usr.key] has started the game.")
		message_admins(SPAN_NOTICE("[usr.key] has started the game."))
		feedback_add_details("admin_verb","SN") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		return 1
	else
		to_chat(usr, SPAN_WARNING("Error: Start Now: Game has already started."))
		return 0

/datum/admins/proc/toggleenter()
	set category = "Server"
	set desc="People can't enter"
	set name="Toggle Entering"
	GLOB.config.enter_allowed = !(GLOB.config.enter_allowed)
	if (!(GLOB.config.enter_allowed))
		to_world("<B>New players may no longer enter the game.</B>")
	else
		to_world("<B>New players may now enter the game.</B>")
	log_admin("[key_name(usr)] toggled new player game entering.")
	message_admins(SPAN_NOTICE("[key_name_admin(usr)] toggled new player game entering."), 1)
	world.update_status()
	feedback_add_details("admin_verb","TE") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleAI()
	set category = "Server"
	set desc="People can't be AI"
	set name="Toggle AI"
	GLOB.config.allow_ai = !( GLOB.config.allow_ai )
	if (!( GLOB.config.allow_ai ))
		to_world("<B>The AI job is no longer chooseable.</B>")
	else
		to_world("<B>The AI job is chooseable now.</B>")
	log_admin("[key_name(usr)] toggled AI allowed.")
	world.update_status()
	feedback_add_details("admin_verb","TAI") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleaban()
	set category = "Server"
	set desc="Respawn basically"
	set name="Toggle Respawn"
	GLOB.config.abandon_allowed = !(GLOB.config.abandon_allowed)
	if(GLOB.config.abandon_allowed)
		to_world("<B>You may now respawn.</B>")
	else
		to_world("<B>You may no longer respawn :(</B>")
	message_admins(SPAN_NOTICE("[key_name_admin(usr)] toggled respawn to [GLOB.config.abandon_allowed ? "On" : "Off"]."), 1)
	log_admin("[key_name(usr)] toggled respawn to [GLOB.config.abandon_allowed ? "On" : "Off"].")
	world.update_status()
	feedback_add_details("admin_verb","TR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggle_space_ninja()
	set category = "Server"
	set desc="Toggle space ninjas spawning."
	set name="Toggle Space Ninjas"
	GLOB.config.ninjas_allowed = !GLOB.config.ninjas_allowed
	log_admin("[key_name(usr)] toggled Space Ninjas to [GLOB.config.ninjas_allowed].")
	message_admins("[key_name_admin(usr)] toggled Space Ninjas [GLOB.config.ninjas_allowed ? "on" : "off"].", 1)
	feedback_add_details("admin_verb","TSN") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/delay()
	set category = "Server"
	set desc="Delay the game start/end"
	set name="Delay"

	if(!check_rights(R_SERVER))	return
	if (ROUND_IS_STARTED)
		SSticker.delay_end = !SSticker.delay_end
		log_admin("[key_name(usr)] [SSticker.delay_end ? "delayed the round end" : "has made the round end normally"].")
		message_admins(SPAN_NOTICE("[key_name(usr)] [SSticker.delay_end ? "delayed the round end" : "has made the round end normally"]."), 1)
		return //alert("Round end delayed", null, null, null, null, null)
	GLOB.round_progressing = !GLOB.round_progressing
	if (!GLOB.round_progressing)
		to_world("<b>The game start has been delayed.</b>")
		log_admin("[key_name(usr)] delayed the game.")
	else
		to_world("<b>The game will start soon.</b>")
		log_admin("[key_name(usr)] removed the delay.")
	feedback_add_details("admin_verb","DELAY") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/adjump()
	set category = "Server"
	set desc="Toggle admin jumping"
	set name="Toggle Jump"
	GLOB.config.allow_admin_jump = !(GLOB.config.allow_admin_jump)
	message_admins(SPAN_NOTICE("Toggled admin jumping to [GLOB.config.allow_admin_jump]."))
	feedback_add_details("admin_verb","TJ") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/adspawn()
	set category = "Server"
	set desc="Toggle admin spawning"
	set name="Toggle Spawn"
	GLOB.config.allow_admin_spawning = !(GLOB.config.allow_admin_spawning)
	message_admins(SPAN_NOTICE("Toggled admin item spawning to [GLOB.config.allow_admin_spawning]."))
	feedback_add_details("admin_verb","TAS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/adrev()
	set category = "Server"
	set desc="Toggle admin revives"
	set name="Toggle Revive"
	GLOB.config.allow_admin_rev = !(GLOB.config.allow_admin_rev)
	message_admins(SPAN_NOTICE("Toggled reviving to [GLOB.config.allow_admin_rev]."))
	feedback_add_details("admin_verb","TAR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/immreboot()
	set category = "Server"
	set desc="Reboots the server post haste"
	set name="Immediate Reboot"
	if(!usr.client.holder)	return
	if( alert("Reboot server?",,"Yes","No") == "No")
		return
	to_world(SPAN_DANGER("Rebooting world!</span> <span class='notice'>Initiated by [usr.client.holder.fakekey ? "Admin" : usr.key]!"))
	log_admin("[key_name(usr)] initiated an immediate reboot.")

	feedback_set_details("end_error","immediate admin reboot - by [usr.key] [usr.client.holder.fakekey ? "(stealth)" : ""]")
	feedback_add_details("admin_verb","IR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	world.Reboot()

/datum/admins/proc/unprison(var/mob/M in GLOB.mob_list)
	set category = "Admin"
	set name = "Unprison"
	if (M.z == 2)
		if (GLOB.config.allow_admin_jump)
			M.forceMove(pick(GLOB.latejoin))
			message_admins("[key_name_admin(usr)] has unprisoned [key_name_admin(M)]", 1)
			log_admin("[key_name(usr)] has unprisoned [key_name(M)]")
		else
			alert("Admin jumping disabled")
	else
		alert("[M.name] is not prisoned.")
	feedback_add_details("admin_verb","UP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

////////////////////////////////////////////////////////////////////////////////////////////////ADMIN HELPER PROCS

/proc/is_special_character(var/mob/M) // returns 1 for specail characters and 2 for heroes of gamemode
	if(!SSticker.mode)
		return 0
	if (!istype(M))
		return 0

	if(M.mind)
		if(SSticker.mode.antag_templates && SSticker.mode.antag_templates.len)
			for(var/datum/antagonist/antag in SSticker.mode.antag_templates)
				if(antag.is_antagonist(M.mind))
					return 2
		else if(M.mind.special_role)
			return 1

	if(isrobot(M))
		var/mob/living/silicon/robot/R = M
		if(R.emagged)
			return 1

	return 0

/datum/admins/proc/spawn_fruit(seedtype in SSplants.seeds)
	set category = "Debug"
	set desc = "Spawn the product of a seed."
	set name = "Spawn Fruit"

	if(!check_rights(R_SPAWN))	return

	if(!seedtype || !SSplants.seeds[seedtype])
		return
	var/datum/seed/S = SSplants.seeds[seedtype]
	S.harvest(usr,0,0,1)
	log_admin("[key_name(usr)] spawned [seedtype] fruit at ([usr.x],[usr.y],[usr.z])")

/datum/admins/proc/spawn_custom_item()
	set category = "Debug"
	set desc = "Spawn a custom item."
	set name = "Spawn Custom Item"

	if(!check_rights(R_SPAWN))	return

	var/owner = input("Select a ckey.", "Spawn Custom Item") as null|anything in GLOB.custom_items
	if(!owner|| !GLOB.custom_items[owner])
		return

	var/list/possible_items = GLOB.custom_items[owner]
	var/datum/custom_item/item_to_spawn = input("Select an item to spawn.", "Spawn Custom Item") as null|anything in possible_items
	if(!item_to_spawn)
		return

	item_to_spawn.spawn_item(get_turf(usr))


/datum/admins/proc/spawn_plant(seedtype in SSplants.seeds)
	set category = "Debug"
	set desc = "Spawn a spreading plant effect."
	set name = "Spawn Plant"

	if(!check_rights(R_SPAWN))	return

	if(!seedtype || !SSplants.seeds[seedtype])
		return
	new /obj/effect/plant(get_turf(usr), SSplants.seeds[seedtype])
	log_admin("[key_name(usr)] spawned [seedtype] vines at ([usr.x],[usr.y],[usr.z])")

/datum/admins/proc/spawn_atom(var/object as text)
	set category = "Debug"
	set desc = "(atom path) Spawn an atom"
	set name = "Spawn"

	if(!check_rights(R_SPAWN))
		return

	var/list/matches = typesof(/atom)

	for(var/path in matches)
		if(!findtext("[path]", object))
			matches -= path

	if(!length(matches))
		return

	var/chosen
	if(length(matches) == 1)
		chosen = matches[1]
	else
		//TGUI input gets fucky if the list is too large, so we revert back to standard input in that case
		if(length(matches) < 1000)
			chosen = tgui_input_list(usr, "Select an atom type", "Spawn Atom", matches)
		else
			chosen = input("Select an atom type", "Spawn Atom", matches[1]) as null|anything in matches

		if(!chosen)
			return

	if(is_abstract(chosen))
		tgui_alert(usr, "This is an abstract type, you can't spawn it!", "Abstract Type")
		return

	if(ispath(chosen, /turf))
		var/turf/T = get_turf(usr.loc)
		T.ChangeTurf(chosen)
	else
		new chosen(usr.loc)

	log_and_message_admins("spawned [chosen] at ([usr.x],[usr.y],[usr.z])")
	feedback_add_details("admin_verb","SA") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/datum/admins/proc/show_traitor_panel(var/mob/M in GLOB.mob_list)
	set category = "Admin"
	set desc = "Edit mobs's memory and role"
	set name = "Show Traitor Panel"

	if(!istype(M))
		to_chat(usr, "This can only be used on instances of type /mob")
		return
	if(!M.mind)
		to_chat(usr, "This mob has no mind!")
		return

	M.mind.edit_memory()
	feedback_add_details("admin_verb","STP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/show_game_mode()
	set category = "Admin"
	set desc = "Show the current round configuration."
	set name = "Show Game Mode"

	if(!ROUND_IS_STARTED)
		alert("Not before roundstart!", "Alert")
		return

	var/out = "<font size=3><b>Current mode: [SSticker.mode.name] (<a href='byond://?src=[REF(SSticker.mode)];debug_antag=self'>[SSticker.mode.config_tag]</a>)</b></font><br/>"
	out += "<hr>"

	if(SSticker.mode.ert_disabled)
		out += "<b>Emergency Response Teams:</b> <a href='byond://?src=[REF(SSticker.mode)];toggle=ert'>disabled</a>"
	else
		out += "<b>Emergency Response Teams:</b> <a href='byond://?src=[REF(SSticker.mode)];toggle=ert'>enabled</a>"
	out += "<br/>"

	if(SSticker.mode.deny_respawn)
		out += "<b>Respawning:</b> <a href='byond://?src=[REF(SSticker.mode)];toggle=respawn'>disallowed</a>"
	else
		out += "<b>Respawning:</b> <a href='byond://?src=[REF(SSticker.mode)];toggle=respawn'>allowed</a>"
	out += "<br/>"

	out += "<b>Shuttle delay multiplier:</b> <a href='byond://?src=[REF(SSticker.mode)];set=shuttle_delay'>[SSticker.mode.shuttle_delay]</a><br/>"

	if(SSticker.mode.auto_recall_shuttle)
		out += "<b>Shuttle auto-recall:</b> <a href='byond://?src=[REF(SSticker.mode)];toggle=shuttle_recall'>enabled</a>"
	else
		out += "<b>Shuttle auto-recall:</b> <a href='byond://?src=[REF(SSticker.mode)];toggle=shuttle_recall'>disabled</a>"
	out += "<br/><br/>"

	if(SSticker.mode.event_delay_mod_moderate)
		out += "<b>Moderate event time modifier:</b> <a href='byond://?src=[REF(SSticker.mode)];set=event_modifier_moderate'>[SSticker.mode.event_delay_mod_moderate]</a><br/>"
	else
		out += "<b>Moderate event time modifier:</b> <a href='byond://?src=[REF(SSticker.mode)];set=event_modifier_moderate'>unset</a><br/>"

	if(SSticker.mode.event_delay_mod_major)
		out += "<b>Major event time modifier:</b> <a href='byond://?src=[REF(SSticker.mode)];set=event_modifier_severe'>[SSticker.mode.event_delay_mod_major]</a><br/>"
	else
		out += "<b>Major event time modifier:</b> <a href='byond://?src=[REF(SSticker.mode)];set=event_modifier_severe'>unset</a><br/>"

	out += "<hr>"

	if(LAZYLEN(SSticker.mode.antag_tags))
		out += "<b>Core antag templates:</b></br>"
		for(var/antag_tag in SSticker.mode.antag_tags)
			out += "<a href='byond://?src=[REF(SSticker.mode)];debug_antag=[antag_tag]'>[antag_tag]</a>.</br>"

	if(SSticker.mode.round_autoantag)
		out += "<b>Autotraitor <a href='byond://?src=[REF(SSticker.mode)];toggle=autotraitor'>enabled</a></b>."
		if(SSticker.mode.antag_scaling_coeff > 0)
			out += " (scaling with <a href='byond://?src=[REF(SSticker.mode)];set=antag_scaling'>[SSticker.mode.antag_scaling_coeff]</a>)"
		else
			out += " (not currently scaling, <a href='byond://?src=[REF(SSticker.mode)];set=antag_scaling'>set a coefficient</a>)"
		out += "<br/>"
	else
		out += "<b>Autotraitor <a href='byond://?src=[REF(SSticker.mode)];toggle=autotraitor'>disabled</a></b>.<br/>"

	out += "<b>All antag ids:</b>"
	if(LAZYLEN(SSticker.mode.antag_templates))
		for(var/datum/antagonist/antag in SSticker.mode.antag_templates)
			antag.update_current_antag_max()
			out += " <a href='byond://?src=[REF(SSticker.mode)];debug_antag=[antag.id]'>[antag.id]</a>"
			out += " ([antag.get_antag_count()]/[antag.cur_max]) "
			out += " <a href='byond://?src=[REF(SSticker.mode)];remove_antag_type=[antag.id]'>\[-\]</a><br/>"
	else
		out += " None."
	out += " <a href='byond://?src=[REF(SSticker.mode)];add_antag_type=1'>\[+\]</a><br/>"

	usr << browse(HTML_SKELETON(out), "window=edit_mode[src]")
	feedback_add_details("admin_verb","SGM")


/datum/admins/proc/toggletintedweldhelmets()
	set category = "Debug"
	set desc="Reduces view range when wearing welding helmets"
	set name="Toggle tinted welding helmets."
	GLOB.config.welder_vision = !( GLOB.config.welder_vision )
	if (GLOB.config.welder_vision)
		to_world("<B>Reduced welder vision has been enabled!</B>")
	else
		to_world("<B>Reduced welder vision has been disabled!</B>")
	log_admin("[key_name(usr)] toggled welder vision.")
	message_admins("[key_name_admin(usr)] toggled welder vision.", 1)
	feedback_add_details("admin_verb","TTWH") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleguests()
	set category = "Server"
	set desc="Guests can't enter"
	set name="Toggle guests"
	GLOB.config.guests_allowed = !(GLOB.config.guests_allowed)
	if (!(GLOB.config.guests_allowed))
		to_world("<B>Guests may no longer enter the game.</B>")
	else
		to_world("<B>Guests may now enter the game.</B>")
	log_admin("[key_name(usr)] toggled guests game entering [GLOB.config.guests_allowed?"":"dis"]allowed.")
	message_admins(SPAN_NOTICE("[key_name_admin(usr)] toggled guests game entering [GLOB.config.guests_allowed?"":"dis"]allowed."), 1)
	feedback_add_details("admin_verb","TGU") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/output_ai_laws()
	var/ai_number = 0
	for(var/mob/living/silicon/S in GLOB.mob_list)
		ai_number++
		if(isAI(S))
			to_chat(usr, "<b>AI [key_name(S, usr)]'s laws:</b>")
		else if(isrobot(S))
			var/mob/living/silicon/robot/R = S
			to_chat(usr, "<b>CYBORG [key_name(S, usr)] [R.connected_ai?"(Slaved to: [R.connected_ai])":"(Independant)"]: laws:</b>")
		else if (ispAI(S))
			to_chat(usr, "<b>pAI [key_name(S, usr)]'s laws:</b>")
		else
			to_chat(usr, "<b>SOMETHING SILICON [key_name(S, usr)]'s laws:</b>")

		if (S.laws == null)
			to_chat(usr, "[key_name(S, usr)]'s laws are null?? Contact a coder.")
		else
			S.laws.show_laws(usr)
	if(!ai_number)
		to_chat(usr, "<b>No AIs located</b>") //Just so you know the thing is actually working and not just ignoring you.)

/client/proc/update_mob_sprite(mob/living/carbon/human/H as mob)
	set category = "Admin"
	set name = "Update Mob Sprite"
	set desc = "Should fix any mob sprite update errors."

	if (!holder)
		to_chat(src, "Only administrators may use this command.")
		return

	if(istype(H))
		H.regenerate_icons()


/proc/get_options_bar(whom, detail = 2, name = 0, link = 1, highlight_special = 1, var/datum/ticket/ticket = null)
	if(!whom)
		return "<b>(*null*)</b>"
	var/mob/M
	var/client/C
	if(istype(whom, /client))
		C = whom
		M = C.mob
	else if(istype(whom, /mob))
		M = whom
		C = M.client
	else
		return "<b>(*not a mob*)</b>"
	switch(detail)
		if(0)
			return "<b>[key_name(C, link, name, highlight_special, ticket)]</b>"

		if(1)	//Private Messages
			return "<b>[key_name(C, link, name, highlight_special, ticket)](<A href='byond://?_src_=holder;adminmoreinfo=[REF(M)]'>?</A>)</b>"

		if(2)	//Admins
			var/ref_mob = "[REF(M)]"
			return "<b>[key_name(C, link, name, highlight_special, ticket)](<A href='byond://?_src_=holder;adminmoreinfo=[ref_mob]'>?</A>) (<A href='byond://?_src_=holder;adminplayeropts=[ref_mob]'>PP</A>) (<A href='byond://?_src_=vars;Vars=[ref_mob]'>VV</A>) (<A href='byond://?_src_=holder;subtlemessage=[ref_mob]'>SM</A>) ([admin_jump_link(M)]) (<A href='byond://?_src_=holder;check_antagonist=1'>CA</A>)</b>"

		if(3)	//Devs
			var/ref_mob = "[REF(M)]"
			return "<b>[key_name(C, link, name, highlight_special, ticket)](<A href='byond://?_src_=vars;Vars=[ref_mob]'>VV</A>)([admin_jump_link(M)])</b>"

		if(4)	//Mentors
			var/ref_mob = "[REF(M)]"
			return "<b>[key_name(C, link, name, highlight_special, ticket)] (<A href='byond://?_src_=holder;adminmoreinfo=[REF(M)]'>?</A>) (<A href='byond://?_src_=holder;adminplayeropts=[ref_mob]'>PP</A>) (<A href='byond://?_src_=vars;Vars=[ref_mob]'>VV</A>) (<A href='byond://?_src_=holder;subtlemessage=[ref_mob]'>SM</A>) ([admin_jump_link(M)])</b>"

//
//ALL DONE
//*********************************************************************************************************
//

//Returns 1 to let the dragdrop code know we are trapping this event
//Returns 0 if we don't plan to trap the event
/datum/admins/proc/cmd_ghost_drag(var/mob/abstract/ghost/observer/frommob, var/mob/living/tomob)
	if(!istype(frommob))
		return //Extra sanity check to make sure only observers are shoved into things

	//Same as assume-direct-control perm requirements.
	if (!check_rights(R_VAREDIT,0) || !check_rights(R_ADMIN|R_DEBUG|R_DEV,0))
		return 0
	if (!frommob.ckey)
		return 0
	var/question = ""
	if (tomob.ckey)
		question = "This mob already has a user ([tomob.key]) in control of it! "
	question += "Are you sure you want to place [frommob.name]([frommob.key]) in control of [tomob.name]?"
	var/ask = alert(question, "Place ghost in control of mob?", "Yes", "No")
	if (ask != "Yes")
		return 1
	if (!frommob || !tomob) //make sure the mobs don't go away while we waited for a response
		return 1
	if(tomob.client) //No need to ghostize if there is no client
		tomob.ghostize(0)
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] has put [frommob.ckey] in control of [tomob.name].</span>")
	log_admin("[key_name(usr)] stuffed [frommob.ckey] into [tomob.name].")
	feedback_add_details("admin_verb","CGD")
	tomob.ckey = frommob.ckey
	tomob.client.init_verbs()
	qdel(frommob)
	return 1

/datum/admins/proc/force_antag_latespawn()
	set category = "Admin"
	set name = "Force Template Spawn"
	set desc = "Force an antagonist template to spawn."

	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		to_chat(usr, "Error: you are not an admin!")
		return

	if(!SSticker.mode)
		to_chat(usr, "Mode has not started.")
		return

	var/antag_type = tgui_input_list(usr, "Choose a template.", "Force Latespawn", GLOB.all_antag_types)
	if(!antag_type || !GLOB.all_antag_types[antag_type])
		to_chat(usr, "Aborting.")
		return

	var/datum/antagonist/antag = GLOB.all_antag_types[antag_type]
	message_admins("[key_name(usr)] attempting to force latespawn with template [antag.id].")
	antag.attempt_auto_spawn()

/datum/admins/proc/force_mode_latespawn()
	set category = "Admin"
	set name = "Force Mode Spawn"
	set desc = "Force autotraitor to proc."

	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins) || !check_rights(R_ADMIN))
		to_chat(usr, "Error: you are not an admin!")
		return

	if(!SSticker || !SSticker.mode)
		to_chat(usr, "Mode has not started.")
		return

	log_and_message_admins("attempting to force mode autospawn.")
	SSticker.mode.process_autoantag()

/datum/admins/proc/paralyze_mob(mob/living/H as mob)
	set category = "Admin"
	set name = "Toggle Wind"
	set desc = "Paralyzes a player. Or unparalyses them."

	toggle_wind_paralysis(H, usr)

/proc/toggle_wind_paralysis(var/mob/living/target, var/mob/user)
	var/msg
	if(check_rights(R_ADMIN|R_MOD, user))
		if (target.paralysis == 0)
			msg = "has paralyzed [key_name_admin(target)]."
			target.visible_message("<font color='#002eb8'><b>OOC Information:</b></font> <span class='warning'>[target] has been winded by a member of staff! Please freeze all roleplay involving their character until the matter is resolved! Adminhelp if you have further questions.</span>", SPAN_WARNING("<b>You have been winded by a member of staff! Please stand by until they contact you!</b>"))
			target.paralysis = 8000
		else
			if (alert(user, "The player is currently winded. Do you want to unwind him?", "Unwind player?", "Yes", "No") == "No")
				return
			target.paralysis = 0
			msg = "has unparalyzed [key_name_admin(target)]."
			target.visible_message("<font color='#002eb8'><b>OOC Information:</b></font> <font color='green'>[target] has been unwinded by a member of staff!</font>", SPAN_WARNING("<b>You have been unwinded by a member of staff!</b>"))
		log_and_message_admins(msg, user)
		feedback_add_details("admin_verb", "WIND")

/datum/admins/proc/toggle_round_spookyness()
	set category = "Server"
	set desc="Toggle the round spooky value."
	set name="Toggle Round Spookyness"

	enabled_spooking = !enabled_spooking
	log_admin("[key_name(usr)] toggled the round spookyness to [enabled_spooking].")
	message_admins("[key_name_admin(usr)] toggled the round spookyness [enabled_spooking ? "on" : "off"].", 1)
	feedback_add_details("admin_verb","SPOOKY") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/ccannoucment()
	set category = "Special Verbs"
	set name = "Custom sound Command Announcment"
	set desc = "Emulate announcement that looks and sounds like the real one."
	if(!check_rights(R_FUN))
		return

	var/title = tgui_input_text(usr, "Input the announcement's title.", "Custom Announcement")
	if(!title)
		return
	if(!check_rights(R_SERVER,0))
		title = sanitize(title, 255, extra = 0)
	var/message = tgui_input_text("Input the announcement's content.", "CAnnounce", multiline = TRUE)
	if(!message)
		return
	if(!check_rights(R_SERVER,0))
		message = sanitize(message, 500, extra = 0)


	var/list/sounds = file2list('sound/serversound_list.txt');
	sounds += "--CANCEL--"
	sounds += "--LOCAL--"
	sounds += GLOB.sounds_cache

	var/melody = tgui_input_list(usr, "Select a sound from the server to play.", "Sound Selection", sounds)

	if(melody == "--CANCEL--")
		return
	if(melody == "--LOCAL--")
		melody = input("Select a sound to play", "Sound select") as sound
		if(!melody)
			return

	command_announcement.Announce(message, title, new_sound = melody)
	log_and_message_admins("made custom announcement with custom sound", usr)
	feedback_add_details("admin_verb","ACS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/atom/proc/Admin_Coordinates_Readable(area_name, admin_jump_ref)
	var/turf/T = get_turf(src)
	return T ? "[area_name ? "[get_area_name(T, TRUE)] " : " "]([T.x],[T.y],[T.z])[admin_jump_ref ? " [ADMIN_JMP(T)]" : ""]" : "nonexistent location"

/**
 * Used to manually set an Odyssey for the Odyssey gamemode.
 */

/datum/admins/proc/set_odyssey()
	set name = "Set Odyssey Type"
	set category = "Special Verbs"

	if(!check_rights(R_ADMIN))
		return

	if(!SSticker.mode || !istype(SSticker.mode, /datum/game_mode/odyssey))
		to_chat(usr, SPAN_WARNING("The gamemode either does not exist, or is not Odyssey."))
		return

	if(SSticker.current_state != GAME_STATE_SETTING_UP)
		to_chat(usr, SPAN_WARNING("You need to use this verb while the game is still setting up!"))
		return

	var/list/singleton/scenario/all_scenarios = GET_SINGLETON_SUBTYPE_LIST(/singleton/scenario)
	var/list/possible_scenarios = list()
	for(var/singleton/scenario/S in all_scenarios)
		possible_scenarios[S.name] = S

	var/singleton/scenario/chosen_scenario
	var/situation_name = tgui_input_list(usr, "Choose an Odyssey.", "Set Odyssey", possible_scenarios)
	chosen_scenario = possible_scenarios[situation_name]

	if(!chosen_scenario)
		return

	if(!(SSatlas.current_sector.name in chosen_scenario.sector_whitelist))
		if(tgui_alert(usr, "This Odyssey is not appropriate for the current sector. Continue?", "Set Odyssey", list("Yes", "No")) != "Yes")
			return

	SSodyssey.scenario = chosen_scenario
	log_and_message_admins("has manually set the Odyssey to [chosen_scenario.name]", usr)
	feedback_add_details("admin_verb","SEST") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


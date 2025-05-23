/datum/ai_emotion
	var/overlay
	var/ckey

/datum/ai_emotion/New(var/over, var/key)
	overlay = over
	ckey = key

GLOBAL_LIST_INIT(ai_status_emotions, list(
	"Very Happy" 				= new /datum/ai_emotion("ai_veryhappy"),
	"Happy" 					= new /datum/ai_emotion("ai_happy"),
	"Neutral" 					= new /datum/ai_emotion("ai_neutral"),
	"Unsure" 					= new /datum/ai_emotion("ai_unsure"),
	"Confused" 					= new /datum/ai_emotion("ai_confused"),
	"Sad" 						= new /datum/ai_emotion("ai_sad"),
	"Surprised" 				= new /datum/ai_emotion("ai_surprised"),
	"Upset" 					= new /datum/ai_emotion("ai_upset"),
	"Angry" 					= new /datum/ai_emotion("ai_angry"),
	"BSOD" 						= new /datum/ai_emotion("ai_bsod"),
	"Blank" 					= new /datum/ai_emotion("ai_off"),
	"Problems?" 				= new /datum/ai_emotion("ai_trollface"),
	"Awesome" 					= new /datum/ai_emotion("ai_awesome"),
	"Dorfy" 					= new /datum/ai_emotion("ai_urist"),
	"Facepalm" 					= new /datum/ai_emotion("ai_facepalm"),
	"Friend Computer" 			= new /datum/ai_emotion("ai_friend"),
	"Diagnostics"				= new /datum/ai_emotion("ai_diagnostics"),
	"Tribunal" 					= new /datum/ai_emotion("ai_tribunal", "serithi"),
	"Tribunal Malfunctioning"	= new /datum/ai_emotion("ai_tribunal_malf", "serithi")
	))

/proc/get_ai_emotions(var/ckey)
	var/list/emotions = new
	for(var/emotion_name in GLOB.ai_status_emotions)
		var/datum/ai_emotion/emotion = GLOB.ai_status_emotions[emotion_name]
		if(!emotion.ckey || emotion.ckey == ckey)
			emotions += emotion_name

	return emotions

/proc/set_ai_status_displays(mob/user as mob)
	var/emote = get_ai_emotion(user)
	for (var/obj/machinery/M in SSmachinery.all_status_displays) //change status
		if(istype(M, /obj/machinery/ai_status_display))
			var/obj/machinery/ai_status_display/AISD = M
			AISD.emotion = emote
			AISD.update()
		//if Friend Computer, change ALL displays
		else if(istype(M, /obj/machinery/status_display))

			var/obj/machinery/status_display/SD = M
			if(emote=="Friend Computer")
				SD.friendc = 1
			else
				SD.friendc = 0

/obj/machinery/ai_status_display
	icon = 'icons/obj/status_display.dmi'
	icon_state = "frame"
	name = "AI display"
	anchored = 1
	density = 0

	var/mode = 0	// 0 = Blank
					// 1 = AI emoticon
					// 2 = Blue screen of death

	var/picture_state	// icon_state of ai picture

	var/emotion = "Neutral"

/obj/machinery/ai_status_display/Initialize()
	. = ..()
	SSmachinery.all_status_displays += src

/obj/machinery/ai_status_display/Destroy()
	SSmachinery.all_status_displays -= src
	return ..()

/obj/machinery/ai_status_display/attack_ai(mob/user as mob)
	if(!ai_can_interact(user))
		return
	var/emote = get_ai_emotion(user)
	src.emotion = emote
	src.update()

/proc/get_ai_emotion(mob/user as mob)
	return input(user, "Please, select a status!", "AI Status", null) in get_ai_emotions(user.ckey)

/obj/machinery/ai_status_display/proc/update()
	switch (mode)
		if (0)	// Blank
			ClearOverlays()

		if (1)	// AI emoticon
			var/datum/ai_emotion/ai_emotion = GLOB.ai_status_emotions[emotion]
			set_picture(ai_emotion.overlay)

		if (2)	// BSOD
			set_picture("ai_bsod")

/obj/machinery/ai_status_display/proc/set_picture(var/state)
	picture_state = state
	ClearOverlays()
	AddOverlays(picture_state)

/obj/machinery/ai_status_display/power_change()
	..()
	if(stat & NOPOWER)
		ClearOverlays()
	else
		update()

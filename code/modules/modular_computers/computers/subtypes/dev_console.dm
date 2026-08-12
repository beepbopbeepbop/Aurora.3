/obj/item/modular_computer/console
	name = "console"
	desc = "A stationary computer."
	icon = 'icons/obj/modular_computers/modular_console.dmi'
	icon_state = "computer"
	icon_state_unpowered = "computer"
	icon_state_screensaver = "standby"
	icon_state_screensaver_key = "black_key"
	icon_state_menu = "menu"
	icon_state_broken = "computer-broken"
	menu_light_color = LIGHT_COLOR_WHITE
	hardware_flag = PROGRAM_CONSOLE
	anchored = TRUE
	density = TRUE
	layer = ABOVE_STRUCTURE_LAYER
	message_output_range = 1
	base_idle_power_usage = 100
	base_active_power_usage = 500
	max_hardware_size = 3
	steel_sheet_cost = 20
	light_range = 2
	screensaver_light_range = 1.4
	screensaver_light_color = LIGHT_COLOR_WHITE
	is_holographic = TRUE
	pass_flags_self = PASSTABLE

/obj/item/modular_computer/console/update_icon()
	. = ..()
	if(dir == SOUTH)
		layer = ABOVE_HUMAN_LAYER

/obj/item/modular_computer/console/terminal
	name = "terminal"
	icon = 'icons/obj/modular_computers/modular_terminal.dmi'
	icon_state = "computer"
	icon_state_unpowered = "computer"
	icon_state_screensaver = null
	icon_state_screensaver_key = "generic_key_off"
	icon_state_menu = "generic"
	icon_state_menu_key = "generic_key"
	icon_state_broken = "computer-broken"
	screensaver_light_range = 0
	screensaver_light_color = null
	is_holographic = FALSE

/datum/map_template/ruin/away_site/sol_consulate
	name = "Sol Consulate"
	description = "sol_consulate"

	prefix = "away_site/sol_consulate/"
	suffix = "sol_consulate.dmm"

	traits = list(
		//Z1
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = TRUE, ZTRAIT_DOWN = FALSE),
		//Z2
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = TRUE, ZTRAIT_DOWN = TRUE),
		//Z3
		list(ZTRAIT_AWAY = TRUE, ZTRAIT_UP = FALSE, ZTRAIT_DOWN = TRUE)
	)

	sectors = list(SECTOR_SRANDMARR)
	spawn_weight = 1
	spawn_cost = 1
	id = "sol_consulate"

	unit_test_groups = list(2)

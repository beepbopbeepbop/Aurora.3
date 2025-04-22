/datum/ghostspawner/human/sol_consulate/support_staff
	name = "Sol Consulate Support Staff"
	short_name = "support_staff"
	desc = "sol gov worker."
	tags = list("External")

	spawnpoints = list("support_staff")
	max_count = 2

	outfit = /obj/outfit/admin/sol_consulate/support_staff
	possible_species = list(SPECIES_HUMAN)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Sol Consulate Support Staff"
	special_role = "Sol Consulate Support Staff"
	respawn_flag = null

/obj/outfit/admin/sol_consulate/support_staff
	name = "Sol Consulate Support Staff"
	uniform = /obj/item/clothing/under/rank/sol/
	gloves = /obj/item/clothing/gloves/black
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack/industrial
	head = /obj/item/clothing/head/sol
	id = /obj/item/card/id/white
	accessory = /obj/item/clothing/accessory/holster/hip
	l_ear = /obj/item/device/radio/headset/ship
	backpack_contents = list(/obj/item/storage/box/survival = 1, /obj/item/melee/energy/sword/knife/sol = 1)

/obj/outfit/admin/sol_consulate/get_id_access()
	return list(ACCESS_SOL_CONSULATE, ACCESS_EXTERNAL_AIRLOCKS)

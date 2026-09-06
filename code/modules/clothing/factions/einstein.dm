// Uniforms
/obj/item/clothing/under/rank/einstein
	name = "\improper Einstein Engines uniform"
	desc = "A standardized uniform used by Einstein Engines personnel."
	icon = 'icons/obj/item/clothing/under/human/corporation/einstein.dmi'
	icon_state = "einstein"
	item_state = "einstein"
	worn_state = "einstein"
	siemens_coefficient = 0.75
	permeability_coefficient = 0.75
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	contained_sprite = TRUE
	species_restricted = list(
		"exclude",
			BODYTYPE_UNATHI,
			BODYTYPE_TAJARA,
			BODYTYPE_VAURCA_BREEDER,
			BODYTYPE_VAURCA_WARFORM,
			BODYTYPE_VAURCA_BULWARK,
			BODYTYPE_TESLA_BODY)

/obj/item/clothing/under/rank/einstein/uniform
	name = "\improper Einstein Engines corporate uniform"
	desc = "A standardized uniform worn by non-specialist Einstein Engines personnel."
	desc_extended = "Worn by everyone from office workers on Luna to the crewmen of EE’s corporate fleet, the humble \
	Type I uniform is a ubiquitous sight in the Company. An incredible amount of engineering (and money) have gone \
	into these suits - as per Einstein’s strict guidelines, they are counter-microbial, anti-static, stain-resistant, \
	breathable, and comfortable."
	icon_state = "einstein_uniform"
	item_state = "einstein_uniform"
	worn_state = "einstein_uniform"

/obj/item/clothing/under/rank/einstein/synth
	name = "\improper Einstein Engines synthetic utility coveralls"
	desc = "A standardized uniform worn by Einstein Engines Synthetics in non-public-facing roles. The acronym \"EES\" \
	is emblazoned on the chest and upper back."
	desc_extended = "Light as air, electrically insulated, and specially fitted to ensure surgical, microelectronic, or \
	what-have-you precision, this expensive multipurpose synthetic worker's outfit feels like wearing a breeze! Synthetics \
	intended to be seen by outsiders to the corporation are likely to wear more conventional clothing instead."
	icon_state = "einstein_synth"
	item_state = "einstein_synth"
	worn_state = "einstein_synth"
	siemens_coefficient = 0.50
	permeability_coefficient = 0.50
	armor = list(
		MELEE = ARMOR_MELEE_SMALL,
		BULLET = ARMOR_BALLISTIC_MINOR,
		LASER = ARMOR_LASER_MINOR,
		BIO = ARMOR_BIO_MINOR,
		RAD = ARMOR_RAD_MINOR
	)

/obj/item/clothing/under/rank/einstein/bodyglove
	name = "\improper Einstein Engines sterile bodyglove"
	desc = "A sterile bodysuit worn by Einstein Engines medical and research personnel."
	desc_extended = "Designed and produced to incredibly strict specifications by Einstein’s internal design department, \
	the form-fitting Type II uniform is capable of resisting biothreats, toxic compounds, and any other hazardous materials \
	one might encounter in a lab environment. Comes with sealed connection plugs over the arms and spine providing access to \
	interface ports without the risk of cross-contamination."
	icon_state = "einstein_bodysuit"
	item_state = "einstein_bodysuit"
	worn_state = "einstein_bodysuit"
	permeability_coefficient = 0.50
	armor = list(
		BIO = ARMOR_BIO_MINOR
	)


/obj/item/clothing/under/rank/einstein/coveralls
	name = "\improper Einstein Engines field coveralls"
	desc = "A durable boiler suit worn by Einstein Engines personnel working in adverse conditions."
	desc_extended = "Woven from high-durability, triple-reinforced fibers, the Type III uniform is meant for use in field \
	conditions. Although lacking in the sleek, flashy polymeric materials heavily used in other EE uniforms, the T-III is \
	partially fire-retardant, cut and puncture resistant, and features integrated padding on the knees and elbows to prevent \
	the development of joint disorders. It is well-loved by employees for its many, many spacious pockets and for being a cozy wear."
	icon_state = "einstein_coveralls"
	item_state = "einstein_coveralls"
	worn_state = "einstein_coveralls"
	siemens_coefficient = 0.50
	armor = list(
		MELEE = ARMOR_MELEE_SMALL,
		BULLET = ARMOR_BALLISTIC_MINOR,
		LASER = ARMOR_LASER_MINOR,
		BIO = ARMOR_BIO_MINOR,
		RAD = ARMOR_RAD_MINOR
	)

/obj/item/clothing/under/rank/einstein/management
	name = "\improper Einstein Engines management uniform"
	desc = "A formal work uniform and half-sash worn by Einstein command personnel."
	desc_extended = "A Type-I office uniform with added corporate rank tabs and stylish half-sash, meant to represent a \
	labcoat - symbolizing Einstein's humble beginnings as a think tank and their meritocratic structure. To earn the command \
	sash is the mark of a committed, competent employee that has rose to the top of the corporate ladder and earned the \
	respect of their peers. The design was designed on contract by the Aspirants (TM) designer brand in collaboration with \
	Einstein Engines."
	icon_state = "einstein_management"
	item_state = "einstein_management"
	worn_state = "einstein_management"
	armor = list(
		BIO = ARMOR_BIO_MINOR
	)

/obj/item/clothing/under/rank/einstein/executive
	name = "\improper Einstein Engines executive suit"
	desc = "A formal corporate uniform worn by high-ranking Einstein executives and officials."
	desc_extended = "The Type-IV uniform was designed entirely as a commissioned project by the Aspirants for wear by \
	Einstein executives, liaisons, and high-ranking officials. Sleek and stylish, it combines the practicality of other EE \
	uniforms through a myriad of hidden features and the unmistakable style of Idris's designer brand. The design of the coat \
	bears a striking resemblance to the 2415 The Aspirants Winter Catalogue's Venusian Exec-Fit Solaire Synthleather Trenchcoat."
	icon_state = "einstein_executive"
	item_state = "einstein_executive"
	worn_state = "einstein_executive"
	siemens_coefficient = 0.9
	permeability_coefficient = 0.9

// Footwear
/obj/item/clothing/shoes/einstein/shoes
	name = "\improper Einstein Engines corporate shoes"
	desc = "A pair of treated shoes for safety around patients. Resistant to chemical and gas spills."
	icon = 'icons/obj/item/clothing/shoes/sneakers.dmi'
	icon_state = "einstein_shoes"
	item_state = "einstein_shoes"
	contained_sprite = TRUE
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	armor = list(
		BIO = ARMOR_BIO_RESISTANT
	)
	species_restricted = list(
		"exclude",
			BODYTYPE_UNATHI,
			BODYTYPE_TAJARA,
			BODYTYPE_VAURCA_BREEDER,
			BODYTYPE_VAURCA_WARFORM,
			BODYTYPE_VAURCA_BULWARK,
			BODYTYPE_TESLA_BODY)

/obj/item/clothing/shoes/einstein/tactical_boots
	name = "\improper Einstein Engines tactical boots"
	desc = "Tall synthleather boots with an artificial shine."
	icon = 'icons/obj/item/clothing/shoes/boots.dmi'
	icon_state = "einstein_boots_tactical"
	item_state = "einstein_boots_tactical"
	contained_sprite = TRUE
	siemens_coefficient = 0.75
	can_hold_knife = TRUE
	drop_sound = 'sound/items/drop/boots.ogg'
	pickup_sound = 'sound/items/pickup/boots.ogg'
	armor = list(
		MELEE = ARMOR_MELEE_KNIVES,
		ENERGY = ARMOR_ENERGY_MINOR,
		BOMB = ARMOR_BOMB_MINOR
	)
	species_restricted = list(
		"exclude",
			BODYTYPE_UNATHI,
			BODYTYPE_TAJARA,
			BODYTYPE_VAURCA_BREEDER,
			BODYTYPE_VAURCA_WARFORM,
			BODYTYPE_VAURCA_BULWARK,
			BODYTYPE_TESLA_BODY
	)

// Gloves
/obj/item/clothing/gloves/einstein/tactical
	name = "\improper Einstein Engines tactical gloves"
	desc = "A pair of khaki tactical gloves with reinforcement at the knuckles and an adjustable strap at the wrist. Designed for use by the TCAF's Republic Espatiers and Home Defence Forces."
	icon = 'icons/obj/item/clothing/gloves/einstein_gloves.dmi'
	icon_state = "einstein_gloves_tactical"
	item_state = "einstein_gloves_tactical"
	contained_sprite = TRUE
	worn_overlay = "over"
	siemens_coefficient = 0
	species_restricted = list(
		"exclude",
			BODYTYPE_UNATHI,
			BODYTYPE_TAJARA,
			BODYTYPE_VAURCA_BREEDER,
			BODYTYPE_VAURCA_WARFORM,
			BODYTYPE_VAURCA_BULWARK,
			BODYTYPE_TESLA_BODY
	)

// Hats
/obj/item/clothing/head/einstein/kepi
	name = "Einstein Engines corporate kepi"
	desc = "A baseball cap worn by Einstein Engines employees. Wear on head for best results."
	desc_extended = "It may just be a baseball cap, but we all know berets are for people who don't do real work, like human resources \
	employees or Zeng-Hu's ethnics department."
	icon = 'icons/obj/item/clothing/head/einstein_hats.dmi'
	icon_state = "einstein_kepi"
	item_state = "einstein_kepi"
	contained_sprite = TRUE

/obj/item/clothing/head/einstein/peaked_cap
	name = "Einstein Engines corporate peaked cap"
	desc = "A peaked cap in Einstein Engines colors. For showing your subordinates who's in charge around here."
	desc_extended = "And you? Is it an honour to work with you? Don't ask him, ask yourself."
	icon = 'icons/obj/item/clothing/head/einstein_hats.dmi'
	icon_state = "einstein_peaked_cap"
	item_state = "einstein_peaked_cap"
	contained_sprite = TRUE

/obj/item/clothing/head/einstein/beret
	name = "\improper Einstein Engines corporate beret"
	desc = "A beret in Einstein Engines colors. Wear on head for best results."
	desc_extended = "EE's beret is, allegedly, based loosely on the Solarian Army's standard beret for non-Soviet-affiliated units, \
	setting it apart from Zavodskoi Interstellar and Idris Incorporated."
	icon = 'icons/obj/item/clothing/head/einstein_hats.dmi'
	icon_state = "einstein_beret"
	item_state = "einstein_beret"
	contained_sprite = TRUE

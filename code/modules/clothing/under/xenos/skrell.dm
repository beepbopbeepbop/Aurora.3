/obj/item/clothing/under/skrell
	name = "federation uniform"
	desc = "The uniform worn by official Nralakk Federation representatives and diplomats. It looks waterproof."
	icon = 'icons/obj/item/clothing/under/skrell/federation_uniform.dmi'
	icon_state = "skrell_formal"
	item_state = "skrell_formal"
	contained_sprite = TRUE

/obj/item/clothing/under/skrell/qeblak
	name = "qeblak ceremonial garment"
	desc = "A traditional garment worn by Qeblak Star Keepers"
	icon = 'icons/obj/item/clothing/under/skrell/qeblak_uniform.dmi'
	icon_state = "qeblak_uniform"
	item_state = "qeblak_uniform"
	action_button_name = "Toggle Ceremonial Garment Lights"
	var/lights = FALSE

/obj/item/clothing/under/skrell/qeblak/update_icon()
	..()
	if(lights)
		item_state = "[initial(icon_state)]_on"
	else
		item_state = initial(item_state)

/obj/item/clothing/under/skrell/qeblak/attack_self(mob/user)
	toggle_lights()

/obj/item/clothing/under/skrell/qeblak/verb/toggle_lights()
	set name = "Toggle Ceremonial Garment Lights"
	set category = "Object.Equipped"
	set src in usr

	if (use_check_and_message(usr))
		return

	lights = !lights

	if(lights)
		set_light(2)
	else
		set_light(0)

	update_icon()
	usr.update_inv_w_uniform()

/obj/item/clothing/under/skrell/slugger
	name = "prescient republic of the qar wetsuit"
	desc = "A wetsuit worn by members of Prescient Republic of the Qar generational fleet."
	icon = 'icons/obj/item/clothing/under/skrell/slugger_wetsuit.dmi'
	item_state = "slugger_wetsuit"
	icon_state = "slugger_wetsuit"

/obj/item/clothing/under/skrell/wetsuit
	name = "casual wetsuit"
	desc = "A wetsuit made as standard apparel for skrell, and functions as underclothes for non-hydrophobic apparel. Acceptable to wear on its own, or as a base for other clothing worn atop it."
	icon = 'icons/obj/item/clothing/under/skrell/wetsuit.dmi'
	icon_state = "wetsuit"
	item_state = "wetsuit"
	has_accents = TRUE

/obj/item/clothing/under/skrell/wetsuit/dark
	name = "casual wetsuit"
	desc = "A wetsuit made as standard apparel for skrell, and functions as underclothes for non-hydrophobic apparel. Acceptable to wear on its own, or as a base for other clothing worn atop it. This set is darker, for easier accessorizing."
	icon_state = "wetsuit_dark"
	item_state = "wetsuit_dark"
	has_accents = TRUE

/obj/item/clothing/under/skrell/wetsuit/swimsuit
	name = "casual swimsuit"
	desc = "A wetsuit made as standard apparel for skrell. This one is stylized after human swimwear, and is more popular among the younger generations. This swimsuit is Nioh'wan, or 'full-moon', and covers as much as the usual wetsuit would, without the pantlegs or sleeves."
	desc_extended = "Adopting human swimwear styles, modern swimsuit-style wetsuits have levels of stylization and showiness referred to by the phases of the moon. Nioh'wan, or 'full moon', covers as much as a wetsuit would usually, but lacks pantlegs. Nioh'miki, or 'half moon', cuts down further to mimic the appearance of human one-piece swimsuit. Nioh'waji, or 'crescent moon', has portions of the swimsuit with the fabric removed to further stylize itself, while Nioh'riri, or 'new moon', is essentially a two-piece swimsuit."
	icon_state = "swim"
	item_state = "swim"
	has_accents = TRUE

/obj/item/clothing/under/skrell/wetsuit/swimsuit/alt
	name = "casual swimsuit"
	desc = "A wetsuit made as standard apparel for skrell. This one is stylized after human swimwear, and is more popular among the younger generations. These swimsuits have varying levels of stylization."
	icon_state = "swim_alt"
	item_state = "swim_alt"
	has_accents = TRUE

/obj/item/clothing/under/skrell/wetsuit/swimstars
	name = "swimstars swimsuit"
	desc = "A wetsuit made as standard apparel for skrell. This one is stylized after human swimwear, and is more popular among the younger generations. These swimsuits are stylized after the original styles of the skrell characters from the animated series Swimstars, which have since caught on with younger skrell to the point of being officially produced."
	icon_state = "swimstars"
	item_state = "swimstars"

/obj/item/clothing/under/skrell/wetsuit/swimstars/alt
	name = "swimstars swimsuit"
	desc = "A wetsuit made as standard apparel for skrell. This one is stylized after human swimwear, and is more popular among the younger generations. These swimsuits are stylized after the original styles of the skrell characters from the animated series Swimstars, which have since caught on with younger skrell to the point of being officially produced."
	icon_state = "swimstars_alt"
	item_state = "swimstars_alt"

// Kala Uniforms
/obj/item/clothing/under/skrell/cthur
	name = "cthur uniform"
	desc = "This white vaurca wetsuit is often worn by C’thur working with the Kala, most often the Qukala. It has ablative materials woven in."
	icon = 'icons/obj/item/clothing/under/skrell/cthur_uniform.dmi'
	icon_state = "cthur_uniform"
	item_state = "cthur_uniform"
	contained_sprite = TRUE
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(
		LASER = ARMOR_LASER_SMALL
	)
	species_restricted = list(BODYTYPE_VAURCA)

/obj/item/clothing/under/skrell/kala
	icon = 'icons/obj/item/clothing/under/skrell/nralakk_uniforms.dmi'
	contained_sprite = TRUE

/obj/item/clothing/under/skrell/kala/council_enforcer
	name = "wukala fatigues"
	desc = "A rare set of purple fatigues worn by uniformed Wukala council enforcers, or more rarely by the cadres of Qu'Wukala Grand Council enforcers. It has small kinetic dampeners woven in."
	desc_extended = "Independent of the Nralakk Federation's security community, the Wuqrnjeqkala, shortened to Wukala (and translating to Council Enforcers), \
	are planetary council-appointed Kala who enforce disciplinary action at the discretion of the councillors they are assigned to. \
	The Qu'Wuqrnjeqkala, shortened to Qu'Wukala (and translating to Grand Council Enforcers), are the personal agents of the Grand Councilor \
	and the Grand Council's highest members. Qu'Wukala operatives are tasked with providing the security details for their assigned wards, \
	council members, protection of the Nralakk Federation's secure assets, and the completion of any requested tasks from the Grand Council itself."
	icon_state = "council_uniform"
	item_state = "council_uniform"
	armor = list(
		MELEE = ARMOR_MELEE_SMALL,
		BULLET = ARMOR_BALLISTIC_MINOR,
		LASER = ARMOR_LASER_MINOR
	)
	siemens_coefficient = 0.7

/obj/item/clothing/under/skrell/kala/defence_enforcer
	name = "kala combat fatigues"
	desc = "A set of heavy combat fatigues worn by the voidbound Qukala defence enforcers. It has small kinetic dampeners woven in."
	desc_extended = "The Qukala, or Star Enforcers, make up the Defence Section and are organised unlike their sibling Kala, where their various \
	ship departments maintain senior Lead Enforcers who form a council structure to command their given vessel without a designated captain. \
	Unlike other navies who operate a permanent fleet structure, each Qukala vessel is subordinate to the Defence Section itself, which may \
	organise patrol groups and temporary task forces as needed."
	icon_state = "defence_uniform"
	item_state = "defence_uniform"
	armor = list(
		MELEE = ARMOR_MELEE_SMALL,
		BULLET = ARMOR_BALLISTIC_MINOR,
		LASER = ARMOR_LASER_MINOR
	)
	siemens_coefficient = 0.7

/obj/item/clothing/under/skrell/kala/foreign_ops_enforcer
	name = "kala tactical fatigues"
	desc = "A set of lightweight tactical fatigues occasionally worn by the Tupkala covert operatives. It has small kinetic dampeners woven in."
	desc_extended = "Charged with maintaining networks of undercover operatives in foreign national organisations, and assassinations—though \
	no assassination attempt has ever been confirmed to have been approved by the Nralakk Federation—are the Tupkala, or Covert Enforcers. \
	This position at the forefront of skrell security has made the Foreign Operations component of the NFDES a highly desirable position for \
	well-performing citizens, and is a valuable pathway towards a successful political career."
	icon_state = "foreign_ops_uniform"
	item_state = "foreign_ops_uniform"
	armor = list(
		MELEE = ARMOR_MELEE_SMALL,
		BULLET = ARMOR_BALLISTIC_MINOR,
		LASER = ARMOR_LASER_MINOR
	)
	siemens_coefficient = 0.7

/obj/item/clothing/under/skrell/kala/security_enforcer
	name = "kala coveralls"
	desc = "A simple, utilitarian uniform commonly worn by the Qekala security enforcers, but seen in all branches. It has small kinetic dampeners woven in."
	desc_extended = "The Qekala, or Home Enforcers, are the fist of the Federation's security apparatus in skrell space. \
	Only a fourth of the NFDIS is made up of Qekala operatives, who are responsible for general policework. \
	The Qekala's regular operations include regular patroles, providing security presence, warrant execution, and emergency response. \
	Aspiring Qekala members are placed under rigorous scrutiny, testing athletic ability, legal knowledge, \
	and general capability to respond with correct force and procedure. Qekala members are expected to operate amphibiously \
	in multiple environments across the myriad planets of the Nralakk Federation."
	icon_state = "enforcement_uniform"
	item_state = "enforcement_uniform"
	armor = list(
		MELEE = ARMOR_MELEE_SMALL,
		BULLET = ARMOR_BALLISTIC_MINOR,
		LASER = ARMOR_LASER_MINOR
	)

/obj/item/clothing/under/skrell/kala/surveillance_enforcer
	name = "kala wetsuit"
	desc = "A comfortable wetsuit worn by internal Nlomkala surveillance analysts, external Ruupkala intelligence operatives, or any other Kala enforcers who primarily work from a desk. Designed for long cycles in the office."
	desc_extended = "The Nlomkala, or Wake Enforcers, are the eyes and ears of the Federation are found at every level of society, \
	to the point of being (erroneously) remarked by non-Federation citizens that every electronic appliance is outfitted with hidden cameras \
	feeding directly to the Nlomkala. In reality, the pervasive surveillance in the Federation is an open, accepted part of life to feed information \
	to the Social Compatibility Index, and ensure the Federation's economy continues to operate. \
	The Ruupkala, or Intelligence Enforcers, handle the intelligence gathering, counter-intelligence, \
	and monitoring of skrell outside of the Federation (both citizen and not)."
	icon_state = "surveillance_uniform"
	item_state = "surveillance_uniform"

// Work Uniforms
// Ox clothing
/obj/item/clothing/under/skrell/nralakk
	name = "Ox research uniform"
	desc = "A plain, utilitarian jumpsuit that signifies the wearer as a Tertiary Numerical working in a scientific field."
	desc_extended = "The Nralakk Federation ranks its workers based on their social compatibility index, and provides workwear based on said index: Ox are those who are within the Tertiary Numerical band, and are provided with the bare essentials for adequate clothes. Tertiary Numericals are typically criminals, or Skrell who otherwise do not conform to the standards of Nralakk Society."
	icon = 'icons/obj/item/clothing/under/skrell/nralakk_uniforms.dmi'
	sprite_sheets = list(
		BODYTYPE_VAURCA_BULWARK = 'icons/obj/item/clothing/under/vaurca/bulwark/nralakk_uniforms.dmi'
	)
	item_state = "ox_sci"
	icon_state = "ox_sci"

/obj/item/clothing/under/skrell/nralakk/ox
	name = "Ox bridge and security uniform"
	desc = "A plain, utilitarian jumpsuit that signifies the wearer as a Tertiary Numerical working in the security service or as pilots or bridge crew."
	item_state = "ox_sec"
	icon_state = "ox_sec"

/obj/item/clothing/under/skrell/nralakk/ox/engineer
	name = "Ox engineering and maintenance uniform"
	desc = "A plain, utilitarian jumpsuit that signifies the wearer as a Tertiary Numerical working in the engineering industry or in maintenance."
	item_state = "ox_engi"
	icon_state = "ox_engi"

/obj/item/clothing/under/skrell/nralakk/ox/service
	name = "Ox mailing and service uniform"
	desc = "A plain, utilitarian jumpsuit that signifies the wearer as a Tertiary Numerical working in the mail service or hospitality industries."
	item_state = "ox_cargo"
	icon_state = "ox_cargo"

/obj/item/clothing/under/skrell/nralakk/ox/med
	name = "Ox healthcare uniform"
	desc = "A plain, utilitarian jumpsuit that signifies the wearer as a Tertiary Numerical in the healthcare industry."
	item_state = "ox_med"
	icon_state = "ox_med"

// Ix clothing
/obj/item/clothing/under/skrell/nralakk/ix
	name = "Ix research uniform"
	desc = "A plain jumpsuit that signifies the wearer as a low-indexed Secondary Numerical working in a scientific field."
	desc_extended = "The Nralakk Federation ranks its workers based on their social compatibility index, and provides workwear based on said index: Ix are those who are low-ranked Secondary Numericals with their clothes typically being plain, yet still considered pleasant to wear and be seen in. Secondary Numericals are the majority population in the Nralakk Federation, with Ix being those who are in the lower end of the band. "
	item_state = "ix_sci"
	icon_state = "ix_sci"

/obj/item/clothing/under/skrell/nralakk/ix/security
	name = "Ix bridge and security uniform"
	desc = "A plain jumpsuit that signifies the wearer as a low-indexed Secondary Numerical working in the security service or as pilots or bridge crew."
	item_state = "ix_sec"
	icon_state = "ix_sec"

/obj/item/clothing/under/skrell/nralakk/ix/engineer
	name = "Ix engineering and maintenance uniform"
	desc = "A plain jumpsuit that signifies the wearer as a low-indexed Secondary Numerical in the engineering industry or in maintenance."
	item_state = "ix_engi"
	icon_state = "ix_engi"

/obj/item/clothing/under/skrell/nralakk/ix/service
	name = "Ix mailing and service uniform"
	desc = "A plain jumpsuit that signifies the wearer as a low-indexed Secondary Numerical in the mail service or hospitality industries."
	item_state = "ix_cargo"
	icon_state = "ix_cargo"

/obj/item/clothing/under/skrell/nralakk/ix/med
	name = "Ix healthcare uniform"
	desc = "A plain jumpsuit that signifies the wearer as a low-indexed Secondary Numerical in the healthcare industry."
	item_state = "ix_med"
	icon_state = "ix_med"

// Oqi clothing
/obj/item/clothing/under/skrell/nralakk/oqi
	name = "Oqi research uniform"
	desc = "A more fashionable jumpsuit that signifies the wearer as either a high-indexed Secondary Numerical or low-indexed Primary Numerical in a scientific field."
	desc_extended = "The Nralakk Federation ranks its workers based on their social compatibility index, and provides workwear based on said index: Oqi are high-ibdexed Secondary Numericals or low-indexed Primary Numericals, with their workwear generally having more accessories that help them work in their specific industry. Skrell who are Oqi are typically more fashion-conscious, making it not uncommon to see these uniforms altered slightly to account for the latest fashion trends in the Nralakk Federation."
	item_state = "oqi_sci"
	icon_state = "oqi_sci"

/obj/item/clothing/under/skrell/nralakk/oqi/security
	name = "Oqi bridge and security uniform"
	desc = "A more fashionable jumpsuit that signifies the wearer as either a high-indexed Secondary Numerical or low-indexed Primary Numerical in the security service or as pilots or bridge crew."
	item_state = "oqi_sec"
	icon_state = "oqi_sec"

/obj/item/clothing/under/skrell/nralakk/oqi/engineer
	name = "Oqi engineering and maintenance uniform"
	desc = "A more fashionable jumpsuit that signifies the wearer as either a high-indexed Secondary Numerical or low-indexed Primary Numerical in the engineering industry or in maintenance."
	item_state = "oqi_engi"
	icon_state = "oqi_engi"

/obj/item/clothing/under/skrell/nralakk/oqi/service
	name = "Oqi mailing and service uniform"
	desc = "A more fashionable jumpsuit that signifies the wearer as either a high-indexed Secondary Numerical or low-indexed Primary Numerical in the mail service or hospitality industries."
	item_state = "oqi_cargo"
	icon_state = "oqi_cargo"

/obj/item/clothing/under/skrell/nralakk/oqi/med
	name = "Oqi healthcare uniform"
	desc = "A more fashionable jumpsuit that signifies the wearer as either a high-indexed Secondary Numerical or low-indexed Primary Numerical in the healthcare industry."
	item_state = "oqi_med"
	icon_state = "oqi_med"

// Iqi clothing
/obj/item/clothing/under/skrell/nralakk/iqi
	name = "Iqi research uniform"
	desc = "A very fashionable jumpsuit that signifies the wearer as a high-indexed Primary Numerical in a scientific field."
	desc_extended = "The Nralakk Federation ranks its workers based on their social compatibility index, and provides workwear based on said index: Iqi are high-indexed Primary Numericals, and as such their workwear is of the highest quality afforded by the Federation. These clothes are typically made of sturdier materials and are more comfortable to wear. Primary Numericals are typically seen as the trend-setters in Federation society, and Skrell who are ranked at Iqi are known to influence fashion through how they accessorise."
	item_state = "iqi_sci"
	icon_state = "iqi_sci"

/obj/item/clothing/under/skrell/nralakk/iqi/security
	name = "Iqi bridge and security uniform"
	desc = "A very fashionable jumpsuit that signifies the wearer as a high-indexed Primary Numerical in the security service or as pilots or bridge crew."
	item_state = "iqi_sec"
	icon_state = "iqi_sec"

/obj/item/clothing/under/skrell/nralakk/iqi/engineer
	name = "Iqi engineering and maintenance uniform"
	desc = "A very fashionable jumpsuit that signifies the wearer as a high-indexed Primary Numerical in the engineering industry or in maintenance."
	item_state = "iqi_engi"
	icon_state = "iqi_engi"

/obj/item/clothing/under/skrell/nralakk/iqi/service
	name = "Iqi mailing and service uniform"
	desc = "A very fashionable jumpsuit that signifies the wearer as a high-indexed Primary Numerical in the mail service or hospitality industries."
	item_state = "iqi_cargo"
	icon_state = "iqi_cargo"

/obj/item/clothing/under/skrell/nralakk/iqi/med
	name = "Iqi healthcare uniform"
	desc = "A very fashionable jumpsuit that signifies the wearer as a high-indexed Primary Numerical in the healthcare industry."
	item_state = "iqi_med"
	icon_state = "iqi_med"

// Shirts
ABSTRACT_TYPE(/obj/item/clothing/under/dressshirt/skrell)
	desc = "A formal wetshirt in Skrell style."
	icon = 'icons/obj/item/clothing/under/shirt/skrell_casual.dmi'

/obj/item/clothing/under/dressshirt/skrell/ocean
	name = "ocean formal wetshirt"
	desc = "This wetshirt is meant to resemble the waves of Qerrbalak's homeworld. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "ocean_dressshirt"
	item_state = "ocean_dressshirt"

/obj/item/clothing/under/dressshirt/skrell/maelstrom
	name = "maelstrom formal wetshirt"
	desc = "This ferocious wetshirt resembles that of a maelstrom; a common occurance on Skrell planets. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "maelstrom_dressshirt"
	item_state = "maelstrom_dressshirt"

/obj/item/clothing/under/dressshirt/skrell/reef
	name = "reef formal wetshirt"
	desc = "This slightly tacky wetshirt resembles the coral reefs found throughout Nralakk space. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "reef_dressshirt"
	item_state = "reef_dressshirt"

ABSTRACT_TYPE(/obj/item/clothing/under/dressshirt/tshirt/skrell)
	icon = 'icons/obj/item/clothing/under/shirt/skrell_casual.dmi'
	desc = "A wetshirt in Skrell style."

/obj/item/clothing/under/dressshirt/tshirt/skrell/ocean
	name = "ocean wetshirt"
	desc = "This wetshirt is meant to resemble the waves of Qerrbalak's homeworld. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "ocean_tee"
	item_state = "ocean_tee"

/obj/item/clothing/under/dressshirt/tshirt/skrell/maelstrom
	name = "maelstrom wetshirt"
	desc = "This ferocious wetshirt resembles that of a maelstrom; a common occurance on Skrell planets. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "maelstrom_tee"
	item_state = "maelstrom_tee"

/obj/item/clothing/under/dressshirt/tshirt/skrell/reef
	name = "reef wetshirt"
	desc = "This slightly tacky wetshirt resembles the coral reefs found throughout Nralakk space. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "reef_tee"
	item_state = "reef_tee"

/obj/item/clothing/under/dressshirt/tshirt/skrell/nebula
	name = "pink eriuyushi nebula shirt"
	desc = "This shirt resembles the designs of Silversun tourist clothing. Most of these shirts are made in Eriuyushi and sold at their resort. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "pink_skrell_hawaiian"
	item_state = "pink_skrell_hawaiian"

/obj/item/clothing/under/dressshirt/tshirt/skrell/nebula/purple
	name = "purple eriuyushi nebula shirt"
	desc = "This shirt resembles the designs of Silversun tourist clothing. Most of these shirts are made in Eriuyushi and sold at their resort. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "purple_skrell_hawaiian"
	item_state = "purple_skrell_hawaiian"

/obj/item/clothing/under/dressshirt/tshirt/skrell/nebula/teal
	name = "teal eriuyushi nebula shirt"
	desc = "This shirt resembles the designs of Silversun tourist clothing. Most of these shirts are made in Eriuyushi and sold at their resort. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "teal_skrell_hawaiian"
	item_state = "teal_skrell_hawaiian"

/obj/item/clothing/under/dressshirt/tshirt/skrell/nebula/black
	name = "black eriuyushi nebula shirt"
	desc = "This shirt resembles the designs of Silversun tourist clothing. Most of these shirts are made in Eriuyushi and sold at their resort. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "black_skrell_hawaiian"
	item_state = "black_skrell_hawaiian"

/obj/item/clothing/under/dressshirt/tshirt/skrell/nebula/white
	name = "white eriuyushi nebula shirt"
	desc = "This shirt resembles the designs of Silversun tourist clothing. Most of these shirts are made in Eriuyushi and sold at their resort. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "white_skrell_hawaiian"
	item_state = "white_skrell_hawaiian"

/obj/item/clothing/under/dressshirt/tshirt/skrell/nebula/nralakk
	name = "nralakk eriuyushi nebula shirt"
	desc = "This shirt resembles the designs of Silversun tourist clothing. Most of these shirts are made in Eriuyushi and sold at their resort. This clothing is meant to trap moisture, making it uncomfortable for non-Skrell."
	icon_state = "nralakk_skrell_hawaiian"
	item_state = "nralakk_skrell_hawaiian"

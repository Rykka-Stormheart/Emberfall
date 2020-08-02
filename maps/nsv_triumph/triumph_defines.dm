
//Turfmakers
#define TRIUMPH_SET_ATMOS	initial_gas_mix = ATMOSPHERE_ID_TRIUMPH
#define TRIUMPH_TURF_CREATE(x)	x/triumph/initial_gas_mix = ATMOSPHERE_ID_TRIUMPH;x/triumph/outdoors=TRUE;x/triumph/allow_gas_overlays = FALSE
#define TRIUMPH_TURF_CREATE_UN(x)	x/triumph/initial_gas_mix=ATMOSPHERE_ID_TRIUMPH

//Normal map defs
#define Z_LEVEL_DECK_ONE					1
#define Z_LEVEL_DECK_TWO					2
#define Z_LEVEL_DECK_THREE					3
#define Z_LEVEL_DECK_FOUR					4
#define Z_LEVEL_CENTCOM						5
#define Z_LEVEL_MISC						6
#define Z_LEVEL_SHIPS						7

//Camera networks
#define NETWORK_TRIUMPH "Triumph"
#define NETWORK_TCOMMS "Telecommunications" //Using different from Polaris one for better name
#define NETWORK_OUTSIDE "Outside"
#define NETWORK_EXPLORATION "Exploration"
#define NETWORK_XENOBIO "Xenobiology"

/datum/map/triumph
	name = "Triumph"
	full_name = "NSV Triumph"
	path = "triumph"

	zlevel_datum_type = /datum/map_z_level/triumph

	lobby_icon = 'icons/misc/title_vr.dmi'
	lobby_screens = list("title1", "title2", "title3", "title4", "title5", "title6", "title7")
	id_hud_icons = 'icons/mob/hud_jobs_vr.dmi' //CITADEL CHANGE: Ignore this line because it's going to be overriden in modular_citadel\maps\tether\tether_defines.dm

	holomap_smoosh = list(list(
		Z_LEVEL_DECK_ONE,
		Z_LEVEL_DECK_TWO,
		Z_LEVEL_DECK_THREE,
		Z_LEVEL_DECK_FOUR))

	station_name  = "NSV Triumph"
	station_short = "Triumph"
	dock_name     = "NDV Marksman"
	dock_type     = "space"
	boss_name     = "Central Command"
	boss_short    = "CentCom"
	company_name  = "NanoTrasen"
	company_short = "NT"
	starsys_name  = "Sigmar Concord"

	shuttle_docked_message = "This is the %dock_name% calling to the %station_name%. A shift transfer is commencing for crew that need to depart. The transfer shuttle will arrive in %ETD%. %dock_name% out."
	shuttle_leaving_dock = "The transfer shuttle has left the ship. Estimate %ETA% until the shuttle arrives at the %dock_name%."
	shuttle_called_message = "A scheduled crew transfer to the %dock_name% is occuring. The tram shuttle be arriving shortly. Those departing should proceed to the shuttlke bay within %ETA%."
	shuttle_recall_message = "The scheduled crew transfer has been cancelled."
	shuttle_name = "Crew Hands Transfer"
	emergency_shuttle_docked_message = "The evacuation shuttle has arrived at the tram station. You have approximately %ETD% to board the shuttle."
	emergency_shuttle_leaving_dock = "The emergency shuttle has left the station. Estimate %ETA% until the shuttle arrives at %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation has begun, and an off-schedule shuttle has been called. It will arrive at the tram station in approximately %ETA%."
	emergency_shuttle_recall_message = "The evacuation shuttle has been recalled."

	station_networks = list(
							NETWORK_CARGO,
							NETWORK_CIRCUITS,
							NETWORK_CIVILIAN,
							NETWORK_COMMAND,
							NETWORK_ENGINE,
							NETWORK_ENGINEERING,
							NETWORK_EXPLORATION,
							//NETWORK_DEFAULT,  //Is this even used for anything? Robots show up here, but they show up in ROBOTS network too,
							NETWORK_MEDICAL,
							NETWORK_MINE,
							NETWORK_OUTSIDE,
							NETWORK_RESEARCH,
							NETWORK_RESEARCH_OUTPOST,
							NETWORK_ROBOTS,
							NETWORK_SECURITY,
							NETWORK_TCOMMS,
							NETWORK_TRIUMPH
							)
	secondary_networks = list(
							NETWORK_ERT,
							NETWORK_MERCENARY,
							NETWORK_THUNDER,
							NETWORK_COMMUNICATORS,
							NETWORK_ALARM_ATMOS,
							NETWORK_ALARM_POWER,
							NETWORK_ALARM_FIRE
							)

	bot_patrolling = FALSE

	allowed_spawns = list("Shuttle Dock","Gateway","Cryogenic Storage","Cyborg Storage")
	spawnpoint_died = /datum/spawnpoint/shuttle
	spawnpoint_left = /datum/spawnpoint/shuttle
	spawnpoint_stayed = /datum/spawnpoint/cryo

	meteor_strike_areas = list(/area/triumph/surfacebase/outside/outside3)

	unit_test_exempt_areas = list(
		/area/triumph/surfacebase/outside/outside1,
		/area/vacant/vacant_site,
		/area/vacant/vacant_site/east,
		/area/crew_quarters/sleep/Dorm_1/holo,
		/area/crew_quarters/sleep/Dorm_3/holo,
		/area/crew_quarters/sleep/Dorm_5/holo,
		/area/crew_quarters/sleep/Dorm_7/holo)
	unit_test_exempt_from_atmos = list(
		/area/engineering/atmos/intake, // Outside,
		/area/rnd/external, //  Outside,
		/area/triumph/surfacebase/mining_main/external, // Outside,
		/area/triumph/surfacebase/mining_main/airlock, //  Its an airlock,
		/area/triumph/surfacebase/emergency_storage/rnd,
		/area/triumph/surfacebase/emergency_storage/atrium)

	lateload_z_levels = list(
		list("Triumph - Misc","Triumph - Ships",), //Stock Tether lateload maps
	)

	ai_shell_restricted = TRUE
	ai_shell_allowed_levels = list(
		Z_LEVEL_DECK_ONE,
		Z_LEVEL_DECK_TWO,
		Z_LEVEL_DECK_THREE,
		Z_LEVEL_DECK_FOUR)

	lateload_single_pick = null //Nothing right now.
/*
/datum/map/tether/perform_map_generation()

	new /datum/random_map/automata/cave_system/no_cracks(null, 1, 1, Z_LEVEL_SURFACE_MINE, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_SURFACE_MINE, 64, 64)         // Create the mining ore distribution map.

	new /datum/random_map/automata/cave_system/no_cracks(null, 1, 1, Z_LEVEL_SOLARS, world.maxx, world.maxy) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null, 1, 1, Z_LEVEL_SOLARS, 64, 64)         // Create the mining ore distribution map.

	return 1

/datum/planet/virgo3b
	expected_z_levels = list(
		Z_LEVEL_SURFACE_LOW,
		Z_LEVEL_SURFACE_MID,
		Z_LEVEL_SURFACE_HIGH,
		Z_LEVEL_SURFACE_MINE,
		Z_LEVEL_SOLARS//,
		//Z_LEVEL_PLAINS
	)
*/
// Short range computers see only the main levels, others can see the surrounding surface levels.
/datum/map/tether/get_map_levels(var/srcz, var/long_range = TRUE)
	if (long_range && (srcz in map_levels))
		return map_levels
	else if (srcz == Z_LEVEL_SHIPS || srcz == Z_LEVEL_MISC)
		return list() //no longer return signals in key transit levels, this means some runtimes from CWCs but
	else if (srcz >= Z_LEVEL_DECK_ONE && srcz <= Z_LEVEL_DECK_FOUR)
		return list(
		Z_LEVEL_DECK_ONE,
		Z_LEVEL_DECK_TWO,
		Z_LEVEL_DECK_THREE,
		Z_LEVEL_DECK_FOUR)
	else
		return list(srcz) //may prevent runtimes, but more importantly gives gps units a shortwave-esque function

// For making the 6-in-1 holomap, we calculate some offsets
#define TETHER_MAP_SIZE 140 // Width and height of compiled in tether z levels.
#define TETHER_HOLOMAP_CENTER_GUTTER 40 // 40px central gutter between columns
#define TETHER_HOLOMAP_MARGIN_X ((HOLOMAP_ICON_SIZE - (2*TETHER_MAP_SIZE) - TETHER_HOLOMAP_CENTER_GUTTER) / 2) // 100
#define TETHER_HOLOMAP_MARGIN_Y ((HOLOMAP_ICON_SIZE - (3*TETHER_MAP_SIZE)) / 2) // 60

// We have a bunch of stuff common to the station z levels
/datum/map_z_level/triumph/ship
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_XENOARCH_EXEMPT
	holomap_legend_x = 220
	holomap_legend_y = 160

/datum/map_z_level/triumph/ship/deck_one
	z = Z_LEVEL_DECK_ONE
	name = "Deck 1"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_XENOARCH_EXEMPT
	holomap_offset_x = TETHER_HOLOMAP_MARGIN_X
	holomap_offset_y = TETHER_HOLOMAP_MARGIN_Y + TETHER_MAP_SIZE*0

/datum/map_z_level/triumph/ship/deck_two
	z = Z_LEVEL_DECK_TWO
	name = "Deck 2"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_XENOARCH_EXEMPT
	holomap_offset_x = TETHER_HOLOMAP_MARGIN_X
	holomap_offset_y = TETHER_HOLOMAP_MARGIN_Y + TETHER_MAP_SIZE*0

/datum/map_z_level/triumph/ship/deck_three
	z = Z_LEVEL_DECK_THREE
	name = "Deck 3"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_XENOARCH_EXEMPT
	holomap_offset_x = TETHER_HOLOMAP_MARGIN_X
	holomap_offset_y = TETHER_HOLOMAP_MARGIN_Y + TETHER_MAP_SIZE*0

/datum/map_z_level/triumph/ship/deck_four
	z = Z_LEVEL_DECK_FOUR
	name = "Deck 4"
	flags = MAP_LEVEL_STATION|MAP_LEVEL_CONTACT|MAP_LEVEL_PLAYER|MAP_LEVEL_CONSOLES|MAP_LEVEL_SEALED|MAP_LEVEL_XENOARCH_EXEMPT
	holomap_offset_x = TETHER_HOLOMAP_MARGIN_X
	holomap_offset_y = TETHER_HOLOMAP_MARGIN_Y + TETHER_MAP_SIZE*0

/datum/map_z_level/triumph/colony
	z = Z_LEVEL_CENTCOM
	name = "Flagship"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_CONTACT|MAP_LEVEL_XENOARCH_EXEMPT

/datum/map_z_level/triumph/ships
	z = Z_LEVEL_SHIPS
	name = "Misc"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_XENOARCH_EXEMPT

/datum/map_z_level/triumph/misc
	z = Z_LEVEL_MISC
	name = "Misc"
	flags = MAP_LEVEL_ADMIN|MAP_LEVEL_XENOARCH_EXEMPT

// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: briefing.sqf

if (!hasInterface) exitWith {};

_trimName = { _this select [1, count _this - 2] };
_aKeyName = { _arr = actionKeysNamesArray _this; if (count _arr == 0) exitWith {"<UNDEFINED>"}; _arr select 0 };

#define NKEYNAME(DIK) (keyName DIK call _trimName)
#define AKEYNAME(ACT) (ACT call _aKeyName)

waitUntil {!isNull player};

player createDiarySubject ["infos", "Infos and Help"];
player createDiarySubject ["changelog", "Changelog"];
player createDiarySubject ["credits", "Credits"];

player createDiarySubject ["customupdate", "Lucky's Wasteland"];
player createDiaryRecord ["customupdate",
[
"Custom Update Build 14",
"
<br/>[Updated] Wasteland official
<br/>[Added] New item in general Store
<br/>[Added] Demining mission
<br/>[Added] Airdrop system from APOC
<br/>[Added] Beacon detector
<br/>[Added] Titan Static mountable to offroad and Truck
<br/>[Added] 'Tree Cutter' for allow helicopter take off
<br/>[Added] Defend territory mission
<br/>[Added] Containers and objects from Apex DLC
<br/>[Added] Transfer ownership action
<br/>[Added] New category in general store
<br/>[Added] Sell object in every store
<br/>[Added] Surrender feature - `Shift + H`
<br/>[Added] Info page for shortcut key
<br/>[Added] welcome message
<br/>[Added] Artillery Computer restricted area
<br/>[Added] Texture for Mohawk
<br/>[Added] Item filter for Gun Store and General Store
<br/>[Added] Altis Has Fallen mission
<br/>[Added] Beacon rename feature and repair feature
<br/>[Added] Map usage for Remote designator
<br/>[Adjusted] Limit on ATM now up to 2mil
<br/>[Adjusted] refillbox to balance the game
<br/>[Adjusted] Price on vehicle store
<br/>[Adjusted] Transfer to box max direction
<br/>[Adjusted] Default clothing
<br/>[Adjusted] view distance range from 8500 to 10000
<br/>[Adjusted] Mission config
<br/>[Adjusted] Mission line for custom distance
<br/>[Adjusted] Thermal for few equitment
<br/>[Retextured] Vehicle texture for digital green, wooldland and multicam
<br/>[Retextured] AAF and OPFOR vehicle paint
<br/>[Modifed] Vehicle textures
<br/>[Modified] Tailhook prefix
<br/>[Modified] Territory name
<br/>[Modified] Corpse missing problem
<br/>[Enabled] Warchest
<br/>[Moved] water mission to New Water mission
<br/>[Removed] Unused texture
<br/>[Improved] Gun store direct load magazine to weapon
<br/>[Improved] UAV issue, could be exist in server
<br/>[Improved] R3F Helicopter lift
<br/>[Improved] Vehicle get out for turn off engine
<br/>[Improved] Heal soldier problem
<br/>[Improved] R3F object move
<br/>[Improved] Help hint
<br/>[Improved] Human target scoreboard problem
<br/>[Improved] Weapon swap issue
<br/>[Improved] R3F object select
<br/>[Improved] UAV take control
<br/>[Improved] Revive message
<br/>[Fixed] Thermal on vorona
<br/>[Fixed] Admin tool
<br/>[Fixed] Mission abandoned jet
<br/>[Fixed] Sell and Repaint on turret
<br/>[Fixed] Resupply crate
<br/>[Fixed] Uninstall cargo problem
<br/>[Fixed] player will not get damage from installed vehicle
<br/>[Fixed] Eject corpse script
<br/>[Fixed] Park Plane instead of Park Vehicle
<br/>[Fixed] Land convoy path
<br/>[Fixed] Boat spawn position
<br/>[Fixed] Condition and action text
<br/>[Fixed] Duplicated R3F action
<br/>[Fixed] Scoreboard reset
<br/>[Fixed] Take uniform problem
<br/>[Fixed] Handgun magazine missing
<br/>[Fixed] Sell vehicle problem
<br/>[Fixed] Create unit
<br/>[Fixed] Animation stuck on unconscious
<br/>[Fixed] Block artillery restricted zone on store location
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 13",
"
<br/>[Added] Carry action for unconcious player
<br/>[Added] 'transfer to box' action for dead body in underwater
<br/>[Added] Icon for hostage action
<br/>[Added] Box into config for helicopter lift object
<br/>[Added] Tailhook action for every aircraft, result with able to land on aircraft carrier
<br/>[Added] Backpack lock feature
<br/>[Added] Missions include Airdrop, Delivery Supply, Anti Air and Medevac
<br/>[Added] Tougher tank
<br/>[Added] Textures for Blufor APC with AAF and Hex style
<br/>[Added] Texture for hunter, hellcat and wipeout
<br/>[Added] Transport anti-air also support
<br/>[Added] Basic item to general store
<br/>[Added] More object to general store
<br/>[Added] Get in as cargo for apex and helicopter DLCs
<br/>[Added] Take uniform from other side
<br/>[Added] Destroyer at Pyrgos gulf
<br/>[Added] Unarmed vehicle
<br/>[Added] Feature to destroy vehicle after get bottom of sea
<br/>[Added] Tailhook for UAV
<br/>[Added] Resupply truck marker on map
<br/>[Added] Install handler at vehicle damaged
<br/>[Added] Resupply object in general store
<br/>[Fixed] Medkit problem for helping player
<br/>[Fixed] Unflip problem with destoryed vehicle
<br/>[Fixed] Admin tool
<br/>[Fixed] Parking spawn problem
<br/>[Fixed] teleport problem
<br/>[Fixed] weapon and magazine loadout on vehicle resupply
<br/>[Fixed] Thermal problem
<br/>[Fixed] Transfer to box missing items
<br/>[Fixed] R3F uav control problem
<br/>[Fixed] Admin tool
<br/>[Fixed] AA radar problem on spawn
<br/>[Improved] Player icon depends on speed and helicopter/plane, the faster of speed, the farther player fetch
<br/>[Improved] Portal for better coding
<br/>[Improved] R3F addon
<br/>[Improved] Suicide vest no longer gone after armed
<br/>[Improved] General store purchasing function
<br/>[Improved] Store action
<br/>[Adjusted] Helicopter minimum paradrop from 40m to 25m
<br/>[Adjusted] Marker size for custom made stuff
<br/>[Adjusted] Planes loadout for balancing plane between side
<br/>[Adjusted] Random soldier spawn for random side
<br/>[Adjusted] police group from AA to AT
<br/>[Adjusted] Mission config
<br/>[Adjusted] Planes loadout for balancing plane between side
<br/>[Adjusted] Helicopter loadout
<br/>[Adjusted] Inventory limit
<br/>[Adjusted] Vehicle store tax for aircraft carrier
<br/>[Adjusted] Price of vehicle in vehicle store
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 12",
"
<br/>[Removed] All required Mod
<br/>[Fixed] Far revive addon
<br/>[Fixed] Parking marker problem
<br/>[Fixed] Suicide Vest still valid to detonate when unconscious
<br/>[Adjusted] Hostile Jet Cash spawn
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 11",
"
<br/>[Added] HVT - High Value Target for carry 150k, refresh time is 30 seconds
<br/>[Added] Items Strap-on Bomb and Defibrillator
<br/>[Added] Civilians cloth in general store
<br/>[Added] Mission Rescue War Crime, Rescue Hostage and Miller's Truck
<br/>[Fixed] Vehicle light on driver assist
<br/>[Fixed] Mission variable
<br/>[Fixed] Server restart message
<br/>[Adjusted] Parking lot in airport for plane only
<br/>[Adjusted] Small territory boost
<br/>[Adjusted] Mission config
<br/>[Adjusted] Player start up gear
<br/>[Adjusted] Mission AI loadout
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 10",
"
<br/>[Added] Parking in airport
<br/>[Added] Small territory boost
<br/>[Added] Mission - Miller's Truck
<br/>[Replaced] Restart message
<br/>[Adjusted] Few small problem for vehicle
<br/>[Adjusted] Server properties wreck, corpse and respawn
<br/>[Adjusted] Mission config
<br/>[Adjusted] Mission AI loadout
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 9",
"
<br/>[Added] More objects in general store
<br/>[Removed] Driver assist lights control
<br/>[Reduced] size of vehicle texture
<br/>[Adjusted] Forbidden items for refill box
<br/>[Adjusted] Connection to uav terminal after dead
<br/>[Adjusted] Mission config
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 8",
"
<br/>[Added] New ATM
<br/>[Fixed] Admin panel problem
<br/>[Fixed] Indi able to teleport with portal
<br/>[Fixed] Portal small problem
<br/>[Adjusted] Mission config
<br/>[Adjusted] description message
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 7",
"
<br/>[Added] Compass gui
<br/>[Added] More type of crates for mission
<br/>[Added] Portal system which can teleport from town to territory
<br/>[Added] few feature for driver assist
<br/>[Added] Admin tool
<br/>[Adjusted] Mission config
<br/>[Adjusted] Default cloth and weapon on spawn
<br/>[Adjusted] Parking with crate will left crate outside
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 6",
"
<br/>[Added] Texture for hemtt fuel and fuel truck
<br/>[Fixed] Restart server message
<br/>[Adjusted] Map object for few things
<br/>[Adjusted] Artillery strike
<br/>[Adjusted] Object spawn on store
<br/>[Adjusted] Territory payroll
<br/>[Adjusted] Mission config
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 5",
"
<br/>[Added] Server restart message
<br/>[Fixed] Resupply for anti-air turret
<br/>[Fixed] Spawn error on carrier
<br/>[Adjusted] Territory payroll
<br/>[Adjusted] Mission config
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 4",
"
<br/>[Added] Custom tax/discount based on each vehicle store
<br/>[Fixed] Resupply function for anti-air turret
<br/>[Fixed] Deploy beacon in water/sea
<br/>[Fixed] packable vehicle problem
<br/>[Fixed] Boat option in vehicle store
<br/>[Adjusted] Thermal on UAV and vehicles
<br/>[Adjusted] Push vehicle extend distance from 2.5 to 4
<br/>[Adjusted] List of selling crate content
<br/>[Adjusted] Moonlight is back on night, visible see at night
<br/>[Adjusted] Longer night time
<br/>[Adjusted] Mission config
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 3",
"
<br/>[Added] More gear on general store
<br/>[Removed] Holster weapon option in swimming
<br/>[Removed] Admin tool - Virtual Arsenal and Virtual Garage
<br/>[Fixed] Admin tool - teleport and tpmeto and tptome and unstuck player
<br/>[Fixed] Vehicle not spawn on vehicle store
<br/>[Adjusted] Flat grass move to front of player
<br/>[Adjusted] General store item and gear will not replace after purchase
<br/>[Adjusted] Vehicle store with Anti air and Gun store with Sniper
<br/>[Adjusted] View distance set to 8500m
<br/>[Adjusted] Mission config
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 2",
"
<br/>[Added] Territories and towns
<br/>[Added] Gun store, general store, vehicle store and atm
<br/>[Added] Import military mission from LouD
<br/>[Added] Mission convoy path
<br/>[Added] More admin tool
<br/>[Fixed] Parking system (profile -> extDB)
<br/>[Fixed] Quadbike and waterscooter pack if damaged
<br/>[Adjusted] Remove fog for good
<br/>[Adjusted] Default config
"
]];

player createDiaryRecord ["customupdate",
[
"Custom Update Build 1",
"
<br/>[Added] Flatten Grass
<br/>[Added] Deployable quad bike
<br/>[Added] Deployable water scooter
"
]];

player createDiaryRecord ["changelog",
[
"v1.4d",
"
<br/>[Added] ADR-97 SMG
<br/>[Added] Paint vehicle option at stores
<br/>[Added] Weapon filter for gunstore accessories
<br/>[Added] Territory capture warning icons on map
<br/>[Fixed] UAVs retrieved from parking are unconnectable
<br/>[Fixed] Other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.4c",
"
<br/>[Added] Tanks DLC
<br/>[Added] 3rd column in vehicle store for parts
<br/>[Added] AA jet variants
<br/>[Added] HE cannons to gun-only jets
<br/>[Added] Smoke launchers to tank driver and gunner seats
<br/>[Changed] All hidden vehicle paintjobs now available
<br/>[Changed] Improved crate and supply truck loot
<br/>[Changed] Some store prices
<br/>[Fixed] Mortar resupply bugs
<br/>[Fixed] Selling of laser designators
<br/>[Fixed] More money exploits
<br/>[Fixed] Other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.4b",
"
<br/>[Added] Artillery Strike in random mission crates
<br/>[Added] Player body marker
<br/>[Added] Diving gear to purchased RHIB, Speedboat, SDV
<br/>[Added] SDAR turret to SDV gunner
<br/>[Added] Object loading capacity to SDV
<br/>[Added] Tac-Ops DLC Police Van and Gorgon skins
<br/>[Added] Apex DLC laser designator skins
<br/>[Added] Saving of 'Autonomous' option for UAVs
<br/>[Changed] Private storage space 4 times bigger
<br/>[Changed] Allow towing of locked personal vehicles
<br/>[Changed] Allow boat purchase on dry land
<br/>[Changed] Disabled slingloading of locked vehicles
<br/>[Changed] UAVs now sellable
<br/>[Changed] Improved kill attribution
<br/>[Fixed] Resupply error for static weapons
<br/>[Fixed] Ejection of injured units
<br/>[Fixed] Static designator ownership saving
<br/>[Fixed] Saving of stashed uniform contents and weapon items
<br/>[Fixed] Disappearing parked vehicles
<br/>[Fixed] Annoying switch to rocket launcher on revive
<br/>[Fixed] Drowned on dry land
<br/>[Fixed] Camo nets not saving
<br/>[Fixed] Many minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.4",
"
<br/>[Added] Laws of War DLC
<br/>[Added] Killfeed HUD
<br/>[Changed] Improved revive system
<br/>[Changed] Improved kill attribution
<br/>[Changed] Improved antihack
<br/>[Fixed] Prone reload freeze
<br/>[Fixed] Many minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3c",
"
<br/>[Added] Jets DLC
<br/>[Added] Aircraft carrier on Stratis
<br/>[Added] Resupply trucks on Altis and Stratis
<br/>[Added] Driver assist
<br/>[Changed] Aircraft prices
<br/>[Changed] Blocked explosives near parking and storage
<br/>[Changed] Migrated saving system from extDB2 to extDB3
<br/>[Fixed] Fast revive exploits
<br/>[Fixed] Could perform your duty after being revived
<br/>[Fixed] Other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3b",
"
<br/>[Added] Private parking
<br/>[Added] Private storage
<br/>[Added] Vehicle ownership
<br/>[Added] Vehicle locking
<br/>[Added] Vehicle selling
<br/>[Added] Mine saving
<br/>[Added] Resupply trucks
<br/>[Added] CH View Distance
<br/>[Added] Map legend
<br/>[Added] UAV side persistence
<br/>[Added] headless server cleanup
<br/>[Changed] Static designators now available to indies
<br/>[Changed] Some store prices
<br/>[Fixed] Many other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3",
"
<br/>[Added] Tanoa version
<br/>[Added] Apex content on dev/preview branches
<br/>[Added] Sticky explosive charges
<br/>[Added] Heavy towing and airlifting
<br/>[Added] Load dragged injured friendly in vehicles
<br/>[Added] Eject loaded injured friendly from vehicles
<br/>[Added] Autostabilize when loaded in medical vehicle
<br/>[Added] 'Finish off' action to slay injured enemies
<br/>[Added] Improved injured unit detection
<br/>[Added] Scoreboard persistence option for servers
<br/>[Added] Fatal PvP headshots option for servers
<br/>[Added] Custom death messages option for servers
<br/>[ADded] Auto-center heli turret on manual fire
<br/>[Added] UAV side persistence
<br/>[Added] More textures for some vehicles in store
<br/>[Added] Abandoned quadcopter cleanup
<br/>[Added] More admin menu logging
<br/>[Changed] Reduced heli missile damage
<br/>[Changed] Improved mission crate loot
<br/>[Changed] Vest armor values in general store
<br/>[Changed] Increased Mag Repack flexibility
<br/>[Changed] Toggled off autonomous on static designators
<br/>[Changed] Disabled rain due to weather desync
<br/>[Fixed] Engineer with toolkit can now always repair
<br/>[Fixed] Improved missile lock-on
<br/>[Fixed] Improvements to kill tracking system
<br/>[Fixed] Items and money not dropping on injured logout
<br/>[Fixed] Combat log timer not resetting on death
<br/>[Fixed] Player not always ejected on injury
<br/>[Fixed] Double kill/death count
<br/>[Fixed] Spawn cooldowns resetting on rejoin
<br/>[Fixed] Striders spawning without laser batteries
<br/>[Fixed] Disabled rain due to syncing issues
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.2b",
"
<br/>[Added] Scoreboard scrolling via mousewheel
<br/>[Added] New paintjobs for Kajman, Strider, Gorgon, Hatchback
<br/>[Changed] Hostile Heli (single) crates now spawn on touchdown
<br/>[Changed] Lowered Ifrit center of mass to reduce rollovers
<br/>[Changed] Updated antihack database
<br/>[Fixed] Saved grenades not throwable on rejoin
<br/>[Fixed] Corpses not ejecting from vehicle wrecks
<br/>[Fixed] Items not dropping from vehicle wreck corpses
<br/>[Fixed] Revive not triggering properly on fatal shot
<br/>[Fixed] Vehicle turret ammo saving issues
<br/>[Fixed] Too low damage resistance during revive mode
<br/>[Fixed] UGVs not airliftable via R3F
<br/>[Fixed] Revive broken after getting run over by vehicles
<br/>[Fixed] Veh respawn not being delayed when owner is within 1km
<br/>[Fixed] All armor values showing 0 in general store
<br/>[Fixed] Supplies category in general store sometimes empty
<br/>[Fixed] Server rules not showing anymore in map menu
<br/>[Fixed] Territory info overlapping with vehicle HUD
<br/>[Fixed] Vehicle contents selling money exploit
<br/>[Fixed] Antihack kicks not always working properly
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.2",
"
<br/>[Added] Mag Repack by Outlawled (Ctrl + " + NKEYNAME(19) + ")
<br/>[Added] Adjustable NV by xx-LSD-xx (Shift + PageUp/Down)
<br/>[Added] New vehicle store paintjobs
<br/>[Added] Town spawn cooldown
<br/>[Added] Ghosting timer
<br/>[Added] Object lock restriction near stores and missions
<br/>[Added] Headless client object saving
<br/>[Added] Time and weather saving
<br/>[Changed] Expanded UAV control restriction to quadcopters
<br/>[Changed] Injured players no longer count as town enemies
<br/>[Changed] Upgraded extDB to extDB2 by Torndeco
<br/>[Changed] Updated antihack
<br/>[Fixed] Old spawn beacons no longer shown on spawn menu
<br/>[Fixed] Multiple money duping exploits
<br/>[Fixed] Vehicles and objects sometimes disappearing from DB
<br/>[Fixed] Severe injuries caused by jumping over small ledges
<br/>[Fixed] Antihack kicks due to RHS, MCC, AGM, ACE3, ALiVE
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.1b",
"
<br/>[Added] Marksmen DLC content
<br/>[Added] Prevent usage of commander camera
<br/>[Added] Emergency eject hotkey (Ctrl + " + AKEYNAME("GetOut") + ")
<br/>[Added] Restricted UAV connection to owner's group
<br/>[Changed] Improved purchased vehicle setup time
<br/>[Changed] Admins can now use global voice chat
<br/>[Changed] Updated antihack
<br/>[Fixed] Corpses not being ejected from vehicles
<br/>[Fixed] Thermal imaging not working for UAVs
<br/>[Fixed] Various minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.1",
"
<br/>[Added] ATMs
<br/>[Added] Union Jack vehicle color
<br/>[Added] Skins hidden in gamefiles for MH-9, Mohawk, and Taru
<br/>[Added] Improved admin spectate camera by micovery
<br/>[Added] Earplugs (End key)
<br/>[Changed] Full rewrite of vehicle respawning system
<br/>[Fixed] Player moved to position too early during save restore
<br/>[Fixed] Mission timeout not extending on AI kill
<br/>[Fixed] Admin teamkill unlocking
<br/>[Fixed] Improved FPS fix
<br/>[Fixed] Running animation parachute glitch
<br/>[Fixed] Various other minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.0c",
"
<br/>[Added] MySQL support via extDB extension
<br/>[Added] Town Invasion mission
<br/>[Added] Chain-reaction player kill tracking
<br/>[Added] Force Save action for purchased and captured vehicles
<br/>[Added] Autokick players previously detected by antihack
<br/>[Added] Entity caching script for headless client
<br/>[Added] Tron suits to general store
<br/>[Added] Red lines on map for AIs wandering away from missions
<br/>[Changed] Mission timeout gets extended on AI kill
<br/>[Changed] Transport Heli mission Taru variant to Bench
<br/>[Changed] Spawn beacon item drop to sleeping bag
<br/>[Fixed] More money exploits
<br/>[Fixed] Scoreboard ordering
<br/>[Fixed] Vehicle repair and refuel sometimes not working
<br/>[Fixed] Injured players' corpses being deleted on disconnect
<br/>[Fixed] Static weapon disassembly prevention
<br/>[Fixed] Excess bought rockets ending up in uniform or vest
<br/>[Fixed] Various other minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v1.0b",
"
<br/>[Added] Helicopters DLC content
<br/>[Added] Revamped respawn menu
<br/>[Added] 250m altitude limit for territory capture
<br/>[Added] HALO insertion on spawn beacons
<br/>[Added] New vehicle store textures
<br/>[Changed] Increased damage done to planes by 50%
<br/>[Changed] Plane engines shutdown when above 90% damage
<br/>[Changed] Player names can also be toggled with Home key
<br/>[Changed] Increased ATGM UAV price
<br/>[Changed] Increased prices from thermal scopes again
<br/>[Changed] Minor edits to spawn loadouts
<br/>[Fixed] FPS drop that began in v0.9h
<br/>[Fixed] Saved UAVs not being connectable
<br/>[Fixed] Indies unable to get in UGVs
<br/>[Fixed] Blinking fog
<br/>[Fixed] Clipped numbers on scoreboard
<br/>[Fixed] Minor other optimizations and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.0",
"
<br/>[Added] Custom scoreboard
<br/>[Added] Mission and store vehicle saving
<br/>[Added] Player markers on GPS and UAV Terminal
<br/>[Added] Holster actions
<br/>[Changed] Full rewrite of side mission system
<br/>[Changed] Windows key toggles player marker names too
<br/>[Changed] New loading picture by Gameaholic.se
<br/>[Fixed] Weapon sometimes disppearing when moving objects
<br/>[Fixed] More money duping exploits
<br/>[Fixed] Store menu sizes on smaller aspect ratios
<br/>[Fixed] Hunger and thirst reset on rejoin
<br/>[Fixed] Other minor optimizations and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v0.9h",
"
<br/>[Added] Custom revive system based on Farooq's Revive
<br/>[Added] Territory payroll at regular intervals
<br/>[Added] Emergency eject and free parachutes (jump key)
<br/>[Added] Player names toggled with Windows key
<br/>[Added] Increased missile damage against tanks and helis
<br/>[Added] Ability to stash money in weapon crates
<br/>[Added] Ability to sell vehicle inventory at stores
<br/>[Added] More money shipment mission variants
<br/>[Added] Reduced wheel damage from collisions
<br/>[Added] Wreck salvaging
<br/>[Added] Selling bin in stores
<br/>[Added] Karts DLC content in stores
<br/>[Added] Camo sniper rifles in gunstore
<br/>[Added] Repair Offroad in vehicle store
<br/>[Added] Team players on map as server option
<br/>[Added] Unlimited stamina server option
<br/>[Added] Static weapon saving server option
<br/>[Added] More push vehicle actions
<br/>[Added] Paradrop option for airlifted vehicles
<br/>[Added] Preload checkbox on respawn menu
<br/>[Added] Remote explosives store distance restriction
<br/>[Added] Server time multipliers for day and night
<br/>[Added] Addon-less profileNamespace server persistence
<br/>[Added] Linux server compatibility
<br/>[Added] Basic support for headless client
<br/>[Changed] Independent territory capture is now group-based
<br/>[Changed] Towns blocked if more enemies than friendlies
<br/>[Changed] Increased ammo/fuel/repair cargo for resupply trucks
<br/>[Changed] Increased territory capture rewards for Altis
<br/>[Changed] Increased money mission rewards
<br/>[Changed] Weapon loot in buildings now disabled by default
<br/>[Changed] Mission crates loot was made more random
<br/>[Changed] Thermal imaging is now available on UAVs
<br/>[Changed] Increased vehicle store prices
<br/>[Changed] Increased prices for thermal optics
<br/>[Changed] Increased player icons up to 2000m
<br/>[Changed] Improved antihack
<br/>[Changed] Improved FPS
<br/>[Fixed] Vehicle store purchase errors due to server lag
<br/>[Fixed] Corpse created when leaving with player saving
<br/>[Fixed] Custom vehicle damage handling not working
<br/>[Fixed] Indie-indie spawn beacon stealing
<br/>[Fixed] Repair kit and jerrycan distance limit
<br/>[Fixed] Spawn beacon packing and stealing restrictions
<br/>[Fixed] Not able to lock static weapons
<br/>[Fixed] Unbreakable store windows
<br/>[Fixed] Stratis airbase gunstore desk glitches
<br/>[Fixed] Missions sometimes completing instantaneously
<br/>[Fixed] Object ammo/fuel/repair cargo not saving
<br/>[Fixed] Respawn menu aspect ratio on some resolutions
<br/>[Fixed] Minor bugs with group system
<br/>[Fixed] Minor bugs with player items
<br/>[Fixed] Various other minor bugfixes and optimizations
"
]];

player createDiaryRecord ["changelog",
[
"v0.9g",
"
<br/>[Added] - Vehicle stores
<br/>[Added] - New lootspawner by Na_Palm, stuff in ALL buildings
<br/>[Added] - New jets and truck added in A3 v1.14
<br/>[Added] - New AAF vehicles added in A3 v1.08
<br/>[Added] - New camos for Mk20 and MX in gunstores
<br/>[Added] - Ability to push plane backwards
<br/>[Added] - Ability to sell quadbike contents like crates
<br/>[Added] - Abort delay during combat when player saving on
<br/>[Changed] - Improved respawn menu
<br/>[Changed] - Respawn now longer to preload destination
<br/>[Changed] - Optimized player icons
<br/>[Changed] - Optimized FPS fix
<br/>[Changed] - Improved server persistence (requires iniDBI v1.4+)
<br/>[Changed] - Improved player saving (server-specific)
<br/>[Changed] - Improved base saving (server-specific)
<br/>[Changed] - Reduced starting gear
<br/>[Changed] - Modified some store prices
<br/>[Changed] - Reduced initial fuel in cars and helis
<br/>[Changed] - Removed Buzzard jet from too short runways
<br/>[Changed] - Removed Kavala castle territory for use as base
<br/>[Changed] - Increased vehicle repair time to 20 sec.
<br/>[Changed] - Increased owner unlocking time to 10 sec.
<br/>[Changed] - Toggling spawn beacon perms is now instant
<br/>[Changed] - Improved Take option for player items
<br/>[Changed] - Added option to cancel towing selection
<br/>[Changed] - Added machine gunner to main mission NPCs
<br/>[Changed] - Added grenadier to side mission NPCs
<br/>[Fixed] - Error messages in various menus
<br/>[Fixed] - Crash when toggling spawn beacon perms
<br/>[Fixed] - Error when hacking warchests
<br/>[Fixed] - Vehicle towing and lifting positions
<br/>[Fixed] - Repair Vehicle option showing for brand new vehicles
<br/>[Fixed] - Vest purchase price
<br/>[Fixed] - Vest and helmet armor value
<br/>[Fixed] - NPC leader now has launcher ammo
"
]];

player createDiaryRecord ["changelog",
[
"v0.9f",
"
<br/>[Added] - Money missions
<br/>[Added] - Sell Crate Items option at stores when moving crate
<br/>[Changed] - Reorganized loots for crates and trucks
<br/>[Fixed] - Broken Warchest menu
<br/>[Fixed] - Spawn beacons not working for Independent groups
<br/>[Fixed] - Player icons position inside buildings
<br/>[Fixed] - MRAPs and quadbikes not spawning
<br/>[Fixed] - Broken money rewards for territories
"
]];

player createDiaryRecord ["changelog",
[
"v0.9e",
"
<br/>[Added] - Territory system
<br/>[Added] - Jumping option (step over while running)
<br/>[Added] - New weapons from v1.04 update
<br/>[Changed] - Water and food now use water bottles and baked beans
<br/>[Fixed] - Store object purchases not operating as intended
<br/>[Fixed] - Objects purchased from stores not saving properly
<br/>[Fixed] - Minor server-side memory leak
"
]];

player createDiaryRecord ["changelog",
[
"v0.9d",
"
<br/>[Added] - Store object purchases
<br/>[Changed] - New UI by KoS
"
]];

player createDiaryRecord ["changelog",
[
"v0.9c",
"
<br/>[Changed] - Instant money pickup and drop
<br/>[Changed] - Increased plane and heli spawning odds
<br/>[Fixed] - FPS fix improvements
<br/>[Fixed] - Vehicles disappearing when untowed or airdropped
"
]];

player createDiaryRecord ["changelog",
[
"v0.9b",
"
<br/>[Initial release] - Welcome to Altis!
"
]];


player createDiaryRecord ["credits",
[
"Credits",
"
<br/><font size='16' color='#BBBBBB'>Developed by A3Wasteland.com:</font>
<br/>	* AgentRev (TeamPlayerGaming)
<br/>	* JoSchaap (GoT/Tweakers.net)
<br/>	* MercyfulFate
<br/>	* His_Shadow (KoS/KillonSight)
<br/>	* Bewilderbeest (KoS/KillonSight)
<br/>	* Torndeco
<br/>	* Del1te (404Games)
<br/>
<br/><font size='16' color='#BBBBBB'>Original Arma 2 Wasteland missions by:</font>
<br/>	* Tonic
<br/>	* Sa-Matra
<br/>	* MarKeR
<br/>
<br/><font size='16' color='#BBBBBB'>Improved and ported to Arma 3 by 404Games:</font>
<br/>	* Deadbeat
<br/>	* Costlyy
<br/>	* Pulse
<br/>	* Domuk
<br/>
<br/><font size='16' color='#BBBBBB'>Other contributors:</font>
<br/>	* 82ndab-Bravo17 (GitHub)
<br/>	* afroVoodo (Armaholic)
<br/>	* Austerror (GitHub)
<br/>	* AWA (OpenDayZ)
<br/>	* bodybag (Gameaholic.se)
<br/>	* Champ-1 (CHVD)
<br/>	* code34 (iniDBI)
<br/>	* Das Attorney (Jump MF)
<br/>	* Ed! (404Games forums)
<br/>	* Farooq (GitHub)
<br/>	* gtoddc (A3W forums)
<br/>	* HatchetHarry (GitHub)
<br/>	* Hub (TeamPlayerGaming)
<br/>	* k4n30 (GitHub)
<br/>	* Killzone_Kid (KillzoneKid.com)
<br/>	* Krunch (GitHub)
<br/>	* LouDnl (GitHub)
<br/>	* madbull (R3F)
<br/>	* Mainfrezzer (Magnon)
<br/>	* meat147 (GitHub)
<br/>	* micovery (GitHub)
<br/>	* Na_Palm (BIS forums)
<br/>	* Outlawled (Armaholic)
<br/>	* red281gt (GitHub)
<br/>	* RockHound (BierAG)
<br/>	* s3kShUn61 (GitHub)
<br/>	* Sa-Matra (BIS forums)
<br/>	* Sanjo (GitHub)
<br/>	* SCETheFuzz (GitHub)
<br/>	* Shockwave (A3W forums)
<br/>	* SicSemperTyrannis (iniDB)
<br/>	* SPJESTER (404Games forums)
<br/>	* spunFIN (BIS forums)
<br/>	* Tonic (BIS forums)
<br/>	* wiking.at (A3W forums)
<br/>	* xx-LSD-xx (Armaholic)
<br/>	* Zenophon (BIS Forums)
<br/>
<br/><font size='16'>Thanks A LOT to everyone involved for the help and inspiration!</font>
"
]];


_WASD = AKEYNAME("MoveForward") + "," + AKEYNAME("MoveBack") + "," + AKEYNAME("TurnLeft") + "," + AKEYNAME("TurnRight");

player createDiaryRecord ["infos",
[
"Admin Spectate keys",
"
<br/>Admin menu Spectate camera controls:
<br/>
<br/>Shift + " + AKEYNAME("NextChannel") + " (next player)
<br/>Shift + " + AKEYNAME("PrevChannel") + " (previous player)
<br/>Ctrl + " + NKEYNAME(18) + " (exit camera)
<br/>Ctrl + " + AKEYNAME("Chat") + " (attach/detach camera from target)
<br/>Ctrl + " + NKEYNAME(35) + " (toggle target HUD)
<br/>" + AKEYNAME("NightVision") + " (nightvision, thermal)
<br/>" + _WASD + " (move camera around)
<br/>" + NKEYNAME(16) + " (move camera up)
<br/>" + NKEYNAME(44) + " (move camera down)
<br/>Mouse Move (rotate camera)
<br/>Mouse Wheel Up (increase camera speed)
<br/>Mouse Wheel Down (decrease camera speed)
<br/>Shift + " + _WASD + " (move camera around faster)
<br/>" + AKEYNAME("ShowMap") + " (open/close map - click on map to teleport camera)
"
]];

player createDiaryRecord ["infos",
[
"Player hotkeys",
"
<br/>List of default player hotkeys:
<br/>
<br/>" + NKEYNAME(41) + " (open player menu)
<br/>" + NKEYNAME(207) + " (toggle earplugs)
<br/>" + NKEYNAME(219) + ", " + NKEYNAME(220) + " (toggle player names)
<br/>Ctrl + " + AKEYNAME("GetOut") + " (emergency eject)
<br/>" + AKEYNAME("GetOver") + " (open parachute)
<br/>Shift + " + NKEYNAME(201) + " / " + NKEYNAME(209) + " (adjust nightvision)
<br/>" + NKEYNAME(22) + " (admin menu)
<br/>Shift + H (surrender)
<br/>Home (Help message
<br/>Backspace (Detonate suicide vest or bomb)
<br/>Enter (Defibrillator revive player)
"
]];

player createDiaryRecord ["infos",
[
"Hints and Tips",
"
<br/><font size='18'>A3Wasteland</font>
<br/>
<br/>* At the start of the game, spread out and find supplies before worrying about where to establish a meeting place or a base, supplies are important and very valuable.
<br/>
<br/>* When picking a base location, it is best advised to pick a place that is out of the way and not so obvious such as airports, cities, map-bound bases, etc. remember, players randomly spawn in and around towns and could even spawn inside your base should you set it up in a town.
<br/>
<br/>* If you spawn in an area with no vehicles or supplies in the immediate area, DO NOT just click respawn from the pause menu, chances are if you search an area of a few hundred meters, you will find something.
<br/>
<br/>* Always be on the lookout for nightvision. they are located in the ammo crates, and there are pairs scattered throughout vehicles. You can also purchase them from the gunstores. Nighttime without them SUCKS, and if you have them, you can conduct stealth raids on enemy bases under the cover of complete darkness.
<br/>
<br/>* When you set up a base, never leave your supplies unguarded, one guard will suffice, but it is recommended you have at least 2, maybe 3 guards at base at all times.
<br/>
<br/>* There are very aggressive AI characters that spawn with most missions and will protect the mission objectives with deadly force, be aware of them.
"
]];

player createDiaryRecord ["infos",
[
"About Wasteland",
"
<br/>Wasteland is a team versus team versus team sandbox survival experience. The objective of this mission is to rally your faction, scavenge supplies, weapons, and vehicles, and destroy the other factions. It is survival at its best! Keep in mind this is a work in progress, please direct your reports to http://forums.a3wasteland.com/
<br/>
<br/>FAQ:
<br/>
<br/>Q. What am I supposed to do here?
<br/>A. See the above description
<br/>
<br/>Q. Where can I get a gun?
<br/>A. Weapons are found in one of three places, first in ammo crates that come as rewards from missions, inside and outside buildings, and second, in the gear section of the vehicles, which also randomly spawn around the map. The last place to find a gun would be at the gunshops located throughout the map. You can also find them on dead players whose bodies have not yet been looted.
<br/>
<br/>Q. What are the blue circles on the map?
<br/>A. The circles represent town limits. If friendly soldiers are in a town, you can spawn there from the re-spawn menu; however if there is an enemy presence, you will not be able to spawn there.
<br/>
<br/>Q. Why is it so dark, I cant see.
<br/>A. The server has a day/night cycle just like in the real world, and as such, night time is a factor in your survival. It is recommended that you find sources of light or use your Nightvision Goggles as the darkness sets in.
<br/>
<br/>Q. Is it ok for me to shoot my team mates?
<br/>A. If you are member of BLUFOR or OPFOR teams, then you are NOT allowed to shoot or steal items and vehicles from other players. If you play as Independent, you are free to engage anyone as well as team up with anyone you want.
<br/>
<br/>Q. Whats with the canisters, baskets and big bags?
<br/>A. This game has a food and water system that you must stay on top of if you hope to survive. You can collect food and water from food sacks and wells, or baskets and plastic canisters dropped by dead players. Food and water will also randomly spawn around the map.
<br/>
<br/>Q. I saw someone breaking a rule, what do I do?
<br/>A. Simply go into global chat and get the attention of one of the admins or visit our forums, and make a report if the offense is serious.
"
]];

player createDiaryRecord ["infos",
[
"Lucky's Wasteland",
"
<br/><font size='18'>Discord Invite link: https://discord.gg/ByZcqZx</font>
<br/>
<br/> Admin list:
<br/> - Lucky, Lee, Papa Kilo, Victor
"
]];

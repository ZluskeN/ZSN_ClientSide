////////////////////////////////////////////////////////////////////
//DeRap: zsn_surrender\config.bin
//Produced from mikero's Dos Tools Dll version 6.44
//'now' is Fri Jul 19 11:27:09 2019 : 'file' last modified on Fri Jul 19 11:23:09 2019
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class zsn_clientscripts
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1;
		requiredAddons[] = 
		{
			"cba_xeh",
			"cba_main",
			"cba_common",
			"cba_settings",
			"A3_anims_f",
			"ace_arsenal"
		};
	};
};
class Extended_PreInit_EventHandlers 
{
    class zsn_clientsettings
	{
        init = "call compile preprocessFileLineNumbers 'zsn_clientscripts\XEH_preInit.sqf'";
    };
};
class Extended_PostInit_EventHandlers
{
	class zsn_ace_postinit
	{
		init = "_this call zsn_fnc_aceserverinit";
	};
};
class Extended_InitPost_EventHandlers
{
	class CAManBase
	{
		class zsn_client_keybind_init
		{
			init = "nul = [] execVM 'zsn_clientscripts\functions\fn_keyBinds.sqf'";
		};
		class zsn_client_initpost
		{
			init = "if (isServer) then {_this RemoteExecCall ['zsn_fnc_clientinit', 0, true]}";
		};
	};
	class LandVehicle
	{
		class zsn_vehicle_fuelloop
		{
			init = "_this spawn zsn_fnc_fuelloop";
		};
	};
};
class CfgVehicles 
{
	class Man;
	class CAManBase: Man
	{
		class ACE_SelfActions
		{
			class ACE_Equipment
			{
				class zsn_clearweapon
				{
					displayName = "Clear Current Weapon";
					condition = "currentweapon _player in [primaryweapon _player, handgunweapon _player]";
					statement = "[_player] spawn zsn_fnc_clearweapon";
					showDisabled = 0;
					exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
				};
			};
		};
	};
	class LandVehicle;
    class Tank: LandVehicle {
        class ACE_Actions {
            class ZSN_GrenadeTrackp1 {
                displayName = "Plant Grenade";
                selection = "kolp1";
                distance = 2.0;
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'kolp1'];	_player removeMagazine 'HandGrenade'; [_nade, _target] spawn {waituntil{!alive (_this select 0)}; if (((_this select 1) getHit 'hit_trackr_point') < 0.9) then {(_this select 1) setHit ['hit_trackr_point', (0.85 + random 0.15)]};};";
            };
            class ZSN_GrenadeTrackl1 {
                displayName = "Plant Grenade";
                selection = "koll1";
                distance = 2.0;
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'koll1'];	_player removeMagazine 'HandGrenade'; [_nade, _target] spawn {waituntil{!alive (_this select 0)}; if (((_this select 1) getHit 'hit_trackl_point') < 0.9) then {(_this select 1) setHit ['hit_trackl_point', (0.85 + random 0.15)]};};";
            };
            class ZSN_GrenadeTrackp2 {
                displayName = "Plant Grenade";
                selection = "kolp2";
                distance = 2.0;
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'kolp2'];	_player removeMagazine 'HandGrenade'; [_nade, _target] spawn {waituntil{!alive (_this select 0)}; if (((_this select 1) getHit 'hit_trackr_point') < 0.9) then {(_this select 1) setHit ['hit_trackr_point', (0.85 + random 0.15)]};};";
            };
            class ZSN_GrenadeTrackl2 {
                displayName = "Plant Grenade";
                selection = "koll2";
                distance = 2.0;
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'koll2'];	_player removeMagazine 'HandGrenade'; [_nade, _target] spawn {waituntil{!alive (_this select 0)}; if (((_this select 1) getHit 'hit_trackl_point') < 0.9) then {(_this select 1) setHit ['hit_trackl_point', (0.85 + random 0.15)]};};";
            };
        };
	};
	class Truck_01_base_F;
	class B_Truck_01_transport_F: Truck_01_base_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "front", "left" };				// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
				cargoBayDimensions[]		= { {-0.68,0.67,-0.53}, {0.68,-5,2} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in degrees).
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).
				maxLoadMass					= 10000;								// Maximum cargo weight (in Kg) which the vehicle can transport
				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
				unloadingInterval			= 2;								// Time between unloading vehicles (in seconds)
				cargoSpacing[]				= { 0, 0.15, 0 };					// Offset from X,Y,Z axes (in metres)
			};
		};
	};
	class UGV_01_base_F;
	class B_UGV_01_F: UGV_01_base_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "front", "left" };				// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
				cargoBayDimensions[]		= { {-0.04,0.32,-1.28}, {0.94,-0.32,0.14} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in de
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).grees).
				maxLoadMass					= 1000;								// Maximum cargo weight (in Kg) which the vehicle can transport
				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
				unloadingInterval			= 2;								// Time between unloading vehicles (in seconds)
				cargoSpacing[]				= { 0, 0.15, 0 };					// Offset from X,Y,Z axes (in metres)
			};
		};
	};
};
class CfgFunctions
{
	class ZSN
	{
		class Functions
		{
			class aceServerInit
			{
				file = "\zsn_clientscripts\functions\fn_aceserverInit.sqf";
			};
			class addArsenal
			{
				file = "\zsn_clientscripts\functions\fn_addarsenal_ace.sqf";
			};
			class aloneWarning
			{
				file = "\zsn_clientscripts\functions\fn_aloneWarning.sqf";
			};
			class ammoLoop
			{
				file = "\zsn_clientscripts\functions\fn_ammoloop.sqf";
			};
			class armorShake
			{
				file = "\zsn_clientscripts\functions\fn_armorShake.sqf";
			};
			class blockMags
			{
				file = "\zsn_clientscripts\functions\fn_blockMags.sqf";
			};
			class chambered
			{
				file = "\zsn_clientscripts\functions\fn_chambered.sqf";
			};
			class clearWeapon
			{
				file = "\zsn_clientscripts\functions\fn_clearWeapon.sqf";
			};
			class clientInit
			{
				file = "\zsn_clientscripts\functions\fn_clientInit.sqf";
			};
			class disableNVG
			{
				file = "\zsn_clientscripts\functions\fn_disableNVG.sqf";
			};
			class fireStarter
			{
				file = "\zsn_clientscripts\functions\fn_fireStarter.sqf";
			};
			class fuelLoop
			{
				file = "\zsn_clientscripts\functions\fn_fuelLoop.sqf";
			};
			class isOpenBolt
			{
				file = "\zsn_clientscripts\functions\fn_isopenbolt.sqf";
			};
			class medicalItems
			{
				file = "\zsn_clientscripts\functions\fn_medicalItems.sqf";
			};
			class playerAmmo
			{
				file = "\zsn_clientscripts\functions\fn_playerammo.sqf";
			};
			class randomWeapon
			{
				file = "\zsn_clientscripts\functions\fn_randomweapon.sqf";
			};
			class showGPS
			{
				file = "\zsn_clientscripts\functions\fn_showgps.sqf";
			};
			class squat
			{
				file = "\zsn_clientscripts\functions\fn_squat.sqf";
			};
			class stachegenerator
			{
				file = "\zsn_clientscripts\functions\fn_stachegenerator.sqf";
			};
			class womanizer
			{
				file = "\zsn_clientscripts\functions\fn_womanizer.sqf";
			};
		};
	};
	class rund
	{
		class Functions
		{
			class kickImpact
			{
				file = "\zsn_clientscripts\functions\fn_kickimpact.sqf";
			};
		};
	};
};

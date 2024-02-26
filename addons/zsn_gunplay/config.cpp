////////////////////////////////////////////////////////////////////
//DeRap: zsn_surrender\config.bin
//Produced from mikero's Dos Tools Dll version 6.44
//'now' is Fri Jul 19 11:27:09 2019 : 'file' last modified on Fri Jul 19 11:23:09 2019
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class zsn_gunplay
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
    class zsn_gunplaysettings
	{
        init = "call compile preprocessFileLineNumbers 'zsn_gunplay\XEH_preInit.sqf'";
    };
};
class Extended_InitPost_EventHandlers
{
	class CAManBase
	{
		class zsn_gp_keybind_init
		{
			init = "nul = [] execVM 'zsn_gunplay\functions\fn_keyBinds.sqf'";
		};
		class zsn_gp_initpost
		{
			init = "if (isServer) then {_this RemoteExecCall ['zsn_fnc_gpclientinit', 0, true]}";
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
				class ZSN_ClearWeapon
				{
					displayName = "Clear Current Weapon";
					condition = "currentweapon _player in [primaryweapon _player, handgunweapon _player]";
					statement = "[_player] call zsn_fnc_clearweapon";
					showDisabled = 0;
					exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
					icon = "a3\ui_f\data\igui\cfg\actions\reload_ca.paa";
				};
			};
		};
		class ACE_Actions {
            class ZSN_ThrowMagazine {
                displayName = "Throw magazine";
                selection = "pelvis";
                distance = 30;
                condition = "(_target distance _player > 5 && [_player,_target,currentWeapon _target] call ace_interaction_fnc_canPassMagazine) && ([_target, 'VIEW', _player] checkVisibility [eyePos _player, aimPos _target] > 0 && ZSN_Throwing)";
                statement = "[_player,_target,currentWeapon _target] call ace_interaction_fnc_PassMagazine; _player playActionNow 'ThrowGrenade'; playSound3D ['a3\sounds_f\characters\stances\grenade_throw1.wss', _player]; [] spawn {ZSN_Throwing = false; sleep 1; ZSN_Throwing = true;};";
                icon = "a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa";
			};
            class ZSN_ThrowRock {
                displayName = "Throw rock";
                selection = "head";
                distance = 30;
                condition = "(alive _target && _target distance _player > 5) && ([_target, 'VIEW', _player] checkVisibility [eyePos _player, aimPos _target] > 0 && ZSN_Throwing)";
                statement = "_player playActionNow 'ThrowGrenade'; playSound3D ['a3\sounds_f\characters\stances\grenade_throw2.wss', _player]; if (isPlayer _target) then {[_player] remoteexeccall ['zsn_fnc_throwrock', _target]}; [] spawn {ZSN_Throwing = false; sleep 1; ZSN_Throwing = true;};";
                icon = "a3\ui_f\data\igui\cfg\simpletasks\types\kill_ca.paa";
				
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
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "((count ((magazines _player) arrayintersect ZSN_Grenades) > 0) && ZSN_GrenadeTrack)";
                statement = "[_player,_target,'kolp1'] call zsn_fnc_grenadetrack";
            };
            class ZSN_GrenadeTrackl1 {
                displayName = "Plant Grenade";
                selection = "koll1";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "((count ((magazines _player) arrayintersect ZSN_Grenades) > 0) && ZSN_GrenadeTrack)";
                statement = "[_player,_target,'koll1'] call zsn_fnc_grenadetrack";
            };
            class ZSN_GrenadeTrackp2 {
                displayName = "Plant Grenade";
                selection = "kolp2";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "((count ((magazines _player) arrayintersect ZSN_Grenades) > 0) && ZSN_GrenadeTrack)";
                statement = "[_player,_target,'kolp2'] call zsn_fnc_grenadetrack";
            };
            class ZSN_GrenadeTrackl2 {
                displayName = "Plant Grenade";
                selection = "koll2";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "((count ((magazines _player) arrayintersect ZSN_Grenades) > 0) && ZSN_GrenadeTrack)";
                statement = "[_player,_target,'koll2'] call zsn_fnc_grenadetrack";
            };
            class ZSN_GrenadeTrackpodkolol3 {
                displayName = "Plant Grenade";
                selection = "podkolol3";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "((count ((magazines _player) arrayintersect ZSN_Grenades) > 0) && ZSN_GrenadeTrack)";
                statement = "[_player,_target,'podkolol3'] call zsn_fnc_grenadetrack";
            };
            class ZSN_GrenadeTrackpodkolop3 {
                displayName = "Plant Grenade";
                selection = "podkolop3";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "((count ((magazines _player) arrayintersect ZSN_Grenades) > 0) && ZSN_GrenadeTrack)";
                statement = "[_player,_target,'podkolop3'] call zsn_fnc_grenadetrack";
            };
            class ZSN_GrenadeTrackSprocket1 {
                displayName = "Plant Grenade";
                selection = "sprocket_wheel_1_1";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_4.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'sprocket_wheel_1_1'];	_player removeMagazine 'HandGrenade'; [_nade, _target, _player] spawn {waituntil{!alive (_this select 0)}; (_this select 1) setHit ['hitpoint_track_1', 1, true, (_this select 2)]}; [] spawn {ZSN_GrenadeTrack = false; sleep 1; ZSN_GrenadeTrack = true;};";
            };
            class ZSN_GrenadeTrackSprocket2 {
                displayName = "Plant Grenade";
                selection = "sprocket_wheel_1_2";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_3.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'sprocket_wheel_1_2'];	_player removeMagazine 'HandGrenade'; [_nade, _target, _player] spawn {waituntil{!alive (_this select 0)}; (_this select 1) setHit ['hitpoint_track_2', 1, true, (_this select 2)]}; [] spawn {ZSN_GrenadeTrack = false; sleep 1; ZSN_GrenadeTrack = true;};";
            };
            class ZSN_GrenadeTrackIdler1 {
                displayName = "Plant Grenade";
                selection = "idler_wheel_1_1";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'idler_wheel_1_1'];	_player removeMagazine 'HandGrenade'; [_nade, _target, _player] spawn {waituntil{!alive (_this select 0)}; (_this select 1) setHit ['hitpoint_track_1', 1, true, (_this select 2)]}; [] spawn {ZSN_GrenadeTrack = false; sleep 1; ZSN_GrenadeTrack = true;};";
            };
            class ZSN_GrenadeTrackIdler2 {
                displayName = "Plant Grenade";
                selection = "idler_wheel_1_2";
                distance = 2.0;
                icon = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_6_ca.paa";
                condition = "(('HandGrenade' in (magazines _player)) && ZSN_GrenadeTrack)";
                statement = "playSound3D ['A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_1.wss', _player]; _nade = 'GrenadeHand' createVehicle getpos _player; _nade attachTo [_target, [0, 0, -1], 'idler_wheel_1_2'];	_player removeMagazine 'HandGrenade'; [_nade, _target, _player] spawn {waituntil{!alive (_this select 0)}; (_this select 1) setHit ['hitpoint_track_2', 1, true, (_this select 2)]}; [] spawn {ZSN_GrenadeTrack = false; sleep 1; ZSN_GrenadeTrack = true;};";
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
			class addArsenal
			{
				file = "\zsn_gunplay\functions\fn_addarsenal_ace.sqf";
			};
			class ammoLoop
			{
				file = "\zsn_gunplay\functions\fn_ammoloop.sqf";
			};
			class blockMags
			{
				file = "\zsn_gunplay\functions\fn_blockMags.sqf";
			};
			class chambered
			{
				file = "\zsn_gunplay\functions\fn_chambered.sqf";
			};
			class clearWeapon
			{
				file = "\zsn_gunplay\functions\fn_clearWeapon.sqf";
			};
			class gpClientInit
			{
				file = "\zsn_gunplay\functions\fn_gpClientInit.sqf";
			};
			class grenadeTrack
			{
				file = "\zsn_gunplay\functions\fn_grenadeTrack.sqf";
			};
			class isOpenBolt
			{
				file = "\zsn_gunplay\functions\fn_isopenbolt.sqf";
			};
			class playerAmmo
			{
				file = "\zsn_gunplay\functions\fn_playerammo.sqf";
			};
			class randomWeapon
			{
				file = "\zsn_gunplay\functions\fn_randomweapon.sqf";
			};
			class squat
			{
				file = "\zsn_gunplay\functions\fn_squat.sqf";
			};
			class throwrock
			{
				file = "\zsn_gunplay\functions\fn_throwrock.sqf";
			};
		};
	};
};

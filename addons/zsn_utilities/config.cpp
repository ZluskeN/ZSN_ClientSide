////////////////////////////////////////////////////////////////////
//DeRap: zsn_surrender\config.bin
//Produced from mikero's Dos Tools Dll version 6.44
//'now' is Fri Jul 19 11:27:09 2019 : 'file' last modified on Fri Jul 19 11:23:09 2019
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class zsn_utilities
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
    class zsn_utilitiessettings
	{
        init = "call compile preprocessFileLineNumbers 'zsn_utilities\XEH_preInit.sqf'";
    };
};
class Extended_PostInit_EventHandlers
{
	class zsn_util_postinit
	{
		init = "_this call zsn_fnc_utilserverinit";
	};
};
class Extended_InitPost_EventHandlers
{
	class CAManBase
	{
		class zsn_util_keybind_init
		{
			init = "nul = [] execVM 'zsn_utilities\functions\fn_keyBinds.sqf'";
		};
		class zsn_util_initpost
		{
			init = "if (isServer) then {_this RemoteExecCall ['zsn_fnc_utilclientinit', 0, true]}";
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
class CfgFunctions
{
	class ZSN
	{
		class Functions
		{
			class aloneWarning
			{
				file = "\zsn_utilities\functions\fn_aloneWarning.sqf";
			};
			class armorShake
			{
				file = "\zsn_utilities\functions\fn_armorShake.sqf";
			};
			class disableNVG
			{
				file = "\zsn_utilities\functions\fn_disableNVG.sqf";
			};
			class fireStarter
			{
				file = "\zsn_utilities\functions\fn_fireStarter.sqf";
			};
			class fuelLoop
			{
				file = "\zsn_utilities\functions\fn_fuelLoop.sqf";
			};
			class medicalItems
			{
				file = "\zsn_utilities\functions\fn_medicalItems.sqf";
			};
			class showGPS
			{
				file = "\zsn_utilities\functions\fn_showgps.sqf";
			};
			class squat
			{
				file = "\zsn_utilities\functions\fn_squat.sqf";
			};
			class stachegenerator
			{
				file = "\zsn_utilities\functions\fn_stachegenerator.sqf";
			};
			class utilclientInit
			{
				file = "\zsn_utilities\functions\fn_utilclientInit.sqf";
			};
			class utilServerInit
			{
				file = "\zsn_utilities\functions\fn_utilServerInit.sqf";
			};
			class womanizer
			{
				file = "\zsn_utilities\functions\fn_womanizer.sqf";
			};
		};
	};
	class rund
	{
		class Functions
		{
			class kickImpact
			{
				file = "\zsn_utilities\functions\fn_kickimpact.sqf";
			};
		};
	};
};

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
			"A3_anims_f"
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
			init = "if (isServer) then {_this RemoteExecCall ['zsn_fnc_clientinit', _this select 0, true]};";
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
				file = "\zsn_clientscripts\functions\fn_addarsenal.sqf";
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
			class blockmags
			{
				file = "\zsn_clientscripts\functions\fn_blockmags.sqf";
			};
			class chambered
			{
				file = "\zsn_clientscripts\functions\fn_chambered.sqf";
			};
			class clearweapon
			{
				file = "\zsn_clientscripts\functions\fn_clearweapon.sqf";
			};
			class clientInit
			{
				file = "\zsn_clientscripts\functions\fn_clientInit.sqf";
			};
			class disableNVG
			{
				file = "\zsn_clientscripts\functions\fn_disableNVG.sqf";
			};
			class dropWeapon
			{
				file = "\zsn_clientscripts\functions\fn_dropWeapon.sqf";
			};
			class Hint
			{
				file = "\zsn_clientscripts\functions\fn_hint.sqf";
			};
			class isOpenBolt
			{
				file = "\zsn_clientscripts\functions\fn_isopenbolt.sqf";
			};
			class playerAmmo
			{
				file = "\zsn_clientscripts\functions\fn_playerammo.sqf";
			};
			class randomWeapon
			{
				file = "\zsn_clientscripts\functions\fn_randomweapon.sqf";
			};
			class showgps
			{
				file = "\zsn_clientscripts\functions\fn_showgps.sqf";
			};
			class squat
			{
				file = "\zsn_clientscripts\functions\fn_squat.sqf";
			};
		};
	};
};

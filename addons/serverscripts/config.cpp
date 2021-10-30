////////////////////////////////////////////////////////////////////
//DeRap: zsn_surrender\config.bin
//Produced from mikero's Dos Tools Dll version 6.44
//'now' is Fri Jul 19 11:27:09 2019 : 'file' last modified on Fri Jul 19 11:23:09 2019
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class zsn_serverscripts
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
    class zsn_serversettings
	{
        init = "call compile preprocessFileLineNumbers 'zsn_serverscripts\XEH_preInit.sqf'";
    };
};
class Extended_PostInit_EventHandlers
{
	class zsn_server_postinit
	{
		init = "_this call zsn_fnc_serverinit";
	};
};
class Extended_InitPost_EventHandlers
{
	class CAManBase
	{
		class zsn_server_keybind_init
		{
			init = "nul = [] execVM 'zsn_serverscripts\functions\fn_keyBinds.sqf'";
		};
		class zsn_server_initpost
		{
			init = "if (isServer) then {_this RemoteExecCall ['zsn_fnc_serverclientInit', _this select 0, true]};";
		};
	};
};
class CfgFunctions
{
	class ZSN
	{
		class Functions
		{
			class addTripod
			{
				file = "\zsn_serverscripts\functions\fn_addtripod.sqf";
			};
			class serverclientInit
			{
				file = "\zsn_serverscripts\functions\fn_serverclientInit.sqf";
			};
			class disableNVG
			{
				file = "\zsn_serverscripts\functions\fn_disableNVG.sqf";
			};
			class Hint
			{
				file = "\zsn_serverscripts\functions\fn_hint.sqf";
			};
			class mgStance
			{
				file = "\zsn_serverscripts\functions\fn_mgstance.sqf";
			};
			class serverInit
			{
				file = "\zsn_serverscripts\functions\fn_serverInit.sqf";
			};
		};
	};
};

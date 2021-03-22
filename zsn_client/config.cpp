////////////////////////////////////////////////////////////////////
//DeRap: zsn_surrender\config.bin
//Produced from mikero's Dos Tools Dll version 6.44
//'now' is Fri Jul 19 11:27:09 2019 : 'file' last modified on Fri Jul 19 11:23:09 2019
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class zsn_clientside
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1;
		requiredAddons[] = {};
	};
};
class Extended_PreInit_EventHandlers 
{
    class zsn_settings
	{
        init = "call compile preprocessFileLineNumbers 'zsn_client\XEH_preInit.sqf'";
    };
};
class Extended_PostInit_EventHandlers
{
	class zsn_server_init
	{
		init = "_this call zsn_fnc_serverinit";
	};
};
class Extended_InitPost_EventHandlers
{
	class Allvehicles
	{
		class zsn_disableTI
		{
			init = "_this select 0 disableTIEquipment ZSN_DisableTI";
		};
	};
	class CAManBase
	{
		class zsn_keybind_init
		{
			init = "nul = [] execVM 'zsn_client\functions\fn_keyBinds.sqf'";
		};
		class zsn_client_init
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
			class randomWeapon
			{
				file = "\zsn_client\functions\fn_randomweapon.sqf";
			};
			class clientInit
			{
				file = "\zsn_client\functions\fn_clientInit.sqf";
			};
			class serverInit
			{
				file = "\zsn_client\functions\fn_serverInit.sqf";
			};
			class addArsenal
			{
				file = "\zsn_client\functions\fn_addarsenal.sqf";
			};
			class addArsenal_ace
			{
				file = "\zsn_client\functions\fn_addarsenal_ace.sqf";
			};
			class Hint
			{
				file = "\zsn_client\functions\fn_hint.sqf";
			};
			class dropWeapon
			{
				file = "\zsn_client\functions\fn_dropWeapon.sqf";
			};
			class clearWeapon
			{
				file = "\zsn_client\functions\fn_clearWeapon.sqf";
			};
			class chambered
			{
				file = "\zsn_client\functions\fn_chambered.sqf";
			};
			class mgStance
			{
				file = "\zsn_client\functions\fn_mgstance.sqf";
			};
			class Spectator
			{
				file = "\zsn_client\functions\fn_spectator.sqf";
			};
			class addTripod
			{
				file = "\zsn_client\functions\fn_addtripod.sqf";
			};
			class armorShake
			{
				file = "\zsn_client\functions\fn_armorShake.sqf";
			};
			class squat
			{
				file = "\zsn_client\functions\fn_squat.sqf";
			};
			class medicalItems
			{
				file = "\zsn_client\functions\fn_medicalItems.sqf";
			};
		};
	};
};

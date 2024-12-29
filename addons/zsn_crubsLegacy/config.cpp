////////////////////////////////////////////////////////////////////
//DeRap: zsn_surrender\config.bin
//Produced from mikero's Dos Tools Dll version 6.44
//'now' is Fri Jul 19 11:27:09 2019 : 'file' last modified on Fri Jul 19 11:23:09 2019
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class zsn_crubsLegacy
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
		};
	};
};
class Extended_PreInit_EventHandlers 
{
    class zsn_crubsettings
	{
        init = "call compile preprocessFileLineNumbers 'zsn_crubsLegacy\XEH_preInit.sqf'";
    };
};
class CfgFunctions
{
	class Crub
	{
		class Functions
		{
			class apocalypse
			{
				file = "\zsn_crubsLegacy\functions\fn_apocalypse.sqf";
			};
			class civpresence
			{
				file = "\zsn_crubsLegacy\functions\fn_civpresence.sqf";
			};
			class floatary
			{
				file = "\zsn_crubsLegacy\functions\fn_floatary.sqf";
			};
			class mapicons
			{
				file = "\zsn_crubsLegacy\functions\fn_mapicons.sqf";
			};
			class mapintel
			{
				file = "\zsn_crubsLegacy\functions\fn_mapintel.sqf";
			};
			class nametags
			{
				file = "\zsn_crubsLegacy\functions\fn_nametags.sqf";
			};
			class spotsystem
			{
				file = "\zsn_crubsLegacy\functions\fn_spotsystem.sqf";
			};
			class zombiesystem
			{
				file = "\zsn_crubsLegacy\functions\fn_zombiesystem.sqf";
			};
		};
	};
};

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
class CfgVehicles
{
	class Air;
	class Helicopter: Air
	{
		class ACE_SelfActions
		{
			class live_radio_interface_open
			{
				displayName = "$STR_live_radio_interface_DisplayName";
				statement = "_target call live_radio_interface_fnc_open";
			};
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
			class mgstancenerf
			{
				file = "\zsn_serverscripts\functions\fn_mgstancenerf.sqf";
			};
		};
	};
};
class CfgRadioStations 
{
	class sr_p3 
	{
		name = "Sveriges Radio P3";
		url = "https://http-live.sr.se/p1-mp3-192";
	};
	class uk1940s 
	{
		name = "1940s UK radio";
		url = "https://solid2.streamupsolutions.com/proxy/rsbudoyu?mp=/;type=mp3";
	};
	class vietnamvet 
	{
		name = "Vietnam Vet Radio";
		url = "http://74.82.59.197:8440/;";
	};
	class nectarine 
	{
		name = "Nectarine Demoscene";
		url = "http://nectarine.from-de.com/necta192";
	};
	class electroswing 
	{
		name = "Electroswing Revolution Radio";
		url = "https://streamer.radio.co/s2c3cc784b/listen";
	};
	class nightride 
	{
		name = "Nightride FM";
		url = "https://nightride.fm/stream/nightride.mp3";
	};
	class chillsynth 
	{
		name = "Chillsynth FM";
		url = "https://nightride.fm/stream/chillsynth.mp3";
	};
	class darksynth 
	{
		name = "Darksynth FM";
		url = "https://nightride.fm/stream/darksynth.mp3";
	};
	class horrorsynth 
	{
		name = "Horrorsynth FM";
		url = "https://nightride.fm/stream/horrorsynth.mp3";
	};
};


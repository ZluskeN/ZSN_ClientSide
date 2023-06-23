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
		class zsn_vehicleinit
		{
			init = "_this call zsn_fnc_vehicleinit";
		};
	};
};
class CfgVehicles 
{
	class Car_F;
	class UGV_01_base_F: Car_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "right", "front" };				// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
//				cargoBayDimensions[]		= { {-0.15,0.35,-1}, {1.05,-0.85,0.35} };	// alternatively, positions in model space (since 2.08)
				cargoBayDimensions[]		= { {-0.15,0.35,-1}, {1.05,-0.85,0.6} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in de
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).grees).
				maxLoadMass					= 3000;								// Maximum cargo weight (in Kg) which the vehicle can transport
//				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
//				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
				unloadingInterval			= 2;								// Time between unloading vehicles (in seconds)
				cargoSpacing[]				= { 0, 0.15, 0 };					// Offset from X,Y,Z axes (in metres)
			};
		};
	};
	class UGV_01_rcws_base_F: UGV_01_base_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "right", "front" };				// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
				cargoBayDimensions[]		= { {-0.15,0.35,-1}, {1.05,-0.45,-0.2} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in de
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).grees).
				maxLoadMass					= 2500;								// Maximum cargo weight (in Kg) which the vehicle can transport
//				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
//				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
				unloadingInterval			= 2;								// Time between unloading vehicles (in seconds)
				cargoSpacing[]				= { 0, 0.15, 0 };					// Offset from X,Y,Z axes (in metres)
			};
		};
	};
	class Truck_01_base_F;
	class B_Truck_01_transport_F: Truck_01_base_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "front", "center" };			// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
//				cargoBayDimensions[]		= { {-0.34,0.69,-0.53}, {0.43,-4.94,0.43} };	// alternatively, positions in model space (since 2.08)
				cargoBayDimensions[]		= { {-0.35,0.65,-0.55}, {0.45,-4.95,0.45} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in degrees).
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).
				maxLoadMass					= 10000;							// Maximum cargo weight (in Kg) which the vehicle can transport
//				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
//				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
				unloadingInterval			= 2;								// Time between unloading vehicles (in seconds)
				cargoSpacing[]				= { 0, 0.15, 0 };					// Offset from X,Y,Z axes (in metres)
			};
		};
	};
	class Truck_02_base_F;
	class Truck_02_transport_base_F: Truck_02_base_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "front", "center" };			// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
//				cargoBayDimensions[]		= { {-0.20,1.16,-0.79}, {0.32,-3.68,0.35} };	// alternatively, positions in model space (since 2.08)
				cargoBayDimensions[]		= { {-0.30,1.15,-0.80}, {0.40,-3.65,0.35} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in degrees).
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).
				maxLoadMass					= 10000;							// Maximum cargo weight (in Kg) which the vehicle can transport
//				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
//				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
				unloadingInterval			= 2;								// Time between unloading vehicles (in seconds)
				cargoSpacing[]				= { 0, 0.15, 0 };					// Offset from X,Y,Z axes (in metres)
			};
		};
	};
	class Truck_03_base_F;
	class O_Truck_03_transport_F: Truck_03_base_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "front", "center" };			// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
//				cargoBayDimensions[]		= { {-0.26,0.05,-0.41}, {0.36,-4.98,0.68} };	// alternatively, positions in model space (since 2.08)
				cargoBayDimensions[]		= { {-0.35,0.05,-0.45}, {0.45,-4.95,0.65} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in degrees).
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).
				maxLoadMass					= 10000;							// Maximum cargo weight (in Kg) which the vehicle can transport
//				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
//				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
				unloadingInterval			= 2;								// Time between unloading vehicles (in seconds)
				cargoSpacing[]				= { 0, 0.15, 0 };					// Offset from X,Y,Z axes (in metres)
			};
		};
	};
	class O_Truck_03_covered_F: Truck_03_base_F {
		class VehicleTransport
		{
			class Carrier
			{
				cargoAlignment[]			= { "front", "center" };			// Array of 2 elements defining alignment of vehicles in cargo space.
																				// Possible values are left, right, center, front, back. Order is important.
//				cargoBayDimensions[]		= { {-0.26,0.05,-0.41}, {0.36,-4.98,0.68} };	// alternatively, positions in model space (since 2.08)
				cargoBayDimensions[]		= { {-0.35,0.05,-0.45}, {0.45,-4.95,0.65} };	// alternatively, positions in model space (since 2.08)
				disableHeightLimit			= 0;								// If set to 1 disable height limit of transported vehicles
				exits[]						= { {5,0,0}, {5,10,0} };			// alternatively, positions in model space (since 2.08)
				loadingAngle				= 60;								// Maximal sector where cargo vehicle must be to for loading (in degrees).
				loadingDistance				= 5;								// Maximal distance for loading in exit point (in meters).
				maxLoadMass					= 10000;							// Maximum cargo weight (in Kg) which the vehicle can transport
//				parachuteClassDefault		= "B_Parachute_02_F";				// Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
//				parachuteHeightLimitDefault	= 5;								// Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
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
			class vehicleInit
			{
				file = "\zsn_utilities\functions\fn_vehicleInit.sqf";
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

params ["_unit"];

//if (isClass(configFile >> "CfgPatches" >> "dzn_MG_Tripod") && ZSN_AddTripod) then {
//	_unit call zsn_fnc_addtripod
//};

if (rank _unit in ["PRIVATE","CORPORAL","SERGEANT"]) then {
	if (isClass(configFile >> "CfgPatches" >> "grad_trenches_main") && ZSN_AddShovel) then { 
		if (!("ACE_EntrenchingTool" in items _unit) && _unit canAdd "ACE_EntrenchingTool") then {_unit addItem "ACE_EntrenchingTool"};
	};
	if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff") && (rank _unit == "PRIVATE" && ZSN_RemoveMaps)) then {
		if (isPlayer _unit) then {
			ZSN_missionstart = true;
			addMissionEventHandler ["PreloadFinished", {if (ZSN_missionstart) then {player unlinkItem "itemMap"; ZSN_missionstart = false;}}];
		} else {
			_unit unlinkItem "itemMap";
		};
	};
};

//if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
//	_weapon = currentweapon _unit;
//	["weapon", {[_this select 0, _this select 1] spawn zsn_fnc_mgstancenerf}] call CBA_fnc_addPlayerEventHandler;
//	_unit setvariable ["zsn_mgstancenerf", true];
//	[_unit, _weapon] spawn zsn_fnc_mgstancenerf;
//};

_unit setUnitCombatMode ZSN_CombatMode;

_unit setUnitPosWeak ZSN_Unitpos;

_unit addEventHandler ["Killed",  
{   
	params ["_unit"];
	if (ZSN_Deadmarkers) then {
		_side = side group _unit;
		_markercolor = switch (_side) do {
			case west: {"ColorWEST"};
			case east: {"ColorEAST"};
			case resistance: {"ColorGUER"};
			default {"Default"};
		};
		_markertype = selectRandom ["Contact_pencilTask1","Contact_pencilTask2","Contact_pencilTask3"];
		_m = createMarker[format ["%1",random 1000],getPosATL (_unit)];  
		_m setMarkerShape "ICON";     
		_m setMarkerType _markertype;
		_m setMarkerColor _markercolor;  
		_m setmarkerSize [.5,.5];   
		_m setMarkerText "";
	};
}];

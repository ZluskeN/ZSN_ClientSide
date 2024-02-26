params ["_unit"];

ZSN_inertiaThreshold = 0.9;

if (local _unit) then {

	_unit call zsn_fnc_stachegenerator;

	_unit setUnitCombatMode ZSN_CombatMode;

	if (ZSN_Unitpos) then {_unit setUnitPosWeak "UP"};

	if ((rank _unit == "PRIVATE" && leader _unit != _unit) && ZSN_RemoveMaps) then {
		if (isPlayer _unit) then {
			ZSN_missionstart = true;
			addMissionEventHandler ["PreloadFinished", {if (ZSN_missionstart) then {player unlinkItem "itemMap"; ZSN_missionstart = false}}];
		} else {
			_unit unlinkItem "itemMap";
		};
	};

	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
	
		_unit call zsn_fnc_medicalItems;
		
		if (ZSN_MedicFacility && [_unit] call ace_common_fnc_isMedic) then {_unit setVariable ["ace_medical_isMedicalFacility", true, true]};
		
		if (hasInterface) then {
			{
				["ace_medical_treatment" + _x, {
					if (lifeState ace_player == "INCAPACITATED") then {
						titleText ["Someone is helping you", "PLAIN DOWN", 2, true, true];
					};
				}] call CBA_fnc_addEventHandler;
			} foreach ["bandageLocal", "checkBloodPressureLocal", "cprLocal", "fullHealLocal", "ivBagLocal", "medicationLocal", "splintLocal", "tourniquetLocal"];	
		}; 
	};
	
	_unit addEventHandler ["Fired", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		_side = str side _unit;
		if (_ammo != "") then {[_side, _ammo] remoteexeccall ["zsn_fnc_ammocounter",2]};
	}];

	_unit addEventHandler ["Killed",  
	{   
		params ["_unit"];
		if (ZSN_Deadmarkers) then {
			_side = side group _unit;
			_markerColor = switch (_side) do {
				case west: {"ColorWEST"};
				case east: {"ColorEAST"};
				case resistance: {"ColorGUER"};
				default {"Default"};
			};
			_markerType = selectRandom ["Contact_pencilTask1","Contact_pencilTask2","Contact_pencilTask3"];
			_markerDir = selectRandom [0, 90, 180, 270];
			_m = createMarker[format ["%1",random 1000],getPosATL (_unit)];  
			_m setMarkerShape "ICON";
			_m setMarkerDir _markerDir;
			_m setMarkerType _markerType;
			_m setMarkerColor _markerColor;  
			_m setmarkerSize [.66,.66];   
			_m setMarkerText "";
		};
	}];

	_unit addEventHandler ["InventoryOpened", { 
		params ["_unit", "_container"]; 
		if (goggles _container in zsn_staches) then { 
			removeGoggles _container; 
			_container addEventHandler ["ContainerClosed", { 
				params ["_container", "_unit"]; 
				_stache = _container getvariable "zsn_stache"; 
				_container linkItem _stache;  
				_container removeEventHandler [_thisEvent, _thisEventHandler];
			}]; 
		}; 
	}];
	
	if (isPlayer _unit && hasinterface) then {

		//if (isClass(configFile >> "CfgPatches" >> "biggus_ringus")) then {
			//_size = worldSize / 2;
			//private _halo = "inst_01ring" createVehicleLocal _pos;
			//private _model = getModelInfo _halo select 1; 
			//deleteVehicle _halo; 
			//private _simpleHalo = createSimpleObject [_model, _pos, true];
			//_simpleHalo = createSimpleObject ["inst_01ring", getpos _unit, true];
			//_simpleHalo setObjectScale 50;
		//};

		_unit spawn zsn_fnc_showgps;

		_unit spawn zsn_fnc_armorshake;

		_unit spawn zsn_fnc_alonewarning;
		 
		_unit addEventHandler ["Respawn", {
			params ["_unit", "_corpse"];

			_unit spawn zsn_fnc_showgps;

			_unit spawn zsn_fnc_armorshake;

			_unit spawn zsn_fnc_alonewarning;
			
		}];
		
	};
	
};

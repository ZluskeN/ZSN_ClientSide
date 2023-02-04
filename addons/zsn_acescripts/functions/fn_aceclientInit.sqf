params ["_unit"];

if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
	if (ZSN_MedicFacility && [_unit] call ace_common_fnc_isMedic) then {_unit setVariable ["ace_medical_isMedicalFacility", true, true]};
	if (ZSN_MedicalItems) then {_unit call zsn_fnc_medicalItems};
	["ace_unconscious", {
		params ["_unit","_isUnconscious","_willdrop","_ms","_time"];
		_grp = group _unit;
		_ms = side _grp;
		_willdrop = switch (ZSN_WeaponsDrop) do {
			case "true": {true};
			case "AI": {!(isplayer _unit)};
			case "false": {false};
		};
		if (_ms == CIVILIAN || !_willdrop) exitwith {};
		if (_isUnconscious) then {
			if (count weaponsItems _unit > 0) then {_unit call ace_hitreactions_fnc_throwWeapon};
		} else {
			_unit remoteexec [{
				params ["_unit","_containers","_container","_boxContents","_weapon"];
				sleep 3;
				if ((!(captive _unit) && primaryweapon _unit == "") && !(hasinterface && isplayer _unit)) then {
					_containers = [];
					{if ((weaponcargo _x) select 0 isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {_containers pushback _x};} forEach nearestObjects [_unit, ["ReammoBox", "ThingX"], 50];
					if (count _containers > 0) then {
						_containers = [_containers, [], {_unit distance _x}] call BIS_fnc_sortBy;
						_container = _containers select 0;
						_boxContents = weaponCargo _container;
						_weapon = _boxContents select 0;
						_unit action ["TakeWeapon", _container, _weapon];
						[_unit, "Picked up a weapon", _weapon] remoteexec ["zsn_fnc_hint"];
					};
				};
			}, _unit];
		};
	}] call CBA_fnc_addEventHandler;
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

if (!(isPlayer _unit && hasinterface)) then {
	if (isClass(configFile >> "CfgPatches" >> "ace_weaponselect")) then {
		if (currentWeapon _unit == handGunWeapon _unit) then {
			_unit spawn {
				params ["_unit","_time"];
				_time = random 3;
				while {alive _unit && (currentWeapon _unit == handGunWeapon _unit)} do {
					if ((behaviour _unit == "SAFE") OR (behaviour _unit == "CARELESS")) then {
						[_unit] call ace_weaponselect_fnc_putWeaponAway;
						waituntil {sleep _time; ((behaviour _unit != "CARELESS") && (behaviour _unit != "SAFE"));};
						_unit selectWeapon handgunWeapon _unit;
					};
				sleep _time;
				};
			};
		};
	};
};

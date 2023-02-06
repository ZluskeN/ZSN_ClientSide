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
			if (primaryweapon _unit != "") then {_unit call ace_hitreactions_fnc_throwWeapon};
		} else {
			_unit remoteexec ["zsn_fnc_retrieveweapon", _unit];
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

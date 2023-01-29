if (isServer) then {
	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
		["ace_unconscious", {
			params ["_unit", "_isUnconscious"];
			if (_isUnconscious) then {
				if (isPlayer _unit) then {
					remoteexec ["zsn_fnc_unconscious", _unit];
				};
			};
		}] call CBA_fnc_addEventHandler;
		if (ZSN_MedicalItems) then {
			{
				if ([_x] call ace_medical_treatment_fnc_isMedicalVehicle) then {_x addItemCargoGlobal ['ace_PersonalAidKit', 1]}
			} foreach vehicles;
		};
	};
	if (isClass(configFile >> "CfgPatches" >> "wildfire_main") && isClass(configFile >> "CfgPatches" >> "ace_cookoff")) then {
		["ace_cookoff_cookOff", zsn_fnc_fireStarter] call CBA_fnc_addEventHandler;
		["ace_cookoff_cookOffBox", zsn_fnc_fireStarter] call CBA_fnc_addEventHandler;
	};
};
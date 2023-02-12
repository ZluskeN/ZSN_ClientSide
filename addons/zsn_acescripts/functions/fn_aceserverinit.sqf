params ["_unit"];

if (isServer) then {
	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
		if (ZSN_MedicalItems) then {
			{
				if ([_x] call ace_medical_treatment_fnc_isMedicalVehicle) then {_x addItemCargoGlobal ['ace_PersonalAidKit', 1]}
			} foreach vehicles;
		};
		["ace_unconscious", {
			params ["_unit", "_isUnconscious","_willdrop"];
			_willdrop = switch (ZSN_WeaponsDrop) do {
				case "true": {true};
				case "AI": {!(isplayer _unit)};
				case "false": {false};
			};
			if (side group _unit == CIVILIAN) exitwith {};
			if (_isUnconscious) then {
				if (primaryweapon _unit != "" && _willdrop) then {_unit call ace_hitreactions_fnc_throwWeapon};
				if (isPlayer _unit) then {_unit remoteexec ["zsn_fnc_unconscious", _unit]};
			} else {
				if (!isPlayer _unit) then {
					_unit remoteexec ["zsn_fnc_retrieveweapon", _unit];
//					_unit remoteexec ["zsn_fnc_spawnstretcher", _unit];
				};
			};
		}] call CBA_fnc_addEventHandler;
	};
	["ace_interact_menu_newControllableObject", {
		params ["_type"];
		if (!(_type isKindOf "Tank")) exitWith {}; // lägg bara på handlingen i en vagn av den löst definerade kategorin "Tank"
		rund_kickAction = [
			"rund_KickAction", //namn
			"Chastise driver", //text
			"", //ikon
			{ //exekverad kod
				_ownerOfDriver = driver vehicle _player; 
				_ownerOfDriver remoteExec ["rund_fnc_kickimpact", _ownerOfDriver];
			},
			{_player isEqualTo commander vehicle _player} //Utvärdera om spelaren är vagnchef
		] call ace_interact_menu_fnc_createAction;		//Dela ut förmågan att utföra handlingen
		[_type, 1, ["ACE_SelfActions"], rund_kickAction, true] call ace_interact_menu_fnc_addActionToClass;
	}] call CBA_fnc_addEventHandler;
	if (isClass(configFile >> "CfgPatches" >> "wildfire_main") && isClass(configFile >> "CfgPatches" >> "ace_cookoff")) then {
		["ace_cookoff_cookOff", zsn_fnc_fireStarter] call CBA_fnc_addEventHandler;
		["ace_cookoff_cookOffBox", zsn_fnc_fireStarter] call CBA_fnc_addEventHandler;
	};
};

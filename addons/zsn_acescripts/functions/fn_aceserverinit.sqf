params ["_unit"];

if (isServer) then {
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
	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
		["ace_unconscious", {
			params ["_unit", "_isUnconscious"];
			if (_isUnconscious) then {
				if (isPlayer _unit) then {
					_unit remoteexec ["zsn_fnc_unconscious", _unit];
				};
			};
		}] call CBA_fnc_addEventHandler;
		if (ZSN_MedicalItems) then {
			{
				if ([_x] call ace_medical_treatment_fnc_isMedicalVehicle) then {_x addItemCargoGlobal ['ace_PersonalAidKit', 1]}
			} foreach vehicles;
		};
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

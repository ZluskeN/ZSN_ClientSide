if (isServer) then {

	zsn_ammotypes = [];
	zsn_shotsfired = "";

	addMissionEventHandler ["PlayerViewChanged", { 
		params ["_oldUnit", "_newUnit", "_vehicleIn","_oldCameraOn", "_newCameraOn", "_uav" ]; 
		if (unitIsUAV _newCameraOn) then {
			_goggles = goggles _oldCameraOn;
			_oldCameraOn unassignItem _goggles;
			_oldcameraon setVariable ["ZSN_Goggles", _goggles];
			_oldCameraOn addGoggles "G_Goggles_VR";
		};
		if (unitIsUAV _oldCameraOn) then {
			removeGoggles _newCameraOn; 
			_goggles = _newCameraOn getVariable "ZSN_Goggles";
			_newCameraOn assignItem _goggles;
		};
	}];

	addMissionEventHandler ["Ended", {
		params ["_endType"];
		{_string = (_x select 1) + ": " + str (_x select 0); zsn_shotsfired = zsn_shotsfired + "<br/>" + _string} foreach zsn_ammotypes;
		missionNamespace setVariable ["zsn_shotsfired", zsn_shotsfired];
	}];

	if (isClass(configFile >> "CfgPatches" >> "wildfire_main") && isClass(configFile >> "CfgPatches" >> "ace_cookoff")) then {
		["ace_cookoff_cookOff", {_this call zsn_fnc_fireStarter }] call CBA_fnc_addEventHandler;
		["ace_cookoff_cookOffBox", {_this call zsn_fnc_fireStarter}] call CBA_fnc_addEventHandler;
	};

	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
		["ace_bandaged", {
			params ["_medic", "_patient", "_bodyPart"];
			if (_bodyPart == "Head") then {
				[_patient, headgear _patient, true] call CBA_fnc_addItem;
				_patient addHeadgear "H_HeadBandage_clean_F";
				[{
					params ["_unit"];
					if (headGear _unit == "H_HeadBandage_clean_F") then {
						_headwounds = [_unit, "head"] call ace_medical_fnc_getOpenWounds;
						if (str _headwounds != "[]") then {_unit addHeadgear "H_HeadBandage_bloody_F"} else {_unit addHeadgear "H_HeadBandage_stained_F"};
					};
				}, [_patient], 60] call CBA_fnc_waitAndExecute;
			};
		}] call CBA_fnc_addEventHandler;
	};

	["ace_loadCargo", {
	params ["_object", "_vehicle"];
		_massobject = getmass _object;
		_massvehicle = getmass _vehicle;
		_newmass = _massvehicle + _massobject;
		if (ZSN_AdjustMass) then {
			["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
		};
	}] call CBA_fnc_addEventHandler;

	["ace_unloadCargo", {
		params ["_object", "_vehicle"];
		_massobject = if (typeName _object == "STRING") then {
			_obj = _object createvehicle [0,0,0];
			_mass = getmass _obj;
			deletevehicle _obj;
			_mass
		} else {
			getmass _object;
		};
		_massvehicle = getMass _vehicle;
		_newmass = _massvehicle - _massobject;
		if (ZSN_AdjustMass) then {
			["ace_common_setMass", [_vehicle, _newmass]] call CBA_fnc_globalEvent;
		};
	}] call CBA_fnc_addEventHandler;

	["ace_common_setMass", {
		params ["_object", "_mass"];
		_object setvariable ["zsn_mass", _mass];
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

if (!isMultiplayer) then {

	[] call zsn_fnc_savelimiter;

	_units = [];
	if (count units player > 2) then {
		{if (_x != player && (getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory")) then {_units pushback _x}} foreach units player;
	} else {
		if (count units (side player) > 2) then {
			{if (group _x != group player && (getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory")) then {_units pushback _x}} foreach units (side player);
		};
	};
	_uniforms = [];
	{_uniforms pushback [(uniform _x), _x]} foreach _units;
	_preloadedunit = {if (_x select 0 in ["TCGM_F_WetsuitShort_B","TCGM_F_WetsuitShort_O","TCGM_F_WetsuitShort_I","TCGM_F_WetsuitShortG_O","VX_Uniform_NATO","VX_Uniform_CSAT6","VX_Uniform_CSAT5","VX_Uniform_CSAT10","VX_Uniform_CSAT2","VX_Uniform_CSAT8"]) exitwith {_x select 1}} foreach _uniforms;
	_unit = if (isNil "_preloadedunit") then {selectrandom _units} else {_preloadedunit};
	_unit call zsn_fnc_womanizer;

	if ((isClass(configFile >> "CfgPatches" >> "TCGM_Quiet") && isClass(configFile >> "CfgPatches" >> "TCGM_Boss")) && (isClass(configFile >> "CfgPatches" >> "mgsr_units") && isClass(configFile >> "CfgPatches" >> "mgsr_faces"))) then {
		_mgseastunits = [];
		_mgswestunits = [];
		_mgsguerunits = [];
		{if (((getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory") && _x distance player > 100) && !(group _x == group player || _x == _unit)) then {_mgseastunits pushback _x}} foreach units EAST;
		{if (((getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory") && _x distance player > 100) && !(group _x == group player || _x == _unit)) then {_mgswestunits pushback _x}} foreach units WEST;
		{if (((getText (configFile >> "CfgVehicles" >> (typeof _x) >> "vehicleClass") != "MenStory") && _x distance player > 100) && !(group _x == group player || _x == _unit)) then {_mgsguerunits pushback _x}} foreach units RESISTANCE;
		_quiet = selectrandom _mgseastunits;
		_boss = selectrandom _mgswestunits;
		_snake = selectrandom _mgsguerunits;

		_loadout = getunitloadout _quiet;
		_quiet setunitloadout [_loadout select 0, _loadout select 1, _loadout select 2, ["TCGM_f_Quiet_U1", _loadout select 3 select 1], ["TCGM_Quiet_Vest", _loadout select 4 select 1], _loadout select 5, "", "mgsr_scarf", _loadout select 8, _loadout select 9];
		_quiet setface "TCGM_MakF_QuietQuiet";  
		_quiet setspeaker "NoVoice"; 
		_quiet setName "Тихий";

		_loadout = getunitloadout _boss;
		_boss setunitloadout [_loadout select 0, _loadout select 1, _loadout select 2, ["TCGM_f_Boss_U2", _loadout select 3 select 1], ["TCGM_Boss_Vest", _loadout select 4 select 1], _loadout select 5, "", "mgsr_scarf_khaki", _loadout select 8, _loadout select 9];
		_boss setface "TCGM_Fem_Boss";  
		_boss setspeaker "NoVoice"; 
		_boss setName "Воевода";

		_loadout = getunitloadout _snake;
		_snake setunitloadout [_loadout select 0, _loadout select 1, _loadout select 2, ["mgsr_sneaksuit", _loadout select 3 select 1], ["mgsr_vest", _loadout select 4 select 1], _loadout select 5, "mgsr_eyepatch", "mgsr_scarf_black", _loadout select 8, _loadout select 9];
		_snake setface "mgsr_nakedsnake";
		_snake setspeaker "NoVoice";
		_snake setName "Snake";
	};

};
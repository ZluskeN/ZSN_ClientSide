params ["_unit"];
_unit setUnitPosWeak "UP";
if (leader _unit == _unit) then {
	_unit setCombatMode ZSN_CombatMode;
} else {
	if (isClass(configFile >> "CfgPatches" >> "grad_trenches_main") && ZSN_AddShovel) then { 
		if (!("ACE_EntrenchingTool" in items _unit)) then {_unit addItem "ACE_EntrenchingTool"};
	};
	if (isClass(configFile >> "CfgPatches" >> "RR_mapStuff") && ZSN_RemoveMaps) then {
		if (!(isPlayer _unit && hasInterface)) then {
			_unit unlinkItem "itemMap";
		} else {
			ZSN_missionstart = true;
			addMissionEventHandler ["PreloadFinished", {if (ZSN_missionstart) then {player unlinkItem "itemMap"; ZSN_missionstart = false;}}];
		};
	};
};
if (isClass(configFile >> "CfgPatches" >> "dzn_MG_Tripod") && ZSN_AddTripod) then { 
	_unit call zsn_fnc_addtripod;
};
if (isPlayer _unit && hasinterface) then {
	call zsn_fnc_clearweapon;
	_unit addEventHandler["FiredMan", {
		_unit = _this select 0;
		_numOfBullets = (weaponState _unit) select 4;
		if (_numOfBullets == 0) then {
			if (ZSN_Autoswitch) then {
				if (_unit ammo handgunweapon _unit > 1) then {
					if (((getpos (_unit findNearestEnemy getpos _unit)) distance (getpos _unit)) < 50) then {
						_unit selectWeapon handgunWeapon _unit;
					};
				};
			};
		};
	}];
} else {
	if (isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
		_unit setvariable ["zsn_gunloopinit", false];
		[_unit] spawn zsn_fnc_mgstance;
	};
	if (isClass(configFile >> "CfgPatches" >> "ace_weaponselect")) then {
		if (currentWeapon _unit == handGunWeapon _unit) then {
			_unit spawn {
				params ["_unit","_time"];
				_time = random 3;
				while {alive _unit} do {
					if (currentWeapon _unit == handGunWeapon _unit) then {
						if ((behaviour _unit == "SAFE") OR (behaviour _unit == "CARELESS")) then {
							[_unit] call ace_weaponselect_fnc_putWeaponAway;
							waituntil {sleep _time; ((behaviour _unit != "CARELESS") && (behaviour _unit != "SAFE"));};
							_unit selectWeapon handgunWeapon _unit;
						};
					};
					sleep _time;
				};
			};
		};
	};
};
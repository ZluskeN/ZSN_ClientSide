params ["_unit"];

ZSN_massThreshold = 165;

if (isClass(configFile >> "CfgPatches" >> "WBK_HeavyWeaponsFramework")) then {
	{WBK_HeavyWeaponsArray pushback configName _x} foreach  ("_x call ace_arsenal_fnc_sortStatement_mass >= ZSN_massThreshold && ((configName (_x)) isKindof ['Rifle', configFile >> 'cfgWeapons'])" configClasses (configFile >> "cfgWeapons"));
};

if (local _unit) then {

	_unit addEventHandler ["AnimChanged", { 
		params ["_unit", "_anim", "_weapon"];
		_weapon = currentWeapon _unit;
		if (_weapon == primaryweapon _unit && ZSN_NerfMG) then {
			_weaponcfg = configfile >> "CfgWeapons" >> _weapon;
			_mass = _weaponcfg call ace_arsenal_fnc_sortStatement_mass;
			if ((_anim regexMatch ".*erc.*slow.*" || _anim == "AidlPercMstpSrasWrflDnon_AI") && (isClass(configFile >> "CfgPatches" >> "gm_core_animations") && _mass >= ZSN_massThreshold)) then {
				[_unit, "gm_AmovPercMstpSrasWmguDnon", 2] call ace_common_fnc_doAnimation;
			};
		};
	}];
	[{
		params ["_unit"];

		_unit call zsn_fnc_weaponreplacer;

		if (isPlayer _unit && hasinterface) then {

			[] call zsn_fnc_blockmags;

			_unit setVariable ["ZSN_MGNerfed", false];

			_startammo = _unit call zsn_fnc_playerammo;
			
			_unit setVariable ["ZSN_startammo", _startammo];

			_unit call zsn_fnc_chambered;

			_unit call zsn_fnc_ammoloop;

			_unit addAction ["", {
				params ["_target"];
				_muzzle = currentmuzzle _target;
				_magazine = getArray (configFile >> "CfgWeapons" >> _muzzle >> "magazines") select 0;
				_primaryWeapon = _target getVariable "ZSN_PrimaryWeapon";
				_primaryOpenBolt = _target getVariable "ZSN_primaryOpenBolt";
				_handgunWeapon = _target getVariable "ZSN_handgunWeapon";
				_handgunOpenBolt = _target getVariable "ZSN_HandgunOpenBolt";
				_isopenbolt = switch (_muzzle) do {
					case (_primaryWeapon): {_primaryOpenBolt};
					case (_handgunWeapon): {_handgunOpenBolt};
					default {[_target, _magazine, _muzzle] call zsn_fnc_isopenbolt};
				};
				_safety = _muzzle in (_target getVariable ["ace_safemode_safedWeapons", []]);
				if (!(_isopenbolt || _safety) && _muzzle != "") then {
					_target addWeaponItem [currentweapon _target, [_magazine, 1, _muzzle], true];
					_target forceWeaponFire [_muzzle, currentWeaponMode _target];
					switch (_muzzle) do {
						case (primaryweapon _target): {
							_target removePrimaryWeaponItem currentMagazine _target;
							_target setVariable ["ZSN_PrimaryChambered", false];
						};
						case (handgunweapon _target): {
							_target setVariable ["ZSN_HandgunChambered", false];
						};
						default {};
					};
				};
			}, [], 0, false, false, "DefaultAction", "
				currentmagazine _target == '' &&  {
					switch (currentmuzzle _target) do {
						case (primaryweapon _target): {_target getVariable 'ZSN_PrimaryChambered'};
						case (handgunweapon _target): {_target getVariable 'ZSN_HandgunChambered'};
						default {false};
					}
				}
			"];

			_unit addEventHandler ["OpticsSwitch", {
				params ["_unit", "_isADS"];
				_weapon = currentWeapon _unit;
				if (_weapon == primaryweapon _unit && ZSN_NerfMG) then {
					_weaponcfg = configfile >> "CfgWeapons" >> _weapon;
					_mass = _weaponcfg call ace_arsenal_fnc_sortStatement_mass;
					if (_mass >= ZSN_massThreshold) then {
						if ((_isADS && currentVisionMode _unit != 1) && (isNull objectParent _unit && speed _unit != 0)) then {_unit switchCamera "Internal"};
					};
				};
			}];

			_unit addEventHandler ["AnimChanged", { 
				params ["_unit", "_anim", "_weapon"];
				_weapon = currentWeapon _unit;
				if (_weapon == primaryweapon _unit && ZSN_NerfMG) then {
					_weaponcfg = configfile >> "CfgWeapons" >> _weapon;
					_mass = _weaponcfg call ace_arsenal_fnc_sortStatement_mass;
					if (_mass >= ZSN_massThreshold) then {
						if ((cameraView == "Gunner" && currentVisionMode _unit != 1) && (isNull objectParent _unit && speed _unit != 0)) then {_unit switchCamera "Internal"};
					};
				};
			}];

			_unit addEventHandler ["Respawn", {

				params ["_unit", "_corpse"];

				[] call zsn_fnc_blockmags;

				_unit setVariable ["ZSN_MGNerfed", false];

				_startammo = _unit call zsn_fnc_playerammo;

				_unit setVariable ["ZSN_startammo", _startammo];

				_unit call zsn_fnc_chambered;

				_unit spawn zsn_fnc_ammoloop;
				
				_unit addAction ["", {
					params ["_target"];
					_muzzle = currentmuzzle _target;
					_magazine = getArray (configFile >> "CfgWeapons" >> _muzzle >> "magazines") select 0;
					_primaryWeapon = _target getVariable "ZSN_PrimaryWeapon";
					_primaryOpenBolt = _target getVariable "ZSN_primaryOpenBolt";
					_handgunWeapon = _target getVariable "ZSN_handgunWeapon";
					_handgunOpenBolt = _target getVariable "ZSN_HandgunOpenBolt";
					_isopenbolt = switch (_muzzle) do {
						case (_primaryWeapon): {_primaryOpenBolt};
						case (_handgunWeapon): {_handgunOpenBolt};
						default {[_target, _magazine, _muzzle] call zsn_fnc_isopenbolt};
					};
					_safety = _muzzle in (_target getVariable ["ace_safemode_safedWeapons", []]);
					if (!(_isopenbolt || _safety) && _muzzle != "") then {
						_target addWeaponItem [currentweapon _target, [_magazine, 1, _muzzle], true];
						_target forceWeaponFire [_muzzle, currentWeaponMode _target];
						switch (_muzzle) do {
							case (primaryweapon _target): {
								_target removePrimaryWeaponItem currentMagazine _target;
								_target setVariable ["ZSN_PrimaryChambered", false];
							};
							case (handgunweapon _target): {
								_target setVariable ["ZSN_HandgunChambered", false];
							};
							default {};
						};
					};
				}, [], 0, false, false, "DefaultAction", "
					currentmagazine _target == '' &&  {
						switch (currentmuzzle _target) do {
							case (primaryweapon _target): {_target getVariable 'ZSN_PrimaryChambered'};
							case (handgunweapon _target): {_target getVariable 'ZSN_HandgunChambered'};
							default {false};
						}
					}
				"];

			}];

			_unit addEventHandler["Fired", {
				params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
				_unit = _this select 0;
				_weapon = _this select 1;
				_muzzle = _this select 2;
				if (_muzzle != _weapon) exitwith {};
				_numOfBullets = (weaponState _unit) select 4;
				_magtype = _this select 5;
				_primaryWeapon = _unit getVariable "ZSN_PrimaryWeapon";
				_primaryOpenBolt = _unit getVariable "ZSN_primaryOpenBolt";
				_handgunWeapon = _unit getVariable "ZSN_handgunWeapon";
				_handgunOpenBolt = _unit getVariable "ZSN_HandgunOpenBolt";
				_primaryChambered = _unit getVariable "ZSN_PrimaryChambered";
				_handgunChambered = _unit getVariable "ZSN_HandgunChambered";
				_isopenbolt = switch (_muzzle) do {
					case (_primaryWeapon): {_primaryOpenBolt};
					case (_handgunWeapon): {_handgunOpenBolt};
					default {[_unit, _magtype, _muzzle] call zsn_fnc_isopenbolt};
				};
				_chambered = switch (_muzzle) do {
					case (primaryweapon _unit): {_primaryChambered};
					case (handgunweapon _unit): {_handgunChambered};
					default {false};
				};
				if (_numOfBullets == 0) then {
					if (_chambered && !_isopenbolt) then {
						_unit setAmmo [_muzzle, 1];
						_unit setWeaponReloadingTime [_unit, _muzzle, 1];
						switch (_muzzle) do {
							case (primaryweapon _unit): {_unit setVariable ["ZSN_PrimaryChambered", false]};
							case (handgunweapon _unit): {_unit setVariable ["ZSN_HandgunChambered", false]};
						};
					} else {
						if (ZSN_Autoswitch && currentweapon _unit != secondaryweapon _unit) then {
							if (_unit ammo handgunweapon _unit > 1 && handgunweapon _unit != "hgun_Pistol_Signal_F") then {
								if (((getpos (_unit findNearestEnemy getpos _unit)) distance (getpos _unit)) < 50) then {
									_unit selectWeapon handgunWeapon _unit;
								};
							};
						};
					};
				} else {
					switch (_muzzle) do {
						case (primaryweapon _unit): {_primaryChambered = !_isopenbolt};
						case (handgunweapon _unit): {_handgunChambered = !_isopenbolt};
					};
				};
				_weaponcfg = configfile >> "CfgWeapons" >> _weapon;
				_mass = _weaponcfg call ace_arsenal_fnc_sortStatement_mass;
				if (ZSN_NerfMG && _mass >= ZSN_massThreshold) then {
					_unit forceWalk true;
					_walkTime = time + 2; 
					_unit setVariable ["ZSN_Walktime", _walkTime];
					_mgNerfed = _unit getVariable "ZSN_MGNerfed";
					if (!_mgNerfed) then {
						_unit setVariable ["ZSN_MGNerfed", true];
						[{_walkTime = _this select 0 getVariable "ZSN_Walktime"; time > _walkTime}, {_this select 0 forceWalk false; _this select 0 setVariable ["ZSN_MGNerfed", false];}, [_unit]] call CBA_fnc_waitUntilAndExecute;
					};
				};
			}];
			
			_unit addEventHandler["Reloaded", {
				params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
				_unit = _this select 0;
				_weapon = _this select 1;
				_muzzle = _this select 2;
				if (_muzzle != _weapon) exitwith {};
				_newmagtype = _this select 3 select 0;
				_newmagammo = _this select 3 select 1;
				_oldmagtype = _this select 4 select 0;
				_oldmagammo = _this select 4 select 1;
				_primaryWeapon = _unit getVariable "ZSN_PrimaryWeapon";
				_handgunWeapon = _unit getVariable "ZSN_handgunWeapon";
				_primaryOpenBolt = _unit getVariable "ZSN_primaryOpenBolt";
				_handgunOpenBolt = _unit getVariable "ZSN_HandgunOpenBolt";
				_primaryChambered = _unit getVariable ["ZSN_PrimaryChambered",true];
				_handgunChambered = _unit getVariable ["ZSN_HandgunChambered",true];
				_isopenbolt = switch (_muzzle) do {
					case (_primaryWeapon): {_primaryOpenBolt};
					case (_handgunWeapon): {_handgunOpenBolt};
					default {[_unit, _newmagtype, _muzzle] call zsn_fnc_isopenbolt};
				};
				_chambered = switch (_muzzle) do {
					case (primaryweapon _unit): {_primaryChambered};
					case (handgunweapon _unit): {_handgunChambered};
					default {true};
				};
				if (!_chambered && !_isopenbolt) then {
					if (count _this == 4) then {
						_newcount = _newmagammo - 1;
						if (_newcount > 0) then {
							_unit setAmmo [_muzzle, _newcount];
							switch (_muzzle) do {
								case (primaryweapon _unit): {_unit setVariable ["ZSN_PrimaryChambered", true]};
								case (handgunweapon _unit): {_unit setVariable ["ZSN_HandgunChambered", true]};
							};
						} else {
							switch (_muzzle) do {
								case (primaryweapon _unit): {_unit setVariable ["ZSN_PrimaryChambered", false]};
								case (handgunweapon _unit): {_unit setVariable ["ZSN_HandgunChambered", false]};
							};
						};
					} else {
						switch (_oldmagammo) do {
							case 1: {
								[_unit, _oldmagtype, 1] call CBA_fnc_removeMagazine;
							};
							case 0: {
								_newcount = _newmagammo - 1;
								if (_newcount > 0) then {
									_unit setAmmo [_muzzle, _newcount];
									switch (_muzzle) do {
										case (primaryweapon _unit): {_unit setVariable ["ZSN_PrimaryChambered", true]};
										case (handgunweapon _unit): {_unit setVariable ["ZSN_HandgunChambered", true]};
									};
								} else {
									switch (_muzzle) do {
										case (primaryweapon _unit): {_unit setVariable ["ZSN_PrimaryChambered", false]};
										case (handgunweapon _unit): {_unit setVariable ["ZSN_HandgunChambered", false]};
									};
								};
							};
							default {
								//switch (_muzzle) do {
								//	case (primaryweapon _unit): {_unit setVariable ["ZSN_PrimaryChambered", true]};
								//	case (handgunweapon _unit): {_unit setVariable ["ZSN_HandgunChambered", true]};
								//};
							};
						};
					};
				};
				if (isClass(configFile >> "CfgPatches" >> "Tun_Respawn") && ZSN_Tun_Respawn_OldGear) then {
					_unit Call Tun_Respawn_fnc_savegear;
				};
				if (_muzzle == primaryweapon _unit) then {
					[{
						params ["_unit"];
						if (str primaryWeaponMagazine _unit == "[]") then {_unit setVariable ["ZSN_PrimaryChambered", false]};

					}, _unit, 0.5] call CBA_fnc_waitAndExecute;
				};
			}];
		};
	}, _unit, 0.5] call CBA_fnc_waitAndExecute;
};

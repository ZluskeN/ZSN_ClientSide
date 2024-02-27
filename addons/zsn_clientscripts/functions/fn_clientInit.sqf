params ["_unit"];

ZSN_inertiaThreshold = 0.9;

if (local _unit) then {

	_unit setUnitCombatMode ZSN_CombatMode;

	if (ZSN_Unitpos) then {_unit setUnitPosWeak "UP"};

	if ((rank _unit == "PRIVATE" && leader _unit != _unit) && ZSN_RemoveMaps) then {
		if (isPlayer _unit) then {
			ZSN_missionstart = true;
			addMissionEventHandler ["PreloadFinished", {if (ZSN_missionstart) then {player unlinkItem "itemMap"; ZSN_missionstart = false;}}];
		} else {
			_unit unlinkItem "itemMap";
		};
	};

	if (isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
		if (ZSN_MedicFacility && [_unit] call ace_common_fnc_isMedic) then {_unit setVariable ["ace_medical_isMedicalFacility", true, true]};
		if (ZSN_MedicalItems && isPlayer _unit) then {_unit call zsn_fnc_medicalItems};
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
	
	_unit addEventHandler ["AnimChanged", { 
		params ["_unit", "_anim", "_weapon"];
		_weapon = currentWeapon _unit;
		if (_weapon == primaryweapon _unit && ZSN_NerfMG) then {
			if (getNumber (configFile >> "CfgWeapons" >> _weapon >> "inertia") >= 0.9) then {
				if (_anim regexMatch ".*erc.*slow.*" && isClass(configFile >> "CfgPatches" >> "gm_core_animations")) then {
//					_unit playAction "toMachinegun";
					[_unit, "gm_AmovPercMstpSrasWmguDnon", 2] call ace_common_fnc_doAnimation;
				};
			};
		};
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

	if (isPlayer _unit && hasinterface) then {

		ZSN_MGNerfed = false;

		zsn_startammo = _unit call zsn_fnc_playerammo; 
		
		[] call zsn_fnc_blockmags;

		_unit call zsn_fnc_chambered;

		_unit spawn zsn_fnc_ammoloop;

		_unit spawn zsn_fnc_showgps;

		_unit spawn zsn_fnc_armorshake;

		_unit spawn zsn_fnc_alonewarning;
		
		_unit addAction ["", {
			params ["_target"];
			_muzzle = currentmuzzle _target;
			_magazine = getArray (configFile >> "CfgWeapons" >> _muzzle >> "magazines") select 0;
			_isopenbolt = switch (_muzzle) do {
				case (ZSN_PrimaryWeapon): {ZSN_PrimaryOpenBolt};
				case (ZSN_HandgunWeapon): {ZSN_HandgunOpenBolt};
				default {[_target, _magazine, _muzzle] call zsn_fnc_isopenbolt};
			};
			if (!_isopenbolt) then {
				_target addWeaponItem [currentweapon _target, [_magazine, 1, _muzzle], true];
				_target forceWeaponFire [_muzzle, currentWeaponMode _target];
				switch (_muzzle) do {
					case (primaryweapon _target): {
						_target removePrimaryWeaponItem currentMagazine _target;
						ZSN_PrimaryChambered = false;
					};
					case (handgunweapon _target): {
						ZSN_HandgunChambered = false;
					};
					default {};
				};
			};
		}, [], 0, false, false, "DefaultAction", "
			currentmagazine _target == '' &&  {
				switch (currentmuzzle _target) do {
					case (ZSN_PrimaryWeapon): {ZSN_PrimaryChambered};
					case (ZSN_HandgunWeapon): {ZSN_HandgunChambered};
					default {false};
				}
			}
		"];

		_unit addEventHandler ["OpticsSwitch", {
			params ["_unit", "_isADS"];
			_weapon = currentWeapon _unit;
			if (_weapon == primaryweapon _unit && ZSN_NerfMG) then {
				if (getNumber (configFile >> "CfgWeapons" >> _weapon >> "inertia") >= ZSN_inertiaThreshold) then {
					if ((_isADS && currentVisionMode _unit != 1) && (vehicle _unit == _unit && speed _unit != 0)) then {_unit switchCamera "Internal"};
				};
			};
		}];

		_unit addEventHandler ["AnimChanged", { 
			params ["_unit", "_anim", "_weapon"];
			_weapon = currentWeapon _unit;
			if (_weapon == primaryweapon _unit && ZSN_NerfMG) then {
				if (getNumber (configFile >> "CfgWeapons" >> _weapon >> "inertia") >= ZSN_inertiaThreshold) then {
//					if (_anim regexMatch "amovpercm.*" || _anim regexMatch "gm_amovpercm.*mg.*") then {
					if ((cameraView == "Gunner" && currentVisionMode _unit != 1) && (vehicle _unit == _unit && speed _unit != 0)) then {_unit switchCamera "Internal"};
//					};
				};
			};
		}];

		_unit addEventHandler ["Respawn", {
			params ["_unit", "_corpse"];
			
			_unit call zsn_fnc_chambered;

			_unit spawn zsn_fnc_ammoloop;
			
			_unit spawn zsn_fnc_showgps;

			_unit spawn zsn_fnc_armorshake;

			_unit spawn zsn_fnc_alonewarning;
			
			_unit addAction ["", {
				params ["_target"];
				_muzzle = currentmuzzle _target;
				_magazine = getArray (configFile >> "CfgWeapons" >> _muzzle >> "magazines") select 0;
				_isopenbolt = switch (_muzzle) do {
					case (ZSN_PrimaryWeapon): {ZSN_PrimaryOpenBolt};
					case (ZSN_HandgunWeapon): {ZSN_HandgunOpenBolt};
					default {[_target, _magazine, _muzzle] call zsn_fnc_isopenbolt};
				};
				if (!_isopenbolt) then {
					_target addWeaponItem [currentweapon _target, [_magazine, 1, _muzzle], true];
					_target forceWeaponFire [_muzzle, currentWeaponMode _target];
					switch (_muzzle) do {
						case (primaryweapon _target): {
							_target removePrimaryWeaponItem currentMagazine _target;
							ZSN_PrimaryChambered = false;
						};
						case (handgunweapon _target): {
							ZSN_HandgunChambered = false;
						};
						default {};
					};
				};
			}, [], 0, false, false, "DefaultAction", "
				currentmagazine _target == '' &&  {
					switch (currentmuzzle _target) do {
						case (primaryweapon _target): {ZSN_PrimaryChambered};
						case (handgunweapon _target): {ZSN_HandgunChambered};
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
			_isopenbolt = switch (_muzzle) do {
				case (ZSN_PrimaryWeapon): {ZSN_PrimaryOpenBolt};
				case (ZSN_HandgunWeapon): {ZSN_HandgunOpenBolt};
				default {[_unit, _magtype, _muzzle] call zsn_fnc_isopenbolt};
			};
			_chambered = switch (_muzzle) do {
				case (primaryweapon _unit): {ZSN_PrimaryChambered};
				case (handgunweapon _unit): {ZSN_HandgunChambered};
				default {false};
			};
			if (_numOfBullets == 0) then {
				if (_chambered && !_isopenbolt) then {
					_unit setAmmo [_muzzle, 1];
					_unit setWeaponReloadingTime [_unit, _muzzle, 1];
					switch (_muzzle) do {
						case (primaryweapon _unit): {ZSN_PrimaryChambered = false};
						case (handgunweapon _unit): {ZSN_HandgunChambered = false};
					};
				} else {
					if (ZSN_Autoswitch) then {
						if (_unit ammo handgunweapon _unit > 1 && handgunweapon _unit != "hgun_Pistol_Signal_F") then {
							if (((getpos (_unit findNearestEnemy getpos _unit)) distance (getpos _unit)) < 50) then {
								_unit selectWeapon handgunWeapon _unit;
							};
						};
					};
				};
			} else {
				switch (_muzzle) do {
					case (primaryweapon _unit): {ZSN_PrimaryChambered = !_isopenbolt};
					case (handgunweapon _unit): {ZSN_HandgunChambered = !_isopenbolt};
				};
			};
			if (ZSN_NerfMG && getNumber (configFile >> "CfgWeapons" >> _weapon >> "inertia") >= ZSN_inertiaThreshold) then {
				_unit forceWalk true;
				ZSN_Walktime = time + 2; 
				if (!ZSN_MGNerfed) then {
					_unit spawn {
						ZSN_MGNerfed = true;
						waituntil {sleep 0.2; time > ZSN_Walktime}; 
						_this forceWalk false; 
						ZSN_MGNerfed = false;
					};
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
			_isopenbolt = switch (_muzzle) do {
				case (ZSN_PrimaryWeapon): {ZSN_PrimaryOpenBolt};
				case (ZSN_HandgunWeapon): {ZSN_HandgunOpenBolt};
				default {[_unit, _newmagtype, _muzzle] call zsn_fnc_isopenbolt};
			};
			_chambered = switch (_muzzle) do {
				case (primaryweapon _unit): {ZSN_PrimaryChambered};
				case (handgunweapon _unit): {ZSN_HandgunChambered};
				default {false};
			};
			if (!_chambered && !_isopenbolt) then {
				if (count _this == 4) then {
					_newcount = _newmagammo - 1;
					if (_newcount > 0) then {
						_unit setAmmo [_muzzle, _newcount];
						switch (_muzzle) do {
							case (primaryweapon _unit): {ZSN_PrimaryChambered = true};
							case (handgunweapon _unit): {ZSN_HandgunChambered = true};
						};
					} else {
						switch (_muzzle) do {
							case (primaryweapon _unit): {ZSN_PrimaryChambered = false};
							case (handgunweapon _unit): {ZSN_HandgunChambered = false};
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
									case (primaryweapon _unit): {ZSN_PrimaryChambered = true};
									case (handgunweapon _unit): {ZSN_HandgunChambered = true};
								};
							} else {
								switch (_muzzle) do {
									case (primaryweapon _unit): {ZSN_PrimaryChambered = false};
									case (handgunweapon _unit): {ZSN_HandgunChambered = false};
								};
							};
						};
						default {
							switch (_muzzle) do {
								case (primaryweapon _unit): {ZSN_PrimaryChambered = true};
								case (handgunweapon _unit): {ZSN_HandgunChambered = true};
							};
						};
					};
				};
			};
			if (isClass(configFile >> "CfgPatches" >> "Tun_Respawn") && ZSN_Tun_Respawn_OldGear) then {
				_unit Call Tun_Respawn_fnc_savegear;
			};
		}];
	};
};

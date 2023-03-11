params ["_unit"];

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

_unit addEventHandler ["Killed",  
{   
	params ["_unit"];
	if (ZSN_Deadmarkers) then {
		_side = side group _unit;
		_markercolor = switch (_side) do {
			case west: {"ColorWEST"};
			case east: {"ColorEAST"};
			case resistance: {"ColorGUER"};
			default {"Default"};
		};
		_markertype = selectRandom ["Contact_pencilTask1","Contact_pencilTask2","Contact_pencilTask3"];
		_m = createMarker[format ["%1",random 1000],getPosATL (_unit)];  
		_m setMarkerShape "ICON";     
		_m setMarkerType _markertype;
		_m setMarkerColor _markercolor;  
		_m setmarkerSize [.66,.66];   
		_m setMarkerText "";
	};
}];

if (isPlayer _unit && hasinterface) then {

	zsn_startammo = _unit call zsn_fnc_playerammo; 

	call zsn_fnc_blockmags;

	_unit call zsn_fnc_chambered;

	_unit spawn zsn_fnc_ammoloop;

	_unit spawn zsn_fnc_showgps;

	_unit spawn zsn_fnc_armorshake;

	_unit spawn zsn_fnc_alonewarning;
	
	_unit addAction ["", {hintSilent "You need to be stationary to use your Machine Gun"}, [], 0, false, false, "DefaultAction", "if (getNumber (configFile >> 'CfgMagazines' >> currentmagazine _target >> 'ace_isbelt') == 1 && (ZSN_NerfMG && vehicle _target == _target)) then {speed _target != 0} else {false}"];

	_unit addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		
		_unit call zsn_fnc_chambered;

		_unit spawn zsn_fnc_ammoloop;
		
		_unit spawn zsn_fnc_showgps;

		_unit spawn zsn_fnc_armorshake;

		_unit spawn zsn_fnc_alonewarning;
		
		_unit addAction ["", {hintSilent "You need to be stationary to use your Machine Gun"}, [], 0, false, false, "DefaultAction", "if (getNumber (configFile >> 'CfgMagazines' >> currentmagazine _target >> 'ace_isbelt') == 1 && (ZSN_NerfMG && vehicle _target == _target)) then {speed _target != 0} else {false}"];

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
				case (primaryweapon _unit): {ZSN_PrimaryChambered = true};
				case (handgunweapon _unit): {ZSN_HandgunChambered = true};
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
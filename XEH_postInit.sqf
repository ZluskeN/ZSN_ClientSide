if (isserver) then {
	ticketCounter = (count playableunits)*2;
	publicvariable "ticketCounter";
};
	
zsn_fnc_respawn = {
	private _time = _this select 0;
	private _side = _this select 1;
	playerswitching = true;
	ticketCounter = ticketCounter - 1;
	publicvariable "ticketCounter";
	switch (_side) do {
		case WEST: {"B_Soldier_F" createUnit [[100,0,0], createGroup west, "switcher = this;"];};
		case EAST: {"O_Soldier_F" createUnit [[0,100,0], createGroup east, "switcher = this;"];};
		case GUER: {"I_Soldier_F" createUnit [[100,100,0], createGroup guer, "switcher = this;"];};
	};
	sleep _time;
	selectPlayer switcher;
	playerswitched = true;
	[player, [missionNamespace, 'inventory_var']] call BIS_fnc_loadInventory;
	["Initialize",[player, [playerside], false, false, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
	sleep _time;
	waituntil {ticketCounter > 0};
	player setPos getpos spawnpoint;
	["Terminate"] call BIS_fnc_EGSpectator;
	playerswitched = false;
	playerswitching = false;
};

if (hasInterface) then {
	spawnpoint = "Land_HelipadEmpty_F" createVehicle position player; 
	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	playerswitched = false;
	playerswitching = false;
	[] spawn {
		private _time = random 3;
		while {alive player} do {
			sleep _time;
			if (lifestate player == "INCAPACITATED") then {
				_mytime = time + 10;
				waituntil {lifestate player != "INCAPACITATED" OR time >= _mytime};
				if (lifestate player == "INCAPACITATED") then {
					_oldplayer = player;
					if (!playerswitching) then {[_time, playerSide] spawn zsn_fnc_respawn;};
					[_oldplayer] spawn {
						private _unit = _this select 0;
						waituntil {playerswitched};
						waituntil {lifestate _unit != "INCAPACITATED"};
						if (alive _unit) then {
							ticketCounter = ticketCounter + 1;;
							publicvariable "ticketCounter";
							_unit setdamage 1;
							hideBody _unit;
						} else {
							[player, _unit] call ace_medical_treatment_fnc_placeInBodyBag;
						};
					};
				};
			};
		};
		if (!playerswitching) then {[_time, playerSide] spawn zsn_fnc_respawn;};
	};
};
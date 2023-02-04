params ["_unit","_delay","_mytime"];

if (isPlayer _unit) then {
	_delay = ZSN_UnconsciousTimer;
	_mytime = time + _delay;
	if (_delay > 0) then {
		waituntil {sleep 1; lifestate _unit != "INCAPACITATED" OR time >= _mytime};
		if (lifestate _unit == "INCAPACITATED") then {
			switch (ZSN_UnconsciousAction) do
			{
				case "Nothing": {};
				case "Spectator": {
					titleText ["", "BLACK OUT"];
					["Initialize",[_unit, [playerside], false, false, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
					titleText ["", "BLACK IN"];
					waituntil {lifestate _unit != "INCAPACITATED"};
					titleText ["", "BLACK OUT"];
					["Terminate"] call BIS_fnc_EGSpectator;
					titleText ["", "BLACK IN"];
				};
				case "Respawn": {
					titleText ["", "BLACK OUT"];
					_oldplayer = _unit;
					_grp = creategroup playerside;
					(typeof _oldplayer) createUnit [[random 10, random 10, 0], _grp, "newplayer = this"];
					selectplayer newplayer;
					titleText ["", "BLACK IN"];
					hideBody newplayer;
					newplayer setdamage 1;
					if (isClass(configFile >> "CfgPatches" >> "vurtual_seat")) then {
						[_oldplayer] remoteexec ["zsn_fnc_spawnstretcher", 2];
					};
				};
			};	
		};
	};
};

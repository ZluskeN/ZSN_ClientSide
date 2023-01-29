if (hasinterface) then {
	params ["_delay","_mytime"];
	sleep random 3;
	_delay = ZSN_UnconsciousTimer;
	_mytime = time + _delay;
	if (_delay > 0) then {
		waituntil {lifestate player != "INCAPACITATED" OR time >= _mytime};
		if (lifestate player == "INCAPACITATED") then {
			switch (ZSN_UnconsciousAction) do
			{
				case "Nothing": {};
				case "Spectator": {
					titleText ["", "BLACK OUT"];
					["Initialize",[player, [playerside], false, false, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
					titleText ["", "BLACK IN"];
					waituntil {lifestate player != "INCAPACITATED"};
					titleText ["", "BLACK OUT"];
					["Terminate"] call BIS_fnc_EGSpectator;
					titleText ["", "BLACK IN"];
				};
				case "Respawn": {
					_oldplayer = player;
					_grp = creategroup playerside;
					(typeof _oldplayer) createUnit [[random 10, random 10, 0], _grp, "newplayer = this"];
					selectplayer newplayer;
					hideBody newplayer;
					newplayer setdamage 1;
					[_oldplayer] remoteexec ["zsn_fnc_spawnstretcher", 2];
				};
			};	
		};
	};
};

params ["_unit","_delay","_mytime"];

if (hasInterface) then {
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
					_oldplayer = _unit;
					_oldgrp = group _unit;
					_oldplayer setCaptive true;
					_newgrp = creategroup playerside;
					(typeof _oldplayer) createUnit [[random 10, random 10, 0], _newgrp, "ZSN_newplayer = this"];
					sleep 2;
					selectplayer ZSN_newplayer;
					hideBody ZSN_newplayer;
					ZSN_newplayer setdamage 1;
					[ZSN_newplayer] joinsilent _oldgrp;
					cutText ["", "BLACK IN"];
					[_oldplayer] joinsilent grpNull;
					[_oldplayer] remoteexec ["zsn_fnc_spawnstretcher", 2];
				};
			};	
		};
	};
};

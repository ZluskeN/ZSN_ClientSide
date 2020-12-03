params ["_unit"];
if (leader _unit != _unit) then {_unit unlinkItem "itemMap";};
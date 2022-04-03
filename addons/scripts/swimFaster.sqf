waitUntil {["playerSetupComplete", false] call getPublicVar};
while {true} do
{
	waitUntil { sleep 0.2; alive player && !(player getVariable ["playerSpawning", true]) && [["Aswm","Assw","Absw","Adve","Asdv","Abdv"], animationState player] call fn_startsWith };
	_animSpeed = getAnimSpeedCoef player;
	player setAnimSpeedCoef 2.5;
	waitUntil { !([["Aswm","Assw","Absw","Adve","Asdv","Abdv"], animationState player] call fn_startsWith) };
	player setAnimSpeedCoef 1;
};

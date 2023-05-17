#define build(file) format["%1\%2", _this, file] call mf_compile
#define path(file) format["%1\%2",_this, file]

MF_ITEMS_WORKBENCH = "workbench";
MF_ITEMS_WORKBENCH_CLASS = "Land_Workbench_01_F";
MF_ITEMS_WORKBENCH_DURATION = 10;
_deploy = build("assemble.sqf");
_icon = "client\icons\workbench.paa";
[MF_ITEMS_WORKBENCH, "Workbench", _deploy, "Land_WoodenCrate_01_F", _icon, 2] call mf_inventory_create;

mf_items_is_workbench = {
	_wb = objNull;
	if (cursorObject distance player <= 3) then
	{
		if (typeOf cursorObject == MF_ITEMS_WORKBENCH_CLASS) then
		{
			if (cursorObject getVariable ["a3w_workbench", false]) then
			{
				_wb = cursorObject;
			};
		};
	};
	_wb;
} call mf_compile;

mf_items_workbench_can_disassemble = build("can_disassemble.sqf");

private "_condition";
_condition = "'' == [] call mf_items_workbench_can_disassemble;";
_pack = [format ["<img image='%1'/>Disassemble Workbench", _icon], path("disassemble.sqf"), [], 1, true, false, "", _condition];
["workbench-disassemble", _pack] call mf_player_actions_set;
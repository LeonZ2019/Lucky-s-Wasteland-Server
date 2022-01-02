_text = "
<br/>
<br/>
<t align='left'><t size='1.2'><t shadow= 1 shadowColor='#000000'>Keyboard Shortcuts:</t><br/>
<br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\windows.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Player Names (Windows)</t><br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\end.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Earplugs (End)</t><br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\v.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Parachute / Jump (V)</t><br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\ctrl_v.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Emergency Eject (Ctrl+V)</t><br/><br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\shift_h.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Surrender (Shift+H)</t><br/><br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\backspace.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Detonate (Backspace)</t><br/><br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\tilde.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Player Menu (Tilde)</t><br/><br/>
<t align='left'><img size='1.8' shadow = 0 image='addons\infopage\enter.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Defibrillator (Enter)</t><br/><br/>
<br/>
<t align='left'><t size='1.2'><t shadow= 1 shadowColor='#000000'>Get in contact with us:</t><br/>
<br/>
<t align='left'><img size='1.7' shadow = 0 image='addons\infopage\discord.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'>https://discord.gg/ByZcqZx</t><br/>
<br/>";

player groupChat "Press 'Home' to display Help Message";
hint parseText format ["
<t align='center'>Welcome %1</t><br/>
<t align='center'><t shadow= 1 shadowColor='#000000'><t size='1.2'><t color='#eda92a'>Lucky's Wasteland</t>%2
<br/>
",name player, _text];
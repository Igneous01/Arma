{_x setbehaviour "AWARE"} 
foreach hvtppl; hvtppl ordergetin true; hvtgroup setSpeedMode "FULL";
waitUntil {{_x in suv or _x !alive} foreach hvtppl};
hvtgroup domove getmarkerpos "suvspawn"
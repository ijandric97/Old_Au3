;<Name></Name>					;Required for the info button inside LazyTenno
;<Category></Category>
;<Author></Author>

#NoTrayIcon						;Not required but good to have

$Warframe = "WARFRAME"		 	;Required so you can only take over keyboard and mouse when WF is in focus
$LazyTenno = "LazyTenno"		;Required so scripts can automatically close if LazyTenno somehow crashes

;INSERT YOUR INIT CODE HERE

While WinExists($LazyTenno)
	If WinActive($Warframe) Then
		;INSERT YOUR BOT CODE HERE
	EndIf
WEnd
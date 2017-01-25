;<Name>Rapid Fire</Name>					;Required for the info button inside LazyTenno
;<Category>Weapon</Category>
;<Author>Farming Inc</Author>

#NoTrayIcon						;Not required but good to have

$Warframe = "WARFRAME"		 	;Required so you can only take over keyboard and mouse when WF is in focus
$LazyTenno = "LazyTenno"		;Required so scripts can automatically close if LazyTenno somehow crashes

;INSERT YOUR INIT CODE HERE

While WinExists($LazyTenno)
	If WinActive($Warframe) And _IsPressed(0x04) Then
		MouseDown("left")
		Sleep(10)
		MouseUp("left")
	EndIf
WEnd

Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
	Local $a_R = DllCall($vDLL, "short", "GetAsyncKeyState", "int", '0x' & $sHexKey)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($a_R[0], 0x8000) <> 0
EndFunc
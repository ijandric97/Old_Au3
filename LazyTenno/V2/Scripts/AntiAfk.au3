;<Name>Anti-Afk</Name>
;<Category>Chat</Category>
;<Author>Blacklisted</Author>

$Warframe = "WARFRAME"		 	;Required so you can only take over keyboard and mouse when WF is in focus
$LazyTenno = "LazyTenno"		;Required so scripts can automatically close if LazyTenno somehow crashes

$Default = IniRead(@ScriptDir & "/Settings.ini",@ScriptName,"Order","W,A,S,D")
$Order = InputBox(@ScriptName,"Enter AFK Order",$Default, "", 190, 125)

If @error = 1 Then
	Exit
EndIf

$Default = IniRead(@ScriptDir & "/Settings.ini",@ScriptName,"Delay","350")
$Delay = InputBox(@ScriptName,"Enter AFK Delay",$Default, "", 190, 125)

If @error = 1 Then
	Exit
EndIf

IniWrite(@ScriptDir & "/Settings.ini",@ScriptName,"Order",$Order)
IniWrite(@ScriptDir & "/Settings.ini",@ScriptName,"Delay",$Delay)

$Key = StringSplit($Order,",")

While WinExists($LazyTenno)
	If WinActive($Warframe) Then
		For $i = 1 To UBound($Key)-1 Step 1
			Switch $Key[$i]
				Case "W"
					Send("{w down}")
					Sleep($Delay)
					Send("{w up}")
				Case "A"
					Send("{a down}")
					Sleep($Delay)
					Send("{a up}")
				Case "S"
					Send("{s down}")
					Sleep($Delay)
					Send("{s up}")
				Case "D"
					Send("{d down}")
					Sleep($Delay)
					Send("{d up}")
					MouseClick("left")
			EndSwitch
		Next
	EndIf
WEnd
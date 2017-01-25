;<Name>Generic Warframe Ability Spam</Name>
;<Category>Warframe</Category>
;<Author>Desy</Author>

#NoTrayIcon						;Not required but good to have

$Warframe = "WARFRAME"		 	;Required so you can only take over keyboard and mouse when WF is in focus
$LazyTenno = "LazyTenno"		;Required so scripts can automatically close if LazyTenno somehow crashes

$Default = IniRead(@ScriptDir & "/Settings.ini",@ScriptName,"Order","1,2,3,4")
$Order = InputBox(@ScriptName,"Enter Ability Order",$Default, "", 190, 125)

If @error = 1 Then
	Exit
EndIf

$Default = IniRead(@ScriptDir & "/Settings.ini",@ScriptName,"Delay","500")
$Delay = InputBox(@ScriptName,"Enter Delay",$Default,"",190,125)

If @error = 1 Then
	Exit
EndIf

IniWrite(@ScriptDir & "/Settings.ini",@ScriptName,"Order",$Order)
IniWrite(@ScriptDir & "/Settings.ini",@ScriptName,"Delay",$Delay)

$Abilites = StringSplit($Order,",")

While WinExists($LazyTenno)
	If WinActive($Warframe) Then
		For $i = 1 To UBound($Abilites)-1 Step 1
			Switch $Abilites[$i]
				Case "1"
					Send("{1}")
				Case "2"
					Send("{2}")
				Case "3"
					Send("{3}")
				Case "4"
					Send("{4}")
			EndSwitch
		Next
	EndIf
	Sleep($Delay)
WEnd
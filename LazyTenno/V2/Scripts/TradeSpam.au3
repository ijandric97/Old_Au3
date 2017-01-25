;<Name>Trade Spam</Name>
;<Category>Chat</Category>
;<Author>Desy</Author>

$Warframe = "WARFRAME"		 	;Required so you can only take over keyboard and mouse when WF is in focus
$LazyTenno = "LazyTenno"		;Required so scripts can automatically close if LazyTenno somehow crashes

$Default = IniRead(@ScriptDir & "/Settings.ini",@ScriptName,"Text","WTS Your MOM Prime 0 Plat")
$Text = InputBox(@ScriptName,"Enter Spam Message",$Default, "", 190, 125)

If @error = 1 Then
	Exit
EndIf
IniWrite(@ScriptDir & "/Settings.ini",@ScriptName,"Text",$Text)

While WinExists($LazyTenno)
	If WinActive($Warframe) Then
		Sleep(100)
		Send("{T}") ;Open Chat
		Sleep(100)
		Send($Text,1)
		Send("{ENTER}")
		Send("{ESC}")
	EndIf
	Sleep(130000)
WEnd
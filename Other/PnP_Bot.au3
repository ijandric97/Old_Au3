Global $BotRunning = False
Global $GameName = "[CLASS:UnityWndClass]"
Global $BotName = "Pen And Paper XP Bot"
Global $Tray = "[CLASS:Shell_TrayWnd]"
Global $Notify = "[CLASS:TrayNotifyWnd]"
Global $BotList[6] = ["XP Potion Buy","Potion User","Buff1","Buff2","Buff3","Buff4"]
Global $SelectedBot = $BotList[0]
Opt("MouseCoordMode",0)
HotKeySet("{F11}", "Bot_Exit")
HotKeySet("{F10}", "Bot_StartStop")
HotKeySet("{F9}", "Bot_Select")

While 1
	If $BotRunning = True Then
		If $SelectedBot = $BotList[0] Then
			WinActivate($GameName)
			MouseClick("left",180,405,1,0)
			MouseClick("left",500,405,1,0)
		EndIf
		If $SelectedBot = $BotList[1] Then
			WinActivate($GameName)
			MouseClick("left",540,590,1,0)
			MouseClick("left",410,510,1,0) ;410,380
			MouseClick("left",500,410,1,0)
		EndIf
		If $SelectedBot = $BotList[2] Then
			WinActivate($GameName)
			MouseClick("left",330,340,1,0)
			Bot_Buff()
		EndIf
		If $SelectedBot = $BotList[3] Then
			WinActivate($GameName)
			MouseClick("left",400,340,1,0)
			Bot_Buff()
		EndIf
		If $SelectedBot = $BotList[4] Then
			WinActivate($GameName)
			MouseClick("left",470,340,1,0)
			Bot_Buff()
		EndIf
		If $SelectedBot = $BotList[5] Then
			WinActivate($GameName)
			MouseClick("left",540,340,1,0)
			Bot_Buff()
		EndIf
	EndIf
WEnd
#region BOT
Func Bot_Buff()
	MouseClick("left",545,420,1,0)
	MouseClick("left",430,405,1,0)
EndFunc
Func Bot_Exit()
	ToolTip_Show("Bot Stopped",0,0,$BotName)
	Sleep(1000)
	Exit
EndFunc
Func Bot_StartStop()
	If $BotRunning = False Then
		$BotRunning = True
		ToolTip_Show("Bot Started",0,0,$BotName)
	Else
		$BotRunning = False
		ToolTip_Show("Bot Stopped",0,0,$BotName)
	EndIf
EndFunc
Func Bot_Select()
	If $SelectedBot = $BotList[UBound($BotList)-1] Then
		$SelectedBot = $BotList[0]
	Else
		For $i=0 to UBound($BotList)-1 Step +1
			If $SelectedBot = $BotList[$i] Then
				$a = $i ;Because $i will increase, so you need to copy it, because of this if loop wont be repeated ever again
			EndIf
		Next
		$SelectedBot = $BotList[$a+1]
	EndIf
	ToolTip_Show("Selected Bot: "&$SelectedBot,0,0,$BotName)
EndFunc
#endregion
#region ToolTip
Func ToolTip_Hide()
	ToolTip("")
	AdlibUnRegister("ToolTip_Hide")
EndFunc
Func ToolTip_Show($Text,$X,$Y,$Title)
	AdlibUnRegister("ToolTip_Hide")
	ToolTip($Text,$X,$Y,$Title)
	AdlibRegister("ToolTip_Hide",2000)
EndFunc
#endregion
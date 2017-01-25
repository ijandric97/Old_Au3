#Region Declarations
$IsStarted = False
$PicPath = @TempDir & "\FI.jpg"
$AboutInfo = @CRLF&".:LaZy TeNnO:."&@CRLF&@CRLF&'Farming Inc. (B+D)'&@CRLF& _
"VER: 0.1 BETA"&@CRLF&"REL: 24.8.2106."
$AboutHelp = "Made for: Win7-10 32/64Bit"&@CRLF&"Warframe "& _
"Windowed Mode"&@CRLF&"If you need more information, visit link below."
$Website = ""
$IniPath = "LazyTenno.ini"
$Warframe = "WARFRAME"
#EndRegion

$hDll = DllOpen("user32.dll")
#Region INIT
FileInstall("FI.jpg",$PicPath)
HotKeySet("{F11}", "Terminate")
#EndRegion

#Region Form
$Gui = GUICreate("LazyTenno™",280,173)
$GuiTab = GuiCtrlCreateTab(0,0,282,174)
$GuiTabChat = GUICtrlCreateTabItem("Trading Chat")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CHAT
$ChatTextLabel = GUICtrlCreateLabel("Text:",8,45,54,20)
$ChatText = GUICtrlCreateInput(IniRead($IniPath,"Chat","Text",""),41,42,225,20)
$ChatDelayLabel = GuiCtrlCreateLabel("Timer:",8,75,64,20)
$ChatDelay = GUICtrlCreateInput(IniRead($IniPath,"Chat","Delay","130000"),41,72,50,20)
$ChatDelayDefault = GuiCtrlCreateLabel("<- Default",95,75,64,20)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FRAME
$GuiTabFrame = GUICtrlCreateTabItem("Tenno")
$FrameOrderLabel = GUICtrlCreateLabel("Ability Order:",8,35,64,20)
$FrameOrder = GUICtrlCreateInput(IniRead($IniPath,"Frame","Order","1,2,3,4"),79,32,50,20)
$FrameOrderExpla = GUICtrlCreateLabel("Warframe Skill 1-4",140,35,140,20)
$FrameDelay1Label = GuiCtrlCreateLabel("Ability Time:",8,55,64,20)
$FrameDelay1 = GUICtrlCreateInput(IniRead($IniPath,"Frame","Delay1","500"),79,52,50,20)
$FrameTimeExpla = GUICtrlCreateLabel("Duration of Skill 1",140,55,140,20)
$FrameDelay2Label = GuiCtrlCreateLabel("Ability Time:",8,75,64,20)
$FrameDelay2 = GUICtrlCreateInput(IniRead($IniPath,"Frame","Delay2","500"),79,72,50,20)
$FrameTimeExpla = GUICtrlCreateLabel("Duration of Skill 2",140,75,140,20)
$FrameDelay3Label = GuiCtrlCreateLabel("Ability Time:",8,95,64,20)
$FrameDelay3 = GUICtrlCreateInput(IniRead($IniPath,"Frame","Delay3","500"),79,92,50,20)
$FrameTimeExpla = GUICtrlCreateLabel("Duration of Skill 3",140,95,140,20)
$FrameDelay4Label = GuiCtrlCreateLabel("Ability Time:",8,115,64,20)
$FrameDelay4 = GUICtrlCreateInput(IniRead($IniPath,"Frame","Delay4","500"),79,112,50,20)
$FrameTimeExpla = GUICtrlCreateLabel("Duration of Skill 4",140,115,140,20)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;AFK
$GuiTabAFK = GUICtrlCreateTabItem("AFK")
$AFKLabel = GUICtrlCreateLabel("Move me (I'm away):",8,35,140,20)
$AFKOrder = GUICtrlCreateInput(IniRead($IniPath,"AFK","Order","W,A,S,D"),115,32,65,20)
$AFKDelay = GUICtrlCreateInput(IniRead($IniPath,"AFK","Delay","350"),115,52.5,40,20)
$AFKDelayLabel = GuiCtrlCreateLabel("Sleep Delay:",8,55,140,20)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ABOUT
$GuiTabAbout = GUICtrlCreateTabItem("About")
GUICtrlSetState($GuiTabAbout, 16)
$AboutPic = GuiCtrlCreatePic($PicPath,1,22,90,90)
$AboutInfoLabel = GUICtrlCreateLabel($AboutInfo,91,22,178,90,0x01)
$AboutHelpLabel = GuiCtrlCreateLabel($AboutHelp,1,112,268,40,0x01)
$AboutUpdateBtn = GUICtrlCreateButton("Visit Official Site",1,152,268,20)
GuiCtrlSetcolor($AboutHelpLabel, 0xFF0000)
GUICtrlCreateTabItem("")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GUI
$GuiBtn = GUICtrlCreateButton("Start",203,0.9,77,20)
GUISetState(@SW_SHOW)
#EndRegion Form

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case -3
			Terminate()
		Case $GuiBtn
			Bot_Init()
		Case $AboutUpdateBtn
			ShellExecute($Website)
	EndSwitch
Wend

#Region BOT
Func Bot_Init()
	If $IsStarted = False Then
		$SelectedBot = GUICtrlRead($GuiTab)
		Switch $SelectedBot
			Case 0
				$IsStarted = True
				GUICtrlSetData($GuiBtn,"Stop")
				AdlibRegister("Bot_Chat", GuiCtrlRead($ChatDelay))
			Case 1
				$IsStarted = True
				GUICtrlSetData($GuiBtn,"Stop")
				AdlibRegister("Bot_Frame", 100)
			Case 2
				$IsStarted = True
				GUICtrlSetData($GuiBtn,"Stop")
				AdlibRegister("Bot_AFK", 100)
			Case Else
				MsgBox(16,"LazyTenno™","You didn`t select a bot!")
		EndSwitch
	Else
		$IsStarted = False
		GUICtrlSetData($GuiBtn,"Start")
	EndIf
EndFunc
Func Bot_Chat()
	If $IsStarted = True Then
		If WinActive($Warframe) Then
			Sleep(100)
			Send("{T}") ;Open Chat
			Sleep(100)
			Send(GUICtrlRead($ChatText),1)
			Send("{ENTER}")
			Send("{ESC}")
		EndIf
	Else
		AdlibUnRegister("Bot_Chat")
	EndIf
EndFunc
Func Bot_Frame()
	If $IsStarted = True Then
		If WinActive($Warframe) Then
			$Abilites = StringSplit(GuiCtrlRead($FrameOrder),",")
			For $i = 0 To UBound($Abilites)-1 Step 1
				Switch $Abilites[$i]
					Case "1"
						Send("{1}")
						Sleep(GuiCtrlRead($FrameDelay1))
					Case "2"
						Send("{2}")
						Sleep(GuiCtrlRead($FrameDelay2))
					Case "3"
						Send("{3}")
						Sleep(GuiCtrlRead($FrameDelay3))
					Case "4"
						Send("{4}")
						Sleep(GuiCtrlRead($FrameDelay4))
				EndSwitch
			Next
		EndIf
	Else
		AdlibUnRegister("Bot_Frame")
	EndIf
EndFunc
Func Bot_AFK()
	If $IsStarted = True Then
		If WinActive($Warframe) Then
			$Abilites = StringSplit(GuiCtrlRead($AFKOrder),",")
			For $i = 0 To UBound($Abilites)-1 Step 1
				Switch $Abilites[$i]
			Case "W"
				Send("{w down}")
			    Sleep(GuiCtrlRead($AFKDelay))
			    Send("{w up}")
			Case "A"
				Send("{a down}")
			    Sleep(GuiCtrlRead($AFKDelay))
			    Send("{a up}")
			Case "S"
			    Send("{s down}")
			    Sleep(GuiCtrlRead($AFKDelay))
			    Send("{s up}")
			Case "D"
				Send("{d down}")
			    Sleep(GuiCtrlRead($AFKDelay))
			    Send("{d up}")
				MouseClick("left")
			EndSwitch
			Next
		EndIf
	Else
    AdlibUnRegister("Bot_AFK")
EndIf
EndFunc
;Func Bot_Rapid()
	;If $IsStarted = True Then
		;If WinActive($Warframe) Then

			;While 1
				;If _ispressed("04", $hdll) Then
					;MouseDown("left")
					;Sleep(10)
					;MouseUp("left")
					;EndIf
                ;Wend

;EndIf
;EndFunc
Func Terminate()
	FileDelete($PicPath)
	IniWrite($IniPath,"Chat","Text",GuiCtrlRead($ChatText))
	IniWrite($IniPath,"Chat","Delay",GuiCtrlRead($ChatDelay))
	IniWrite($IniPath,"Frame","Order",GuiCtrlRead($FrameOrder))
	IniWrite($IniPath,"Frame","Delay1",GuiCtrlRead($FrameDelay1))
	IniWrite($IniPath,"Frame","Delay2",GuiCtrlRead($FrameDelay2))
	IniWrite($IniPath,"Frame","Delay3",GuiCtrlRead($FrameDelay3))
	IniWrite($IniPath,"Frame","Delay4",GuiCtrlRead($FrameDelay4))
    IniWrite($IniPath,"AFK","Order",GuiCtrlRead($AFKOrder))
	IniWrite($IniPath,"AFK","Delay",GuiCtrlRead($AFKDelay))
	Send("{w up}")
	Send("{a up}")
	Send("{s up}")
	Send("{d up}")
	Exit
EndFunc
#EndRegion BOT
#Region Misc
Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), 1) = 4
EndFunc
#EndRegion Misc
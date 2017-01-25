SELECT
CASE WINEXISTS("NEED FOR SPEED™ WORLD","")=0
GUISETSTATE(@SW_HIDE)
MSGBOX(16,"Error","You need to run NFS World first !")
EXIT
ENDSELECT

GLOBAL CONST $GUI_EVENT_CLOSE=-3
GLOBAL CONST $GUI_EVENT_MINIMIZE=-4
GLOBAL CONST $GUI_EVENT_RESTORE=-5
GLOBAL CONST $GUI_EVENT_MAXIMIZE=-6
GLOBAL CONST $GUI_EVENT_PRIMARYDOWN=-7
GLOBAL CONST $GUI_EVENT_PRIMARYUP=-8
GLOBAL CONST $GUI_EVENT_SECONDARYDOWN=-9
GLOBAL CONST $GUI_EVENT_SECONDARYUP=-10
GLOBAL CONST $GUI_EVENT_MOUSEMOVE=-11
GLOBAL CONST $GUI_EVENT_RESIZED=-12
GLOBAL CONST $GUI_EVENT_DROPPED=-13
GLOBAL CONST $GUI_RUNDEFMSG="GUI_RUNDEFMSG"
DIM $COUNT=0
LOCAL $MSG
GUICreate("Fuck The World Mystery Card BOT", 258, 106, 278, 154)
GUICtrlCreateTab(8, 8, 244, 88)
GUICtrlCreateTabItem("BOT")
GUICtrlCreateLabel("How much packs to buy?", 16, 40, 141, 19)
$ICOUNTR = GUICtrlCreateInput("100", 160, 40, 41, 22)
$GO = GUICtrlCreateButton("Go!", 208, 40, 35, 17)
GUICtrlCreateLabel("I reccomend 110 for performance, 180 for skills pack.", 16, 64, 231, 16)
GUICtrlSetFont(-1, 7, 400, 0, "Arial")
GUICtrlCreateTabItem("About")
GUICtrlCreateLabel("FTW Mystery Card Bot V1.0 | Build 4 | 26.8.2012.", 16, 40, 212, 16)
GUICtrlSetFont(-1, 7, 400, 0, "Arial")
GUICtrlCreateLabel("BOT/GUI by Desy | THX Serial for providing FTW bot", 16, 56, 229, 16)
GUICtrlSetFont(-1, 7, 400, 0, "Arial")
GUICtrlCreateLabel("source. Used some, but not all parts of it.", 16, 72, 180, 16)
GUICtrlSetFont(-1, 7, 400, 0, "Arial")
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $GO
			GUISETSTATE(@SW_HIDE)
			WHILE 1=1
			$COUNT=$COUNT+1
			CONTROLCLICK("NEED FOR SPEED™ WORLD","","","left",1,702,494)
			SLEEP(200)
			CONTROLCLICK("NEED FOR SPEED™ WORLD","","","left",1,140,494)
			SLEEP(2000)
			IF $COUNT=GUICTRLREAD($ICOUNTR)THEN
			MSGBOX(64,"FTW MC BOT","Spent you're money!")
			Exit
ENDIF
WEND
ENDSWITCH
WEND
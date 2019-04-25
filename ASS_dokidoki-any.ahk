#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn, All  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Pixel
CoordMode, Mouse

natsukiPoemWords := []
Loop, Read, .\ASS_dokidoki-any_resources\act1_natsuki_poemwords.txt
{
	natsukiPoemWords.Push(A_LoopReadLine)
}

composePoem(member) {
	global
	
	jumpWordsPicked := 0
	if (member = "natsuki")
	{
		Loop, 20 {
			if (jumpWordsPicked < 10) {
				for i, poemWord in natsukiPoemWords
				{
					ImageSearch, FoundX, FoundY, 633, 190, 1333, 848, .\ASS_dokidoki-any_resources\poem_words\%poemWord%.png
					if (ErrorLevel = 0) {
						Click, %FoundX%, %FoundY%
						MouseMove, 291, 586
						jumpWordsPicked++
						break
					}
				}
			}
			if (ErrorLevel != 0 || jumpWordsPicked >= 10) {
				Click, 692, 285
				MouseMove, 291, 586
			}
		}
	}
	else
	{
		MsgBox % "Error, ''" . %member% . "'' is not a valid target for poems"
		ExitApp
	}
	MouseMove, 74, 930
}

saveGame(slot)
{
	Sleep, 50
	Send, {Escape}
	Sleep, 300
	if (slot = 1)
	{
		Click, 751, 432
	}
	else if (slot = 2)
	{
		Click, 1172, 432
	}
	else if (slot = 3)
	{
		Click, 1551, 432
	}
	else if (slot = 4)
	{
		Click, 751, 725
	}
	else if (slot = 5)
	{
		Click, 1172, 725
	}
	else if (slot = 6)
	{
		Click, 1551, 725
	}
	else
	{
		MsgBox, Slot '%slot%' not valid
		ExitApp
	}
	Sleep, 50
	Send, {Escape}
	Sleep, 300
	MouseMove, 74, 930
}

loadGame(slot) {
	Sleep, 50
	Send, {Escape}
	Sleep, 300
	Click, 202, 652
	Sleep, 50
	if (slot = 1)
	{
		Click, 751, 432
	}
	else if (slot = 2)
	{
		Click, 1172, 432
	}
	else if (slot = 3)
	{
		Click, 1551, 432
	}
	else if (slot = 4)
	{
		Click, 751, 725
	}
	else if (slot = 5)
	{
		Click, 1172, 725
	}
	else if (slot = 6)
	{
		Click, 1551, 725
	}
	else
	{
		MsgBox, Slot '%slot%' not valid
		ExitApp
	}
	Sleep, 50
	Send, {Right}{Enter}
	Sleep, 300
	MouseMove, 74, 930
}

skipNextChoice() {
	Click, right, 872, 1002
	Send, {Right}{Enter}
	MouseMove, 74, 930
}

p::
	;I'll let you guess what this does
	Run, .\DDLC.exe
	
	;Wait for DDLC window to exist before switching to and maximizing it
	Loop {
		if WinExist("ahk_exe DDLC.exe") {
			WinActivate, ahk_exe DDLC.exe
			WinMaximize
			MouseMove, 74, 930
			break
		}
		Sleep, 25
	}
	
	;Agree to terms
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_dokidoki-any_resources\terms_agree.png
		if (ErrorLevel = 0) {
			Send, {Up}{Enter}
			break
		}
		Send, {Enter}
		Sleep, 15
	}
	
	;New Game Act 1
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_dokidoki-any_resources\new-game_act1.png
		if (ErrorLevel = 0) {
			Send, {Down 3}{Enter}
			Send, {Left 2}{Right}{Up 2}{Right}{Enter}{Up}{Enter}
			Send, {Escape}{Down}{Enter}
			break
		}
	}
	
	;Naming Protagonist
	Send, ASSBot
	Send, {Down}{Enter}
	
	
	;START OF ACT 1
	
	Send, {Ctrl down}
	Sleep, 50
	Send, {Ctrl up}
	
	;Start timer
	Send, {Numpad1}
	
	;Skip through day
	skipNextChoice()
	Sleep, 500
	Loop {
		;Check for poem tutorial
		PixelSearch, xColour, yColour, 1360, 495, 1360, 495, 0xF4E6FF, 0, Fast
		if (ErrorLevel = 0) {
			Send, {Ctrl up}
			Send, {Down}{Enter}
			break
		}
	}
	
	
	;ACT 1, POEM 1
	;Rush through poem composition
	Loop, 20 {
		Sleep, 1
		Click, 692, 285
	}
	Send, {Ctrl}
	
	;Skip through day until the 'poem showing' screen comes up.
	skipNextChoice()
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_first.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	Loop {
		PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
		if (ErrorLevel = 0) {
			Sleep, 50
			Send, {Ctrl down}
			Sleep, 50
			Send, {Ctrl up}
			break
		}
	}
	skipNextChoice()
	
	Loop, 3 {
		Loop {
			ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_next.png
			if (ErrorLevel = 0) {
				skipNextChoice()
				Send, {Up 2}{Enter}
				break
			}
		}
		Loop {
			PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
			if (ErrorLevel = 0) {
				Sleep, 50
				Send, {Ctrl down}
				Sleep, 50
				Send, {Ctrl up}
				break
			}
		}
		skipNextChoice()
	}
	
	;Fight happens
	;Will pick Yuri (this choice doesn't affect anything in the game other than dialogue)
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\fight.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 3}{Enter}
			break
		}
	}
	
	
	;ACT 1, POEM 2
	;Rush through poem composition
	Loop, 20 {
		Sleep, 1
		Click, 692, 285
	}
	Send, {Ctrl}
	
	;Skip through day until the 'poem showing' screen comes up.
	skipNextChoice()
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_first.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	Loop {
		PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
		if (ErrorLevel = 0) {
			Sleep, 50
			Send, {Ctrl down}
			Sleep, 50
			Send, {Ctrl up}
			break
		}
	}
	skipNextChoice()
	
	Loop, 3 {
		Loop {
			ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_next.png
			if (ErrorLevel = 0) {
				skipNextChoice()
				Send, {Up 2}{Enter}
				break
			}
		}
		Loop {
			PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
			if (ErrorLevel = 0) {
				Sleep, 50
				Send, {Ctrl down}
				Sleep, 50
				Send, {Ctrl up}
				break
			}
		}
		skipNextChoice()
	}
	
	;Sayori asks us who we would go home with
	;Will pick Sayori (this choice doesn't affect anything in the game other than dialogue)
	Loop {
		ImageSearch, FoundX, FoundY, 649, 401, 1266, 526, .\ASS_dokidoki-any_resources\walkhomewithsayori.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	
	
	;ACT 1, POEM 3
	;Rush through poem composition
	Loop, 20 {
		Sleep, 1
		Click, 692, 285
	}
	Send, {Ctrl}
	
	;Skip through day until the 'poem showing' screen comes up.
	skipNextChoice()
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_first.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	Loop {
		PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
		if (ErrorLevel = 0) {
			Sleep, 50
			Send, {Ctrl down}
			Sleep, 50
			Send, {Ctrl up}
			break
		}
	}
	skipNextChoice()
	
	Loop, 2 {
		Loop {
			ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_next.png
			if (ErrorLevel = 0) {
				skipNextChoice()
				Send, {Up 2}{Enter}
				break
			}
		}
		Loop {
			PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
			if (ErrorLevel = 0) {
				Sleep, 50
				Send, {Ctrl down}
				Sleep, 50
				Send, {Ctrl up}
				break
			}
		}
		skipNextChoice()
	}
	
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_next.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	skipNextChoice()
	
	;We get the option of who to help with the festival
	;Will pick Yuri (this choice only affects which CG you'll get, which we don't care about)
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\imgoingwith.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 4}{Enter}
			break
		}
	}
	skipNextChoice()
	
	;We get the option to either cuck or confess to Sayori
	;Will pick confess because it has a much lower dialogue count compared to cucking
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\sayori_confession.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	
	;ACT 1, FINAL STRETCH
	
	;Skip Sayori poem
	Loop {
		PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
		if (ErrorLevel = 0) {
			Sleep, 50
			Send, {Ctrl down}
			Sleep, 50
			Send, {Ctrl up}
			break
		}
	}
	skipNextChoice()
	
	;Skip through rest of act until start of act 2
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_dokidoki-any_resources\new-game_act2.png
		if (ErrorLevel = 0) {
			break
		}
	}
	
	
	
	;START OF ACT 2
	;New Game Act 2
	Send, {Down}{Enter}
	Send, {Ctrl}
	skipNextChoice()
	Sleep, 1000
	
	;Select 'No' at special poem box
	Loop {
		PixelSearch, xColour, yColour, 929, 571, 929, 571, 0xF4E6FF, 0, Fast
		if (ErrorLevel = 0) {
			Send, {Right 2}{Enter}
			break
		}
	}
	
	;Wait until the poem composition screen is reached
	Loop {
		PixelSearch, xColour, yColour, 214, 420, 214, 420, 0xC7C7C7, 0, Fast
		if (ErrorLevel = 0) {
			break
		}
	}
	
	
	;ACT 2, POEM 1
	;Rush through poem composition
	composePoem("natsuki")
	Send, {Ctrl}
	
	;Skip through day until the 'poem showing' screen comes up.
	skipNextChoice()
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_first.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	Loop {
		PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
		if (ErrorLevel = 0) {
			Sleep, 50
			Send, {Ctrl down}
			Sleep, 50
			Send, {Ctrl up}
			break
		}
	}
	skipNextChoice()
	
	Loop, 2 {
		Loop {
			ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_next.png
			if (ErrorLevel = 0) {
				skipNextChoice()
				Send, {Up 2}{Enter}
				break
			}
		}
		Loop {
			PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
			if (ErrorLevel = 0) {
				Sleep, 50
				Send, {Ctrl down}
				Sleep, 50
				Send, {Ctrl up}
				break
			}
		}
		skipNextChoice()
	}
	
	;Skip through day until we get the option of who to back up in a glitched fight.
	Loop {
		PixelSearch, xColour, yColour, 905, 448, 905, 448, 0xF4E6FF, 2, Fast
		if (ErrorLevel = 0) {
			break
		}
	}
	
	;Pick whoever gets highlighted as this option doesn't actually affect anything in the game
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_dokidoki-any_resources\fight_glitched_monika.png
		if (ErrorLevel = 0) {
			Send, {Enter}
			break
		}
		Send, {Down 2}{Enter}
		Sleep, 15
	}
	
	;Skip through normally until skip button becomes visible
	Send, {Ctrl down}
	Loop {
		PixelSearch, xColour, yColour, 1447, 326, 1447, 326, 0xC1CEE9, 2, Fast
		if (ErrorLevel = 0) {
			break
		}
	}
	Send, {Ctrl up}
	skipNextChoice()
	
	;Wait until the poem composition screen is reached
	Loop {
		PixelSearch, xColour, yColour, 214, 420, 214, 420, 0xC7C7C7, 0, Fast
		if (ErrorLevel = 0) {
			break
		}
	}
	
	
	;ACT 2, POEM 2
	;Rush through poem composition
	Loop, 20 {
		Sleep, 1
		Click, 692, 285
	}
	Send, {Ctrl}
	
	;Skip through day until the 'poem showing' screen comes up.
	skipNextChoice()
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_first.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	Loop {
		PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
		if (ErrorLevel = 0) {
			Sleep, 50
			Send, {Ctrl down}
			Sleep, 50
			Send, {Ctrl up}
			break
		}
	}
	skipNextChoice()
	Sleep, 500
	
	;Wait for "Please help me." box
	Loop {
		PixelSearch, xColour, yColour, 949, 516, 949, 516, 0xF4E6FF, 10, Fast
		if (ErrorLevel = 0) {
			Send, {Right}{Enter}
			break
		}
	}
	skipNextChoice()
	
	Loop, 2 {
		Loop {
			ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_next.png
			if (ErrorLevel = 0) {
				skipNextChoice()
				Send, {Up 2}{Enter}
				break
			}
		}
		Loop {
			PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
			if (ErrorLevel = 0) {
				Sleep, 50
				Send, {Ctrl down}
				Sleep, 50
				Send, {Ctrl up}
				break
			}
		}
		skipNextChoice()
	}
	
	Sleep, 50
	
	;Select 'No' at special poem box
	Loop {
		PixelSearch, xColour, yColour, 929, 571, 929, 571, 0xF4E6FF, 0, Fast
		if (ErrorLevel = 0) {
			Sleep, 100
			Send, {Right 2}{Enter}
			break
		}
	}
	Send, {Ctrl down}
	Sleep, 50
	Send, {Ctrl up}
	skipNextChoice()
	
	;Wait until the poem composition screen is reached
	Loop {
		PixelSearch, xColour, yColour, 214, 420, 214, 420, 0xC7C7C7, 0, Fast
		if (ErrorLevel = 0) {
			break
		}
	}
	
	;ACT 2, POEM 3
	;Rush through poem composition
	Loop, 20 {
		Sleep, 1
		Click, 692, 285
	}
	Send, {Ctrl}
	
	;Skip through day until the 'poem showing' screen comes up.
	skipNextChoice()
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_first.png
		if (ErrorLevel = 0) {
			skipNextChoice()
			Send, {Up 2}{Enter}
			break
		}
	}
	
	Loop, 2 {
		Loop {
			ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\poem_next.png
			if (ErrorLevel = 0) {
				skipNextChoice()
				Send, {Up 2}{Enter}
				break
			}
		}
		Loop {
			PixelSearch, xColour, yColour, 1472, 112, 1472, 112, 0xFFFFFF, 10, Fast
			if (ErrorLevel = 0) {
				Sleep, 50
				Send, {Ctrl down}
				Sleep, 50
				Send, {Ctrl up}
				break
			}
		}
		skipNextChoice()
	}
	
	;Skip through day until "Just Monika." shows up
	Loop {
		ImageSearch, FoundX, FoundY, 404, 823, 1240, 1003, .\ASS_dokidoki-any_resources\just-monika.png
		if (ErrorLevel = 0) {
			Send, {Up 2}{Enter}
			Sleep, 100
			Send, {Right}{Enter}
			Send, {Ctrl}
			break
		}
	}
	
	;Wait for blank special poem box to show up
	Loop {
		PixelSearch, xColour, yColour, 929, 571, 929, 571, 0xF4E6FF, 0, Fast
		if (ErrorLevel = 0) {
			Sleep, 50
			Send, {Right 2}{Enter}
			Sleep, 50
			Send, {Ctrl down}
			Sleep, 50
			Send, {Ctrl up}
			break
		}
	}

	;Skip through day until we get the option to pick who to help with the poetry performance.
	;Will pick Monika, since she forces you to pick her even if you pick one of the other members
	skipNextChoice()
	Sleep, 500
	Loop {
		PixelSearch, xColour, yColour, 960, 502, 960, 502, 0xF4E6FF, 0, Fast
		if (ErrorLevel = 0) {
			Send, {Down 3}{Enter}
			break
		}
	}
	
	;Skip through day until we get the option to either deny or confess to Yuri
	;Will pick confess since this choice affects LITERALLY nothing, not even any of the dialogue changes
	skipNextChoice()
	Loop {
		PixelSearch, xColour, yColour, 678, 358, 678, 358, 0xF4E6FF, 0, Fast
		if (ErrorLevel = 0) {
			Send, {Down}{Enter}
			break
		}
	}
	
	;Skip through dialogue until Yuri death scene appears
	Send, {Ctrl down}
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_dokidoki-any_resources\yuri_death.png
		if (ErrorLevel = 0) {
			Send, {Ctrl up}
			break
		}
	}
	Sleep, 500
	
	saveGame(1)
	
	;Skip through Yuri death scene via loading the save we just made
	Loop {
		PixelSearch, xColour, yColour, 542, 786, 542, 786, 0x9955BB, 0, Fast
		if (ErrorLevel = 0) {
			loadGame(1)
		} else if (ErrorLevel = 1) {
			PixelSearch, xColour, yColour, 1839, 829, 1839, 829, 0x2C3254, 10, Fast
			if (ErrorLevel = 0) {
				break
			}
		}
	}
	
	;Click through day until the start of act 3 (skip doesn't work here)
	Loop {
		ImageSearch, FoundX, FoundY, 303, 683, 1561, 1021, .\ASS_dokidoki-any_resources\monika_start-of-act-3.png
		if (ErrorLevel = 0) {
			break
		}
		Send, {Enter}
		Sleep, 1
		Send, {Click}
		Sleep, 15
	}
	
	
	
	;START OF ACT 3
	;Click through dialogue until Monika CG (skip doesn't work here either)
	Loop {
		PixelSearch, xColour, yColour, 986, 370, 986, 370, 0x2B4ACB, 10, Fast
		if (ErrorLevel = 0) {
			break
		}
		Send, {Enter}
		Sleep, 30
	}
	
	;Immediately go to windows explorer and delete her character file
	Run, %A_WinDir%\explorer.exe
	Loop {
		if WinExist("ahk_exe explorer.exe") {
			WinActivate, ahk_exe explorer.exe
			break
		}
		Sleep, 25
	}
	Sleep, 250
	Send, !d
	Send, %A_ScriptDir%\characters{Enter}
	Sleep, 500
	Loop, 2 {
		Send, {Down}
		Send, {Delete}
		Send, {F5}
		Sleep, 250
	}
	WinClose, A
	WinActivate, ahk_exe DDLC.exe
	Sleep, 100
	
	;Click through the "I still love you, no matter what" dialogue with Monika while waiting for act 4 main menu
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_dokidoki-any_resources\new-game_act1.png
		if (ErrorLevel = 0) {
			break
		}
		Send, {Enter}
		Sleep, 30
	}
	
	
	
	;START OF ACT 4
	;New Game Act 4
	Send, {Down}{Enter}
	Send, {Ctrl}
	skipNextChoice()
	Sleep, 250
	
	;Skip through act until skip button gets disabled
	skipNextChoice()
	Loop {
		PixelSearch, xColour, yColour, 959, 603, 959, 603, 0xF4E6FF, 0, Fast
		if (ErrorLevel = 0) {
			break
		}
	}
	
	Send, {Right}{Enter}
	Sleep, 50
	skipNextChoice()
	Sleep, 50
	Send, {Right}{Enter}
	Sleep, 50
	skipNextChoice()
	Sleep, 50
	Send, {Right}{Enter 5}
	Sleep, 50
	skipNextChoice()
	
	;Stop timer
	Sleep, 1000
	Send, {Numpad1}
return

;Emergency exit in case the script goes wild and starts doing things that I don't want it to do
[::
	ExitApp
return
^[::
	Send, {Ctrl up}
	ExitApp
return

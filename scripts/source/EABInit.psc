Scriptname EABInit extends Quest  

Quest Property EcchinaArmorBreak  Auto  

Event OnInit()
	if !(EcchinaArmorBreak.IsRunning())
		EcchinaArmorBreak.Start()
	endif
EndEvent
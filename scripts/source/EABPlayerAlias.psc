Scriptname EABPlayerAlias extends ReferenceAlias  

Form PreSource = None

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	if (abHitBlocked || PreSource ==  akSource)
		return
	endif

	GotoState("Busy")
	
	if (Utility.RandomInt() > EABRate.GetValue())
		return
	endif
	
	PreSource = akSource
	Actor selfact = self.GetActorRef()

	int rndintRP = Utility.RandomInt()
	int rndintAB = Utility.RandomInt()
	
	Form[] armors = Ecchina_Utility.GetEeuippedArmors(selfact)

	if (armors)
		int idx = Utility.RandomInt(0, armors.Length - 1)
		Form targetItem = armors[idx]
		if (targetItem.HasKeyWord(ArmorClothing) || targetItem.HasKeyWord(ArmorHeavy) || targetItem.HasKeyWord(ArmorLight) || \
			(EABEnableJewelry.GetValue() == 1 && targetItem.HasKeyWord(ArmorJewelry)))
			
			if (EABBreakMode.GetValue() == 1)
				selfact.UnEquipItem(targetItem)
			else
				selfact.RemoveItem(targetItem)
			endif
		endif
	endif

	Utility.Wait(0.5)
	PreSource = None
	GotoState("")
EndEvent

State Busy
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		; self.log("busy")
		; do nothing
	EndEvent
EndState

Function log(String msg)
	debug.trace("[EAB] " + msg)
EndFunction

Keyword Property ArmorClothing  Auto  
Keyword Property ArmorHeavy  Auto  
Keyword Property ArmorLight  Auto  
Keyword Property ArmorJewelry  Auto  

GlobalVariable Property EABBreakMode  Auto  
GlobalVariable Property EABEnableJewelry  Auto  
GlobalVariable Property EABRate  Auto  

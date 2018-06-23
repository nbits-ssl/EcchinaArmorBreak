Scriptname EABPlayerAlias extends ReferenceAlias  

Form PreSource = None

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	if (abHitBlocked || PreSource ==  akSource)
		return
	endif

	int rnd = Utility.RandomInt()
	int rate = EABRate.GetValue() as int
	; self.log(rnd + ", " + rate)
	if (rnd > rate)
		return
	endif
	
	GotoState("Busy")
	
	PreSource = akSource
	Actor selfact = self.GetActorRef()
    Int CurrentArmorSlotsMaskB = Math.LeftShift(EABSlotMaskB.GetValue() As Int, 24)
	Int CurrentArmorSlotsMaskA = EABSlotMask.GetValue() As Int
	int slotsChecked = Math.LogicalOr(CurrentArmorSlotsMaskA, CurrentArmorSlotsMaskB)
	
;	int slotsChecked = EABSlotMask.GetValue() As Int

	Form[] armors = Ecchina_Utility.GetEeuippedArmors(selfact)

	if (armors)
		int idx = Utility.RandomInt(0, armors.Length - 1)
		Form targetItem = armors[idx]
		Armor amr = targetItem as Armor
		int slotmask = amr.GetSlotMask()
		int slotmaskb = Math.LogicalAnd(slotsChecked, slotmask)
		if ((slotmaskb != 0x00) && (slotmask == slotmaskb))
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

GlobalVariable Property EABBreakMode  Auto  
GlobalVariable Property EABRate  Auto  
GlobalVariable Property EABSlotMask  Auto  
GlobalVariable Property EABSlotMaskB  Auto  

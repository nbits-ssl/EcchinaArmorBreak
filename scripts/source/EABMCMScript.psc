Scriptname EABMCMScript extends  ski_configbase
GlobalVariable Property EABBreakMode auto
GlobalVariable Property EABRate auto
GlobalVariable Property EABSlotMask auto
GlobalVariable Property EABSlotMaskB auto
;�ϐ��̒�`
int ToggleBreakModeID
int SliderRateID
int[] ToggleSlotID
int[] SlotValue

bool bToggleBreakMode = true
float fSliderRate = 100.0
bool[] bToggleSlot

; ������
Event OnConfigInit()
    ToggleSlotID = new int[32]
    SlotValue = new int[32]
    bToggleSlot = new Bool[32]
EndEvent

;�y�[�W�̐ݒ�
Event OnPageReset(string page)
   SetCursorFillMode(TOP_TO_BOTTOM)
   AddHeaderOption("�ݒ�")
   
   bToggleBreakMode = EABBreakMode.GetValue() As Bool
   ToggleBreakModeID = AddToggleOption("�E��", bToggleBreakMode)
   
   fSliderRate = EABRate.GetValue()
   SliderRateID = AddSliderOption("������", fSliderRate, "{0}")

   SetCursorPosition(1)
   bToggleSlot = GetUnignoredArmorSlots(EABSlotMask, EABSlotMaskB)
   
   AddHeaderOption("�ΏۂƂ��鑕���X���b�g")
   ToggleSlotID[0] = AddToggleOption("30 - ��", bToggleSlot[0])
   ToggleSlotID[1] = AddToggleOption("31 - ��", bToggleSlot[1])
   ToggleSlotID[2] = AddToggleOption("32 - �g��", bToggleSlot[2])
   ToggleSlotID[3] = AddToggleOption("33 - ��", bToggleSlot[3])
   ToggleSlotID[4] = AddToggleOption("34 - �O�r", bToggleSlot[4])
   ToggleSlotID[5] = AddToggleOption("35 - �A�~�����b�g", bToggleSlot[5])
   ToggleSlotID[6] = AddToggleOption("36 - �w��", bToggleSlot[6])
   ToggleSlotID[7] = AddToggleOption("37 - ��", bToggleSlot[7])
   ToggleSlotID[8] = AddToggleOption("38 - �ӂ���͂�", bToggleSlot[8])
   ToggleSlotID[9] = AddToggleOption("39 - ��", bToggleSlot[9])
   ToggleSlotID[10] = AddToggleOption("40 - �K��", bToggleSlot[10])
   ToggleSlotID[11] = AddToggleOption("41 - ����", bToggleSlot[11])
   ToggleSlotID[12] = AddToggleOption("42 - �T�[�N���b�g", bToggleSlot[12])
   ToggleSlotID[13] = AddToggleOption("43 - ��", bToggleSlot[13])
   ToggleSlotID[14] = AddToggleOption("44 - Unnamed", bToggleSlot[14])
   ToggleSlotID[15] = AddToggleOption("45 - Unnamed", bToggleSlot[15])
   ToggleSlotID[16] = AddToggleOption("46 - Unnamed", bToggleSlot[16])
   ToggleSlotID[17] = AddToggleOption("47 - Unnamed", bToggleSlot[17])
   ToggleSlotID[18] = AddToggleOption("48 - Unnamed", bToggleSlot[18])
   ToggleSlotID[19] = AddToggleOption("49 - Unnamed", bToggleSlot[19])
   ToggleSlotID[20] = AddToggleOption("50 - �ؒf���ꂽ����", bToggleSlot[20])
   ToggleSlotID[21] = AddToggleOption("51 - �ؒf����", bToggleSlot[21])
   ToggleSlotID[22] = AddToggleOption("52 - Unnamed", bToggleSlot[22])
   ToggleSlotID[23] = AddToggleOption("53 - Unnamed", bToggleSlot[23])
   ToggleSlotID[24] = AddToggleOption("54 - Unnamed", bToggleSlot[24])
   ToggleSlotID[25] = AddToggleOption("55 - Unnamed", bToggleSlot[25])
   ToggleSlotID[26] = AddToggleOption("56 - Unnamed", bToggleSlot[26])
   ToggleSlotID[27] = AddToggleOption("57 - Unnamed", bToggleSlot[27])
   ToggleSlotID[28] = AddToggleOption("58 - Unnamed", bToggleSlot[28])
   ToggleSlotID[29] = AddToggleOption("59 - Unnamed", bToggleSlot[29])
   ToggleSlotID[30] = AddToggleOption("60 - Unnamed", bToggleSlot[30])
   ToggleSlotID[31] = AddToggleOption("61 - FX01", bToggleSlot[31])
   
endEvent

int function GetVersion()
	return 1
endFunction

;�I�����̐ݒ�
Event OnOptionSelect(int option)
   if (option == ToggleBreakModeID)
       bToggleBreakMode = !bToggleBreakMode
       SetToggleOptionValue(ToggleBreakModeID, bToggleBreakMode)
       If(bToggleBreakMode)
         EABBreakMode.SetValue(1)
       Else
         EABBreakMode.SetValue(0)
       EndIf
   else
       int idx = ToggleSlotID.Find(option)
       if (idx >= 0)
           bToggleSlot[idx] = !bToggleSlot[idx]
           IgnoreArmorSlot(EABSlotMask, EABSlotMaskB, idx + 30, !bToggleSlot[idx])
           SetToggleOptionValue(option, bToggleSlot[idx])
       endif
   endIf
endEvent

;�X���C�_�[�J�������̃C�x���g�E�ݒ�
Event OnOptionSliderOpen(int option)
   if (option == SliderRateID)
       SetSliderDialogStartValue(fSliderRate)
       SetSliderDialogDefaultValue(100)
       SetSliderDialogRange(0, 100)
       SetSliderDialogInterval(1)
   endIf
EndEvent

Event OnOptionSliderAccept(int option, float value)
   if (option == SliderRateID)
       fSliderRate = value
       SetSliderOptionValue(SliderRateID, fSliderRate, "{0}")
       EABRate.SetValue(fSliderRate)
   endIf
EndEvent

;�f�t�H���g�̐ݒ�(F�L�[���������ɌĂяo�����C�x���g)
Event OnOptionDefault(int option)
  If(option == ToggleBreakModeID)
      if (!bToggleBreakMode)
          bToggleBreakMode = true
          SetToggleOptionValue(ToggleBreakModeID, bToggleBreakMode)
          EABBreakMode.SetValue(1)
      endif
  Elseif(option == SliderRateID)
      fSliderRate = 100.0
      SetSliderOptionValue(SliderRateID, fSliderRate, "{0}")
      EABRate.SetValue(fSliderRate)
  Else
       int idx = ToggleSlotID.Find(option)
       if (idx >= 0)
           if ( idx <= 13 ) ;slot 30-43
               IgnoreArmorSlot(EABSlotMask, EABSlotMaskB, idx + 30, True)
               SetToggleOptionValue(option, True)
           else
               IgnoreArmorSlot(EABSlotMask, EABSlotMaskB, idx + 30, False)
               SetToggleOptionValue(option, False)
           endif
       endif
  EndIf
EndEvent

;�J�[�\������������ɉ��ɏo��e�L�X�g�̐ݒ�
Event OnOptionHighlight(int option)
  If(option == ToggleBreakModeID)
       SetInfoText("�L�����͑��������@�������͑����j��(���X�g)")
  Elseif(option == SliderRateID)
       SetInfoText("�U�����󂯂��ۂ̃A�[�}�[�u���C�N�����m��")
  EndIf
EndEvent
Bool[] Function GetUnignoredArmorSlots(GlobalVariable IgnoredArmorSlotsMask, GlobalVariable IgnoredArmorSlotsMaskB)
	Bool[] ArmorSlots = new Bool[32]

    Int CurrentArmorSlotsMaskB = Math.LeftShift(IgnoredArmorSlotsMaskB.GetValue() As Int, 24)
	Int CurrentArmorSlotsMaskA = IgnoredArmorSlotsMask.GetValue() As Int
	Int CurrentIgnoredArmorSlotsMask = Math.LogicalOr(CurrentArmorSlotsMaskA, CurrentArmorSlotsMaskB)
	
	Int Index = ArmorSlots.Length
	While Index
		Index -= 1
		Int ArmorSlotMask = Armor.GetMaskForSlot(Index + 30)
		If Math.LogicalAnd(ArmorSlotMask, CurrentIgnoredArmorSlotsMask) == ArmorSlotMask
			ArmorSlots[Index] = True
		Else
			ArmorSlots[Index] = False
		EndIf
	EndWhile
	
	Return ArmorSlots
EndFunction
Function IgnoreArmorSlot(GlobalVariable IgnoredArmorSlotsMask, GlobalVariable IgnoredArmorSlotsMaskB, Int ArmorSlot, Bool Ignore)
	Int ArmorSlotMask = Armor.GetMaskForSlot(ArmorSlot)
    Int CurrentArmorSlotsMaskB = Math.LeftShift(IgnoredArmorSlotsMaskB.GetValue() As Int, 24)
	Int CurrentArmorSlotsMaskA = IgnoredArmorSlotsMask.GetValue() As Int
	Int CurrentIgnoredArmorSlotsMask = Math.LogicalOr(CurrentArmorSlotsMaskA, CurrentArmorSlotsMaskB)
;	Int CurrentIgnoredArmorSlotsMask = IgnoredArmorSlotsMask.GetValue() As Int
	
	Int NewIgnoredArmorSlotsMask
	If Ignore == False
		NewIgnoredArmorSlotsMask = Math.LogicalOr(ArmorSlotMask, CurrentIgnoredArmorSlotsMask)
	Else
		NewIgnoredArmorSlotsMask = Math.LogicalXor(ArmorSlotMask, CurrentIgnoredArmorSlotsMask)
	EndIf
	
	IgnoredArmorSlotsMask.SetValue(Math.LogicalAnd(NewIgnoredArmorSlotsMask, 0x00ffffff))
	IgnoredArmorSlotsMaskB.SetValue(Math.RightShift(NewIgnoredArmorSlotsMask, 24))
EndFunction

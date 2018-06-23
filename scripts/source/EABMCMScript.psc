Scriptname EABMCMScript extends  ski_configbase
GlobalVariable Property EABBreakMode auto
GlobalVariable Property EABRate auto
GlobalVariable Property EABSlotMask auto
GlobalVariable Property EABSlotMaskB auto
;変数の定義
int ToggleBreakModeID
int SliderRateID
int[] ToggleSlotID
int[] SlotValue

bool bToggleBreakMode = true
float fSliderRate = 100.0
bool[] bToggleSlot

; 初期化
Event OnConfigInit()
    ToggleSlotID = new int[32]
    SlotValue = new int[32]
    bToggleSlot = new Bool[32]
EndEvent

;ページの設定
Event OnPageReset(string page)
   SetCursorFillMode(TOP_TO_BOTTOM)
   AddHeaderOption("設定")
   
   bToggleBreakMode = EABBreakMode.GetValue() As Bool
   ToggleBreakModeID = AddToggleOption("脱衣", bToggleBreakMode)
   
   fSliderRate = EABRate.GetValue()
   SliderRateID = AddSliderOption("発生率", fSliderRate, "{0}")

   SetCursorPosition(1)
   bToggleSlot = GetUnignoredArmorSlots(EABSlotMask, EABSlotMaskB)
   
   AddHeaderOption("対象とする装備スロット")
   ToggleSlotID[0] = AddToggleOption("30 - 頭", bToggleSlot[0])
   ToggleSlotID[1] = AddToggleOption("31 - 髪", bToggleSlot[1])
   ToggleSlotID[2] = AddToggleOption("32 - 身体", bToggleSlot[2])
   ToggleSlotID[3] = AddToggleOption("33 - 手", bToggleSlot[3])
   ToggleSlotID[4] = AddToggleOption("34 - 前腕", bToggleSlot[4])
   ToggleSlotID[5] = AddToggleOption("35 - アミュレット", bToggleSlot[5])
   ToggleSlotID[6] = AddToggleOption("36 - 指輪", bToggleSlot[6])
   ToggleSlotID[7] = AddToggleOption("37 - 足", bToggleSlot[7])
   ToggleSlotID[8] = AddToggleOption("38 - ふくらはぎ", bToggleSlot[8])
   ToggleSlotID[9] = AddToggleOption("39 - 盾", bToggleSlot[9])
   ToggleSlotID[10] = AddToggleOption("40 - 尻尾", bToggleSlot[10])
   ToggleSlotID[11] = AddToggleOption("41 - 長髪", bToggleSlot[11])
   ToggleSlotID[12] = AddToggleOption("42 - サークレット", bToggleSlot[12])
   ToggleSlotID[13] = AddToggleOption("43 - 耳", bToggleSlot[13])
   ToggleSlotID[14] = AddToggleOption("44 - Unnamed", bToggleSlot[14])
   ToggleSlotID[15] = AddToggleOption("45 - Unnamed", bToggleSlot[15])
   ToggleSlotID[16] = AddToggleOption("46 - Unnamed", bToggleSlot[16])
   ToggleSlotID[17] = AddToggleOption("47 - Unnamed", bToggleSlot[17])
   ToggleSlotID[18] = AddToggleOption("48 - Unnamed", bToggleSlot[18])
   ToggleSlotID[19] = AddToggleOption("49 - Unnamed", bToggleSlot[19])
   ToggleSlotID[20] = AddToggleOption("50 - 切断された頭部", bToggleSlot[20])
   ToggleSlotID[21] = AddToggleOption("51 - 切断部分", bToggleSlot[21])
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

;選択時の設定
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

;スライダー開いた時のイベント・設定
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

;デフォルトの設定(Fキー押した時に呼び出されるイベント)
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

;カーソルが乗った時に下に出るテキストの設定
Event OnOptionHighlight(int option)
  If(option == ToggleBreakModeID)
       SetInfoText("有効時は装備解除　無効時は装備破壊(ロスト)")
  Elseif(option == SliderRateID)
       SetInfoText("攻撃を受けた際のアーマーブレイク発生確率")
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

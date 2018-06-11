Scriptname Ecchina_Utility Hidden

;何も装備してない場合は formArray.Length == 0。最大要素数は128まで
;戻り値はSlotMaskの昇順でソートして返してます
;プレイヤーのcarryweightを10000とかにしてアイテムを多数所持しているとインベントリを開くだけでも無駄に負荷がかかる
Form[] Function GetEeuippedArmors(Actor target) global native
;slotMask = 0 で全てのアーマー
;slotMask = 0　の時はSlotMask昇順
;slotMask指定　の時はarmorrating昇順
Form[] Function GetAllArmors(Actor target, int slotMask) global native
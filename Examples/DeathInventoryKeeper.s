;;; For operating DeathInventoryKeeper, determine what items are kept upon death.
;;; Usage: Compile, link, and then set using sysctl command.
;;;
;;; This is called for every item upon death.
;;; Inputs:
;;;   r0 = unique death id (reset upon Ark server restart)
;;;   r1 = pointer to item data:
;;;        Byte0:
;;;          Bit#0: set if the item is equipped
;;;          Bit#1: set if the item is an engram
;;;          Bit#2: set if the item is a blueprint
;;;          Bit#3: set if the item is allowed to be removed from inventory
;;;        Byte1: item type
;;;        Byte2-5: pointer to the item class name
;;;        Byte6...: list of pointers to dino tags who aggroes from picking up the egg (if the item is an egg),
;;;                  the pointer list ends with null pointer, each pointer is 4 bytes
;;; Outputs:
;;;   r0 = 0 to not to keep the item, any other value to keep the item
;;; 

        
        move.b (r1)+, r2        ; Move byte0 into r2.
        and.b  #1, r2           ; Test if the item is equipped,
        bne    .keep            ; and keep the item if it is equipped.

.nokeep:
        move.l #0, r0
        rts

.keep:
        move.l #1, r0
        rts

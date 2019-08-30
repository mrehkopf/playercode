.MEMORYMAP
  SLOTSIZE $8000
  DEFAULTSLOT 0
  SLOT 0 $8000
.ENDME

.ROMBANKSIZE $8000
.ROMBANKS 1

.define waittable	$fa00
.define dirregion	$fb00
.define brrregion	$8000

.section "BANKHEADER"

.db "head"
.dw 16,0
.db "ppse song player"

.db "vers"
.dw 4,0
.dw $0319
.dw $2017

.fopen "spcp.bin" fp
.fsize fp spccode_size
.fclose fp
.db "spcp"
.dw spccode_size,0
.incbin "spcp.bin"

.db "ntvv"
.dw 12,0
.dw EmptyHandler
.dw EmptyHandler
.dw EmptyHandler
.dw EmptyHandler
.dw 0
.dw irqmain

.db "emuv"
.dw 12,0
.dw EmptyHandler
.dw 0
.dw EmptyHandler
.dw EmptyHandler
.dw Start
.dw EmptyHandler

.db "smcp"
.dw endcode,0	; smcコードの容量を取得する方法
.ends

.include "smcp/smcplayercode.inc"

.section "SpcCode" semifree
spccode:
.incbin "smcp/dspregAcc/dspregAcc.bin"
spccode_end:
.ends

.section "EndCode" semifree
endcode:
.db 0	; dummy
.ends

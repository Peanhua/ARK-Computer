Note that these are the plans, only parts are implemented, and some features depend on how you setup your computer (for example, the amount of memory).

Memory layout:
24 bits address of memory = 16 megabytes
PC goes from 0 to up.
16 bits address of separate memory for stack, going from 0 to up, max stack size is thus 2^16=65536 bytes.

Registers:
R0-R14 = 15 general purpose 32 bit registers (signed integer)
SP/R15 = Stack Pointer
PC = Program Counter
CCR = Condition Code Register:
  Z - Zero - Set if result is zero.
  N - Negative - Set if result is less than 0.

Addressing modes:
[list]
[*] Rn - The value of the register.
[*] (Rn) - Indirect, the value in the address pointed by Rn.
[*] (Rn)+ - Indirect with postincrement, like indirect, but the Rn is incremented after.
[*] -(Rn) - Indirect with predecrement, like indirect, but the Rn is decremented before.
[*] d16(Rn) - Indirect with offset, the value in the address pointed by Rn+d16. Not yet implemented.
[*] $a - Direct, the value in the address at a.
d16(pc) - Indirect with offset to PC, the value in the address pointed by PC+d16. Not yet implemented.
[*] #n - Immediate, the value is n. Not applicable for destination operator.
[/list]

If instruction takes two operands, they are named source and destination. For one operand instructions, the operand is named destination.

The source operand postincrement and predecrement operations are performed before destination operand postincrement and predecrement operations.

Instructions operating on values take a size modifier:
[list]
[*] .b - 8 bits, not yet implemented
[*] .w - 16 bits, not yet implemented
[*] .l - 32 bits
[/list]

The assembler expects everything in lower case (will be fixed later to be case insensitive).

Instructions (* = not yet implemented):
*ADD
*AND
Bcc (BRA, BNE, BEQ, BPL, BMI, *BGE, *BLT, *BGT, *BLE)
*CLR
*CMP
*DBcc (DBF, DBNE, DBEQ, DBPL, DBMI, DBGE, DBLT, DBGT, DBLE)
*DIV
*EXG
JMP
JSR
*LEA
MOVE
*MUL
*NEG
NOP
*NOT
*OR
RTS
*SUB
SYS
*TST
*XOR


Conditions (for Bcc and DBcc):
[table]
[tr][th]Condition[/th][th]Description[/th][th]Test on CCR[/th][/tr]
[tr][td]RA[/td][td]always[/td][td]true[/td][/tr]
[tr][td]F[/td][td]never[/td][td]false[/td][/tr]
[tr][td]EQ[/td][td]equal[/td][td]Z=1[/td][/tr]
[tr][td]NE[/td][td]not equal[/td][td]Z=0[/td][/tr]
[tr][td]PL[/td][td]positive (>= 0)[/td][td]N=0[/td][/tr]
[tr][td]MI[/td][td]negative (<0)[/td][td]N=1[/td][/tr]
[/table]


Instruction details:
ADD - Add
Operation: Source + Destination -> Destination
Syntax: ADD <ea>, <ea>

AND - Logical And
Operation: Source & Destination -> Destination
Syntax: AND <ea>, <ea>

Bcc - Branch Conditionally
Operation: If Condition is true, then PC + offset -> PC
Syntax: Bcc <label>

CLR - Clear
Operation: 0 -> Destination
Syntax: CLR <ea>

CMP - Compare
Operation: Destination - Source -> cc
Syntax: CMP <ea>, Rn

DBcc - Test Condition, Decrement, and Branch
Operation: If Condition is false, then
              Rn - 1 -> Rn
              If Rn != -1, then
                 PC + offset -> PC
Syntax: DBcc Rn, <label>

DIV - Divide
Operation: Destination / Source -> Destination
Syntax: DIV <ea>, <ea>

EXG - Exchange Registers
Operation: Rx <-> Ry
Syntax: EXG Rn, Rn

JMP - Jump
Operation: Destination Address -> PC
Syntax: JMP <ea>

JSR - Jump to Subroutine
Operation: SP - 4 -> SP
           PC -> (SP)
           Destination Address -> PC
Syntax: JSR <ea>

LEA - Load Effective Address
Operation: ea -> Rn
Syntax: LEA <ea>, Rn

MOVE - Move Data
Operation: Source -> Destination
Syntax: MOVE <ea>, <ea>
CCR: N=true if the moved value was negative, false otherwise
     Z=true if the moved value was zero, false otherwise

MUL - Multiply
Operation: Source * Destination -> Destination
Syntax: MUL <ea>, <ea>

NEG - Negate
Operation: 0 - Destination -> Destination
Syntax: NEG <ea>

NOP - No Operation
Operation: None
Syntax: NOP

NOT - Complement
Operation: ~Destination -> Destination
Syntax: NOT <ea>

OR - Inclusive Or
Operation: Source | Destination -> Destination
Syntax: OR <ea>, <ea>

RTS - Return from Subroutine
Operation: (SP) -> PC
           SP + 4 -> SP
Syntax: RTS
           
SUB - Subtract
Operation: Destination - Source -> Destination
Syntax: SUB <ea>, <ea>

SYS - System call
Syntax: SYS

TST - Test
Operation: Destination Tested -> Condition codes
Syntax: TST <ea>

XOR - Exclusive Or
Operation: Source XOR Destination -> Destination
Syntax: XOR Rn, <ea>



Maybe later:
BCHG
BCLR
BSET
BTST
MOVEM
TAS

BCHG - Test a Bit and Change
Operation: If Bit is zero, then 1 -> Z, otherwise 0 -> Z
           !Bit -> Destination Bit

BCLR - Test a Bit and Clear
Operation: If Bit is zero, then 1 -> Z, otherwise 0 -> Z
           0 -> Destination Bit

BSET - Test a Bit and Set
Operation: If Bit is zero, then 1 -> Z, otherwise 0 -> Z
           1 -> Destination Bit

BTST - Test a Bit
Operation: If Bit is zero, then 1 -> Z, otherwise 0 -> Z

MOVEM - Move Multiple registers
Operation: Registers -> Destination
           or
           Source -> Registers

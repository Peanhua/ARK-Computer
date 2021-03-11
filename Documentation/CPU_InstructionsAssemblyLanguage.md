# Assembly language

The "as" assembler command reads in a text file containing lines of instructions and other mnemonics.

Each line can contain a label or mnemonic. Empty lines are ignored. Optional comments can be appended to any lines.


## Comments

Comments can be on their own lines, or appended after any other line. Anything after the comment start character ";" is ignored. For example:
```
; This is a comment.
.label: ; This is also a comment, the .label: in the beginning of the line is not ignored.
jmp .label ; And this also is a comment, anything up to the first ; is not ignored.
```


## Labels

A label defines a name for the address of current line. The label is written as:
```
.label:
```
Where the "label" is the name of the label, and the "." and ":" tells the assembler that it indeed is a label. When referencing the label, the ":" is left out, for example:
```
jmp .label
```


## Data constants

Data constants are constant values added to the generated binary file. The syntax is:
```
dc.s value1, value2, value3, ...
```
Where the "dc" stands for "data constant", and "s" defines the size of each value. The size is either "b" for byte (8 bit value, 1 byte), "w" for word (16 bit value, 2 bytes), or "l" for long (32 bit value, 4 bytes).

The values are delimited by a ",", and are made of numbers and valid ASCII strings. ASCII strings are enclosed within " or '.

Examples:
```
dc.b 1, 2, 3, 4
dc.w 1, 2, 3, 4
dc.l 1, 2, 3, 4
dc.b "Hello world", 10, 0
dc.l "Hello world", 10, 0
```


## Data segments

Data segments reserve space and initialize it to zeros, the syntax is:
```
ds.s count
```
Where "ds" stands for "data segment". The "count" parameter defines the number of elements of the specified size to reserve.



## Instructions

Note that only parts are currently implemented, there may/will be more, and some features depend on how you setup your computer (for example, the amount of memory).

Memory layout:
* 24 bits address of memory = 16 megabytes
* PC goes from 0 to up.
* 16 bits address of separate memory for stack, going from 0 to up, max stack size is thus 2^16=65536 bytes.

Registers:
* R0-R14 = 15 general purpose 32 bit registers (signed integer)
* SP/R15 = Stack Pointer
* PC = Program Counter
* CCR = Condition Code Register:
  * Z - Zero - Set if result is zero.
  * N - Negative - Set if result is less than 0.

Addressing modes:
* Rn - The value of the register.
* (Rn) - Indirect, the value in the address pointed by Rn.
* (Rn)+ - Indirect with postincrement, like indirect, but the Rn is incremented after.
* -(Rn) - Indirect with predecrement, like indirect, but the Rn is decremented before.
* d16(Rn) - Indirect with offset, the value in the address pointed by Rn+d16. Not yet implemented.
* $a - Direct, the value in the address at a.
* d16(pc) - Indirect with offset to PC, the value in the address pointed by PC+d16. Not yet implemented.
* #n - Immediate, the value is n. Not applicable for destination operator.


If instruction takes two operands, they are named source "<src>" and destination "<dst>". For one operand instructions, the operand is named destination.

The source operand postincrement and predecrement operations are performed before destination operand postincrement and predecrement operations.

Some instructions operating take a size modifier, marked in syntax as ".s" (for example AND.s). The size modifier can be one of the following:
* .b - 8 bits, not yet implemented
* .w - 16 bits, not yet implemented
* .l - 32 bits

The assembler expects everything in lower case (will be fixed later to be case insensitive).

Instructions (* = not yet implemented):
* ADD
* AND
* Bcc (BRA, BNE, BEQ, BPL, BMI, *BGE, *BLT, *BGT, *BLE)
* CLR
* CMP
* *DBcc (DBF, DBNE, DBEQ, DBPL, DBMI, DBGE, DBLT, DBGT, DBLE)
* DIV
* *EXG
* JMP
* JSR
* LEA
* MOVE
* MUL
* NEG
* NOP
* NOT
* OR
* RTS
* SUB
* SYS
* TST
* XOR


Conditions (for Bcc and DBcc):
Condition | Description | Test on CCR
--------- | ----------- | -----------
RA | always | true
F | never | false
EQ | equal | Z=1
NE | not equal | Z=0
PL | positive (>= 0) | N=0
MI | negative (<0) | N=1


Instruction details:
```
ADD - Add
Operation: Source + Destination -> Destination
Syntax: ADD.s <src>, <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
AND - Logical And
Operation: Source & Destination -> Destination
Syntax: AND.s <src>, <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
Bcc - Branch Conditionally
Operation: If Condition is true, then PC + offset -> PC
Syntax: Bcc <address>
Conditions: BRA=always
            BNE=Z is false
            BEQ=Z is true
            BPL=N is false
            BMI=N is true
```

```
CLR - Clear
Operation: 0 -> Destination
Syntax: CLR.s <dst>
CCR: N=false
     Z=true
```

```
CMP - Compare
Operation: Destination - Source -> cc
Syntax: CMP.s <src>, <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
DBcc - Test Condition, Decrement, and Branch
Operation: If Condition is false, then
              Rn - 1 -> Rn
              If Rn != -1, then
                 PC + offset -> PC
Syntax: DBcc Rn, <address>
```

```
DIV - Divide
Operation: Destination / Source -> Destination
Syntax: DIV.s <src>, <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
If the source value is zero, the process is halted with illegal instruction error.
```

```
EXG - Exchange Registers
Operation: Rx <-> Ry
Syntax: EXG Rn, Rn
```

```
JMP - Jump
Operation: Destination Address -> PC
Syntax: JMP <address>
```

```
JSR - Jump to Subroutine
Operation: SP - 4 -> SP
           PC -> (SP)
           Destination Address -> PC
Syntax: JSR <address>
```

```
LEA - Load Effective Address
Operation: ea -> Rn
Syntax: LEA <src>, <dst>
```

```
MOVE - Move Data
Operation: Source -> Destination
Syntax: MOVE.s <src>, <dst>
CCR: N=true if the moved value was negative, false otherwise
     Z=true if the moved value was zero, false otherwise
```

```
MUL - Multiply
Operation: Source * Destination -> Destination
Syntax: MUL.s <src>, <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
NEG - Negate
Operation: 0 - Destination -> Destination
Syntax: NEG.s <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
NOP - No Operation
Operation: None
Syntax: NOP
```

```
NOT - Complement
Operation: ~Destination -> Destination
Syntax: NOT.s <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
OR - Inclusive Or
Operation: Source | Destination -> Destination
Syntax: OR.s <src>, <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
RTS - Return from Subroutine
Operation: (SP) -> PC
           SP + 4 -> SP
Syntax: RTS
```
           
```
SUB - Subtract
Operation: Destination - Source -> Destination
Syntax: SUB.s <src>, <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
SYS - System call
Syntax: SYS
```

```
TST - Test
Operation: Destination Tested -> Condition codes
Syntax: TST.s <dst>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

```
XOR - Exclusive Or
Operation: Source XOR Destination -> Destination
Syntax: XOR.s Rn, <ea>
CCR: N=true if the result value was negative, false otherwise
     Z=true if the result value was zero, false otherwise
```

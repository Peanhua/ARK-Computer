Some simple examples:

"Hello world", does nothing but return a success:
[code]
move.l #0, r0   ; Process exit status is read from the r0.
       ; The value of 0 is considered success by the operating system.
       ; Other values means error.
rts       ; Exits the program because stack is empty.
[/code]


"Break world", like hello, but returns failure:
[code]
move.l #1, r0
rts
[/code]


Print the program name to stdout:
[code]
move.l #1, r0  ; The system call number to r0 (print string to stdout).
move.l (r1), r1  ; The system call takes the pointer to string in r1,
             ; when program is executed, the argc is in r0, argv is in r1,
             ; (r1) is register indirect addressing, so the argv[0] is now in r1.
sys        ; Perform the system call.
rts
[/code]


Address labels can be used and referenced. The declaration of a label starts with a "." and ends with a ":", when referenced the ":" is left out. For example:
[code]
.main:
jmp .main
[/code]

Multiple labels can point to same address, for example:
[code]
.main:
.loop:
move.l .main, r0
move.l .loop, r1 
; Both r0 and r1 now have the same value.
[/code]

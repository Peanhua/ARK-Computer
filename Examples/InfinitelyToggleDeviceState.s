;;; InfinitelyToggleDeviceState.s for Computer v0.3
;;;
;;; Toggle the state of a device using IO control to on and off infinitely.
;;; Arguments: filename
;;; 
;;; See this script operating lights (running multiple instances of this): https://youtu.be/Bj3FWXuEzs8
;;; 

        ;; Save argv[1]
        move.l (r1)+, r10       ; Discard argv[0]
        move.l (r1)+, r10       ; argv[1]
        
        ;; Open file argv[1]:
        move.l #4, r0           ; Syscall: open file
        move.l r10, r1          ; Pointer to the filename
        sys
        move.l r0, r12          ; Save the file handle
        ;; Check for error (negative number):
        bmi    .error

        ;; Keep the current state at r13
        move.l #0, r13

.loop:
        move.l #0, r0
        jsr .setstate
        
        jsr .delay
        
        move.l #1, r0
        jsr .setstate

        jsr .delay

        jmp .loop

.error:
        move.l #1, r0
        rts
        
.setstate:
        ;; Call IO control:
        move.l r0, r3
        move.l #6, r0           ; Syscall: IO control
        move.l r12, r1          ; File handle
        move.l #0, r2           ; Operation: set state
        sys
        rts

.delay:
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

        rts

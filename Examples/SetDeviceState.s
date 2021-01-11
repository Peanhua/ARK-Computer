;;; SetDeviceState.s for Computer v0.3
;;;
;;; Change the state of a device using IO control.
;;; Arguments: filename state
;;; The state argument is a number, usually 0 or 1.
;;; 

        ;; Save argv[1] and argv[2]
        move.l (r1)+, r10       ; Discard argv[0]
        move.l (r1)+, r10       ; argv[1]
        move.l (r1)+, r11       ; argv[2]
        
        ;; Open file argv[1]:
        move.l #4, r0           ; Syscall: open file
        move.l r10, r1          ; Pointer to the filename
        sys
        move.l r0, r12          ; Save the file handle
        ;; Check for error (negative number):
        bmi    .error

        ;; Convert argv[2] to integer:
        move.l #3, r0           ; Syscall: string to integer
        move.l r11, r1          ; Pointer to the string
        sys
        move.l r0, r13          ; Save the new device state

        ;; Call IO control:
        move.l #6, r0           ; Syscall: IO control
        move.l r12, r1          ; File handle
        move.l #0, r2           ; Operation: set state
        move.l r13, r3          ; New state
        sys

        ;; Close the file:
        move.l #5, r0           ; Syscall: close file
        move.l r12, r1          ; File handle
        sys

        ;; Return success:
        move.l #0, r0
        rts

.error:
        ;; Return failure:
        move.l #1, r0
        rts

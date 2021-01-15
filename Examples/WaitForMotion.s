;;; WaitForMotion.s for Computer v0.5
;;;
;;; Waits for a motion detector to pick up movement.
;;; Arguments: filename
;;; 

        ;; Save argv[1]
        add.l  #4, r1        ; Discard argv[0]
        move.l (r1)+, r10    ; argv[1]
        
        ;; Open file argv[1]:
        move.l #4, r0           ; Syscall: open file
        move.l r10, r1          ; Pointer to the filename
        sys
        move.l r0, .filehandles ; Save the file handle
        ;; Check for error (negative number):
        bmi    .error

        move.l #7, r0           ; Syscall: wait
        move.l #16, r1          ; Wait for signal: IO
        move.l #1, r2           ; Number of file handles to wait
        lea    .filehandles, r3 ; Pointer to the file handles array
        sys
        
        ;; Close the file:
        move.l #5, r0           ; Syscall: close file
        move.l .filehandles, r1 ; File handle
        sys

        ;; Return success:
        move.l #0, r0
        rts

.error:
        ;; Return failure:
        move.l #1, r0
        rts

.filehandles:    
        nop
        

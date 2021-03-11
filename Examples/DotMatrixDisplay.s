;;; Display some test on a dot matrix display.
;;; 
;;; Example usage: DotMatrixDisplay /dev/dotmatrixdisplay0
;;; 
        
        ;; Open file argv[1]:
        move.l #4, r0           ; Syscall: open file
        add.l #4, r1
        move.l (r1)+, r1
        sys
        move.l r0, r12          ; Save the file handle
        bmi    .error

        ;; Write the data:
        move.l #10, r0          ; Syscall: write file
        move.l r12, r1
        lea    .data, r2
        move.l #8, r3
        sys
        cmp.l #0, r0
        bne .error2

        ;; Close the file:
        move.l #5, r0           ; Syscall: close file
        move.l r12, r1
        sys

        ;; Return success:
        move.l #0, r0
        rts

.error:
        ;; Return failure:
        move.l #1, r0
        rts

.error2:
        ;; Return failure, r0 already contains some non-zero error value:
        rts
        

.data:
        dc.b 1, 0, 1, 0, 0, 1, 1, 1
        

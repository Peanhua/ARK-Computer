;;; PrintClock.s for Computer v0.5
;;;
;;; Read the realtime clock and print it to the stdout.
;;;

        move.l #8, r0           ; System call: read realtime clock
        sys

        move.l r1, r10          ; Save the fractional part.

        ;; Convert the seconds (from r0) to string:
        move.l r0, r1
        lea    .buffer, r2
        move.l #2, r0
        sys
        ;; Print the seconds:
        move.l #1, r0
        lea    .buffer, r1
        sys

        ;; Convert the milliseconds (from r10) to string:
        move.l r10, r1
        lea    .buffer, r2
        move.l #2, r0
        sys
        ;; Print the seconds:
        move.l #1, r0
        lea    .buffer, r1
        sys
        
        move.l #0, r0
        rts

        
.buffer:
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        

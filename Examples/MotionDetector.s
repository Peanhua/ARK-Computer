;;; MotionDetector.s for Computer v0.5
;;;
;;; Waits for a motion detector to pick up movement,
;;; then sets the state of all the devices given.
;;;
;;; Arguments: motion_detector state d1, d2, d3, ...
;;; Where motion_detector is /dev/motiondetectorX and used to wait for the detection,
;;; state is usually 0 (to turn off) or 1 (to turn on),
;;; and dX arguments are /dev/extX that are operated.
;;; 
;;; Example: MotionDetector /dev/motiondetector0 1 /dev/ext10 /dev/ext12 /dev/ext13 /dev/ext18
;;;
;;; See also: WaitForMotion.s, SetDeviceState.s
;;; 


        ;; Save arguments for later:
        add.l  #4, r1           ; Discard argv[0]
        move.l (r1)+, r10       ; Save argv[1] (motion detector device filename) to r10
        move.l (r1)+, r11       ; Save argv[2] (state) to r11
        move.l r1, r12          ; Save the pointer to the remaining arguments (devices to operate) to r12
        sub.l  #3, r0
        move.l r0, r13          ; Save the number of device filenames to r13

        ;; Convert the state argument (argv[2]) to integer:
        move.l #3, r0           ; Syscall: string to integer
        move.l r11, r1          ; Pointer to the string
        sys
        move.l r0, r11          ; Save the new device state

        ;; Open the motion detector:
        move.l r10, r1
        move.l #4, r0
        sys
        move.l r0, .filehandles
        bmi    .error

.loop:
        ;; Wait for the motion detector to pick up movement:
        move.l #7, r0
        move.l #16, r1
        move.l #1, r2
        lea    .filehandles, r3
        sys

        ;; Change the state of all the devices:
        move.l r13, r8          ; Count
        move.l r12, r9          ; Pointer to the array of filenames
.stateloop:
        ;; Check if there are more devices to operate:
        tst.l  r8
        beq    .loop
        sub.l  #1, r8
        
        ;; Open the next device file:
        move.l #4, r0
        move.l (r9)+, r1
        sys
        move.l r0, r5           ; Save filehandle in r5
        bmi    .error

        ;; Perform IO control on the device:
        move.l #6, r0
        move.l r5, r1
        move.l #0, r2
        move.l r11, r3
        sys

        ;; Close the device file:
        move.l #5, r0
        move.l r5, r1
        sys

        ;; Go to next device file:
        jmp  .stateloop

.error:
        ;; Return failure:
        move.l #1, r0
        rts

.filehandles:    
        nop
        
        

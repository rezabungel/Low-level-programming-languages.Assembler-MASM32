
include \masm32\include\masm32rt.inc            ; connecting this file allows you not to declare many libraries and not to write some of the things that we did in the beginning

.code                                           ; tell MASM where the code starts

; *************************************************************************

start:                                          ; the CODE entry point to the program

    call main                                   ; branch to the "main" procedure

    exit

; *************************************************************************

        main proc                               ; Procedure Declaration
        
            LOCAL var1:DWORD                    ; space for a DWORD variable.
            LOCAL var2:DWORD                    ; space for a DWORD variable.
            LOCAL str1:DWORD                    ; a string handle for the input data.
        
                                    ; test the MOV and ADD instructions
        
            mov eax, 100                       ; copy the IMMEDIATE number 100 into the EAX register
            mov ecx, 250                       ; copy the IMMEDIATE number 250 into the ECX register
            add ecx, eax                       ; ADD EAX to ECX
            print str$(ecx)                    ; show the result at the console
            print chr$(13,10,13,10)

                                    ; test compared instructions
 
                                    ; ----------------------------------------
                                    ; The two following macros can be combined
                                    ; once you are familiar with how they work
                                    ; ----------------------------------------
                                   ;     mov str1, input("Enter a number : ")
                                   ;     mov var1, sval(str1)        ; convert the result to a signed integer

            mov var1, sval(input("Enter a number : "))      ; Enter a number and convert the result to a signed integer
            mov var2, sval(input("Enter b number : "))      ; Enter a number and convert the result to a signed integer
            mov eax, var2

            ; About CMP and conditional transitions, see at the end of the program.
            
            cmp var1, eax                       ; compare the variable var1 and var2 (eax = var2)
                                    
            je equal                            ; jump if var1 is equal to var2 to "equal"
            jg bigger                           ; jump if var1 is greater than var2 to "bigger"
            jl smaller                          ; jump if var1 is less than var2 to "smaller"
            
          equal:                                ; this is a label "equal"
            print chr$("The number you entered is equal",13,10)
            jmp over                            ; JMP is an unconditional transition operator. This transition is always performed.
        
          bigger:                               ; this is a label "bigger"
            print chr$("The first number you entered is greater than second number",13,10)
            jmp over                            ; JMP is an unconditional transition operator. This transition is always performed.
        
          smaller:                              ; this is a label "smaller"
            print chr$("The first number you entered is smaller than second number",13,10)
        
          over:                                 ; this is a label "over"

            inkey                               ; its a macro that calls a procedure in the masm32 library. It stops program execution until you press a key.
            ret                                 ; returns control to the calling program
        
        main endp                               ; End of procedure
        
; *************************************************************************

end start                                       ; Tell MASM where the program ends



; ----------------------------------------------------------------
; About CMP
;
; A memory area CANNOT be compared with a memory area:
;   MEM, MEM -> CANNOT
;
; CAN BE compared:
;   REG, MEM
;   MEM, REG
;   REG, REG
;   MEM, IMM
;   REG, IMM
;
; NOTE: IMM - Immediate value (for example, a number).
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; The CMP and TEST commands are used to form conditional transition
; Conditional Transition Commands
; je "label" - Transition if "var1" == "var2" to "label"
; jg "label" - Transition if "var1" > "var2" to "label"
; jl "label" - Transition if "var1" < "var2" to "label"
; and others...
; ----------------------------------------------------------------

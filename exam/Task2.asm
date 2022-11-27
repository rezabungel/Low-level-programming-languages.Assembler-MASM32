;Set a string containing english letters, digits, separators (there must be digits, letters, separators in one line).
;Delete all the digits and output the resulting string to the console.

.586p
.model flat, stdcall
option casemap:none

include /masm32/include/windows.inc
include /masm32/include/msvcrt.inc
include /masm32/include/masm32.inc
include /masm32/include/user32.inc
include /masm32/include/kernel32.inc

include /masm32/macros/macros.asm

includelib /masm32/lib/masm32.lib
includelib /masm32/lib/user32.lib
includelib /masm32/lib/kernel32.lib
includelib /masm32/lib/msvcrt.lib

.data
    source db "0123456789!!!***->...Thi37s text is use1d to che76ck th3e4 operat34ion 43of the pr3ogram...<-***!!!", 0           ; The original data string
    target db sizeof source dup(0)                                                                                               ; The line in which the result will be placed
    
    sep db 0ah, 0                                                                                                                ; We use it to transfer a line to a new line

.code
    start:

        mov esi, 0                                       ; Zeroing the index register
        mov ebx, 0                                       ; Zeroing the index register
        mov ecx, sizeof source                           ; Installing a cycle counter
        
      metka_for_remove_numbers_from_string:
            push ecx                                     ; Save ECX to the stack
                        
            mov al, source[esi]                          ; Load the character of the original string
            .if (al >=48) && (al<=57)                    ; Checking if the loaded character is a digit
                add esi, 1                               ; Adjust the value of the index pointing to the next character
            .else                        ;The loaded character is not a digit
                mov target[ebx], al                      ; Save the character in the resulting string
                add ebx, 1                               ; Adjust the value of the index pointing to the place where the character will be written
                add esi, 1                               ; Adjust the value of the index pointing to the next character
            .endif
     
            pop ecx                                      ; Extracting the value from the stack for ECX
            loop metka_for_remove_numbers_from_string    ; Repeat the cycle until ECX is equal to 0

        invoke crt_printf, addr source                   ; Outputting the source string to the console
        invoke crt_printf, addr sep
        invoke crt_printf, addr target                   ; Outputting the target string to the console
        invoke crt_printf, addr sep

        inkey
        invoke crt_exit, 0
    end start

; --------------------
; ASCII code -> symbol
;         48 -> 0     
;         49 -> 1     
;         50 -> 2     
;         51 -> 3     
;         52 -> 4     
;         53 -> 5     
;         54 -> 6     
;         55 -> 7     
;         56 -> 8     
;         57 -> 9     
; --------------------
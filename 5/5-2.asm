; Print the sum of the negative elements of the array

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
    mas dd 1,-2,3,-4,5                                        ; Creating an initialized array of 5 elements
    len_mas equ($-mas)/4                                      ; The $ operator returns the current value of the command counter. The result is the number of array elements (divide by 4 because we have type dd)
    sum dd 0                                      

    sep db 0ah, 0                                             ; We use it to transfer a line to a new line
    s1 db "Sum of negative array numbers = %d", 0

.code
    start:
        mov esi, offset mas                                   ; Address of the beginning of the array 
        mov ecx, len_mas                                      ; Installing the cycle counter, method 1. (Cycle counter = number of elements in the array). Method 2 - see in the program "5-1.asm"
        
      loop_through_the_array:
            mov eax, [esi]                                    ; The value from memory at the ESI address is placed in EAX
            add esi, 4                                        ; Moving on to the next element of the array (+4 because the type is dd) -> method 1. Method 2 - see in the program "5-1.asm"
            cmp eax, 0
                jge positive_number                           ; If the value in the array is greater than or equal to 0, then skip the addition and jump to the positive_number label   
                add sum, eax 
              positive_number:
            loop loop_through_the_array                       ; Repeat the cycle until ECX is equal to 0
            
        invoke crt_printf, addr s1, sum
        invoke crt__getch
        invoke crt_exit, 0
    end start

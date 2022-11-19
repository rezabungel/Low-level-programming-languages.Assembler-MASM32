; Input and output an array of type dd

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
    my_array dd 5 dup(?)                                                        ; Creating an uninitialized array of 5 elements
    len_my_array equ($-my_array)/4                                              ; The $ operator returns the current value of the command counter. The result is the number of array elements (divide by 4 because we have type dd)

    sep db 0ah, 0                                                               ; We use it to transfer a line to a new line
    s1 db "Array element at the address %d = %d", 0
    s2 db "Array size in bytes = %d", 0

    
.code
    start:
        mov esi, offset my_array                                                ; Address of the beginning of the array
        mov ecx, len_my_array                                                   ; Installing the cycle counter, method 1. (Cycle counter = number of elements in the array)
        
      metka_for_data_input_cycle:
            push ecx                                                            ; Save ECX to the stack, because ECX value will change
            mov [esi], sval(input("Enter the value of the array element: "))    ; Input and conversion to signed integer. (SVAL - convert the result to a signed integer).
            add esi , 4                                                         ; Moving on to the next element of the array (+4 because the type is dd) -> method 1
            pop ecx                                                             ; Extracting the value from the stack for ECX
            loop metka_for_data_input_cycle                                     ; Repeat the cycle until ECX is equal to 0

        invoke crt_printf, addr sep                                     

        mov esi, offset my_array                                                ; Address of the beginning of the array
        mov ecx, lengthof my_array                                              ; Installing the cycle counter, method 2. (Cycle counter = number of elements in the array)
        
      metka_for_data_output_cycle:
            mov eax, [esi]                                                      ; The value from memory at the ESI address is placed in EAX
            add esi, type my_array                                              ; Moving on to the next element of the array -> method 1                                         
            push ecx                                                            ; Save ECX to the stack, because when invoke is called, the ECX value will change
            invoke crt_printf, addr s1, esi ,eax
            invoke crt_printf, addr sep
            pop ecx                                                             ; Extracting the value from the stack for ECX
            loop metka_for_data_output_cycle                                    ; Repeat the cycle until ECX is equal to 0

        invoke crt_printf, addr sep
        invoke crt_printf, addr s2, sizeof my_array

        invoke crt__getch
        invoke crt_exit, 0
    end start

; --------------------------------------------------------------------------------------------------------
; About DUP
;
; The DUP operator is used to create variables containing duplicate byte values. A constant expression is
; used as a byte counter. This operator is usually used when allocating memory for a string of characters
; or an array that can be initiated or not. For example:
; BYTE 20 DUP(0)        ; 20 bytes, all equal to zero
; BYTE 20 DUP(?)        ; 20 bytes, the value of which is undefined
; BYTE 4 DUP("STEK ")   ; 20 bytes: "STEK STEK STEK STEK "
;
; To allocate memory for an array of words, it is convenient to use the DUP operator:
; array WORD 5 DUP(?)   ; array of 5 uninitialized words
; --------------------------------------------------------------------------------------------------------

; ------------------------------------------------------------------------------------------------------------
; About EQU
;
; The EQU directive is used to assign a symbolic name to an integer expression or an arbitrary text string.
; There are three formats of the EQU directive:  
; name EQU expression
; name EQU symbol 
; name EQU <text>
; ------------------------------------------------------------------------------------------------------------

; ------------------------------------------------------------------------------------------------------------
; The MASM compiler provides several operators intended for use in data addressing directives. These operators
; are listed below.
;
; OFFSET - Returns the offset of the variable relative to the beginning of the segment in which it is located.
; LENGTHOF - Returns the total number of elements in the array.
; TYPE - Returns the size in bytes of each element of the array.
; SIZEOF - Returns the number of bytes occupied by the array.
; PTR - Using the PTR operator, you can override the standard variable size.
; ------------------------------------------------------------------------------------------------------------

;(7a-3b-2)/(b-5)
.586p
.model flat, stdcall
option casemap:none

include /masm32/include/windows.inc
include /masm32/include/masm32.inc
include /masm32/include/msvcrt.inc

include /masm32/macros/macros.asm

includelib /masm32/lib/masm32.lib
includelib /masm32/lib/msvcrt.lib

.data
    a dd ?
    b dd ?
    va db "Enter a variable a: ", 0
    vb db "Enter a variable b: ", 0
    s1 db "chastnoe = %d ostatok = %d", 0
    tpi db "%d", 0
    tps db "%s", 0

.code
    main:
        invoke crt_printf, addr tps, addr va        ; API call
        invoke crt_scanf, addr tpi, addr a
        
        invoke crt_printf, addr tps, addr vb
        invoke crt_scanf, addr tpi, addr b

        mov eax, a                                  ; eax = a
        imul eax, 7                                 ; eax = 7a
        mov ebx, b                                  ; ebx = b
        imul ebx, 3                                 ; ebx = 3b
        sub eax, ebx                                ; eax = (7a - 3b)
        sub eax, 2                                  ; eax = (7a - 3b - 2)

        mov ecx, b                                  ; ecx = b 
        sub ecx, 5                                  ; ecx = (b-5)
        
        xor edx, edx                                ; Zeroing out. Also, zeroing can be done this way: mov edx, 0
        
        idiv ecx                                    ; (7a-3b-2)/(b-5) -> when dividing by default, the divisible is taken as eax (that is, we received eax/ecx)

        invoke crt_printf, addr s1, eax, edx
        invoke crt__getch
        invoke crt_exit, 0
    end main
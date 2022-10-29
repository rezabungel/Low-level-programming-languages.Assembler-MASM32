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
    a dd 3
    b dd 4
    Format db '(2*a*a*b+a*b), a=%d b=%d res=%d',0

.code
    main:
        mov eax, 2                                  ; eax=2
        mov ebx, a                                  ; ebx=a
        mul ebx                                     ; eax=2a
        mul ebx                                     ; eax=2a^2
        mov ebx, b                                  ; ebx=b
        mul ebx                                     ; eax =2a^2*b
        push eax                                    ; -> put the data on the stack 2a^2*b

        mov eax, a                                  ; eax=a
        mov ebx, b                                  ; ebx=b
        mul ebx                                     ; eax=a*b
        push eax                                    ; -> put the data on the stack a*b

        pop ebx                                     ; a*b
        pop eax                                     ; 2a^2*b
        add eax, ebx                                ; eax=2a^2*b+a*b

        invoke crt_printf, addr Format, a, b, eax
        invoke crt__getch
        invoke crt_exit, 0
    end main
;(3a-6b+300)/(b-2a)
.586p                                          ; Processor type, p - all privileges
.model flat, stdcall                           ; Memory Model
option casemap:none                            ; Case sensitivity (none - not sensitive)

include /masm32/include/masm32.inc
include /masm32/include/msvcrt.inc
include /masm32/macros/macros.asm
includelib /masm32/lib/masm32.lib
includelib /masm32/lib/msvcrt.lib

.data                                          ; Data Section
a dd ?
b dd ?
y dd ?
va db "Enter a variable a: ", 0
vb db "Enter a variable b: ", 0
s1 db "chastnoe = %d ostatok = %d", 0
tpi db "%d", 0
tps db "%s", 0

.code
    start:
        invoke crt_printf, addr tps, addr va   ; API call
        invoke crt_scanf, addr tpi, addr a
        
        invoke crt_printf, addr tps, addr vb
        invoke crt_scanf, addr tpi, addr b

        mov eax, a                             ; eax = a
        imul eax, 3                            ; eax = 3a
        mov ebx, b                             ; ebx = b
        imul ebx, 6                            ; ebx = 6b 
        sub eax, ebx                           ; eax = (3a - 6b)
        add eax, 300                           ; eax = (3a - 6b + 300)
        
        mov ecx, b                             ; ecx = b
        mov ebx, 2                             ; ebx = 2 
        imul ebx, a                            ; ebx = 2a
        sub ecx, ebx                           ; ecx = (b-2a)
        
        xor edx, edx                           ; Zeroing out. Also, zeroing can be done this way: mov edx, 0
        
        idiv ecx                               ; (3a-6b+300)/(b-2a) -> when dividing by default, the divisible is taken as eax (that is , we received eax/ecx)
        
        invoke crt_printf, addr s1, eax, edx
        invoke crt__getch                      ; Keep the console open

        invoke crt_exit, 0                     ; ExitProcess

    end start
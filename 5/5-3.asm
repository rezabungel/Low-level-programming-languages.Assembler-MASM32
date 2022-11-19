; Apply a logical shift (shl, shr, sal, sar, rol, ror) by 3 bits to the number:   
; a db 127 

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
    a db 127                                        ; db - 1 byte. Range: for signed numbers -128...+127; for unsigned numbers 0...255; 

    result_shl db "shl = %d", 0ah, 0
    result_shr db "shr = %d", 0ah, 0ah, 0
    result_sal db "sal = %d", 0ah, 0
    result_sar db "sar = %d", 0ah, 0ah,0
    result_rol db "rol = %d", 0ah, 0
    result_ror db "ror = %d", 0ah, 0

.code
    start:

        mov al, a                                   ; al = 127 = 01111111b                               
        shl al, 3                                   ; al = 248 = 11111000b
        invoke crt_printf, addr result_shl, al      ; Output the result of a logical operation 

        mov al, a                                   ; al = 127 = 01111111b          
        shr al, 3                                   ; al = 15  = 00001111b
        invoke crt_printf, addr result_shr, al      ; Output the result of a logical operation

        mov al, a                                   ; al = 127 = 01111111b                               
        sal al, 3                                   ; al = 248 = 11111000b
        invoke crt_printf, addr result_sal, al      ; Output the result of a logical operation 

        mov al, a                                   ; al = 127 = 01111111b                                       
        sar al, 3                                   ; al = 15  = 00001111b                                   
        invoke crt_printf, addr result_sar, al      ; Output the result of a logical operation  

        mov al, a                                   ; al = 127 = 01111111b                               
        rol al, 3                                   ; al = 251 = 11111011b
        invoke crt_printf, addr result_rol, al      ; Output the result of a logical operation  

        mov al, a                                   ; al = 127 = 01111111b                               
        ror al, 3                                   ; al = 239 = 11101111b
        invoke crt_printf, addr result_ror, al      ; Output the result of a logical operation  

        invoke crt__getch
        invoke crt_exit, 0
    end start



; --------------------------------------------------------------------------------------------------------    
; Two types of logical shifts:
;   - logical shift
;   - arithmetic shift
; --------------------------------------------------------------------------------------------------------
; About logical shifts (SHL, SHR, SAL, SAR, ROL, ROR), see the readme.
; --------------------------------------------------------------------------------------------------------

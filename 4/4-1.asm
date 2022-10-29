; Enter 3 signed integers of type "db".
; Using the comparison procedure, output the maximum.

; MOVSX - use this command.

include \masm32\include\masm32rt.inc

.data
a db ?
b db ?
d db ?
va db "Enter a variable a: ", 0
vb db "Enter a variable b: ", 0
vd db "Enter a variable d: ", 0

s1 db "max = %d", 0

tpi db "%d", 0
tps db "%s", 0

.code
    max proc
        .if eax < ebx
            mov eax, ebx
        .endif 
        .if eax < ecx
            mov eax, ecx
        .endif
        ret
    max endp

    start:
        invoke crt_printf, addr tps, addr va        ; API call
        invoke crt_scanf, addr tpi, addr a
        
        invoke crt_printf, addr tps, addr vb
        invoke crt_scanf, addr tpi, addr b

        invoke crt_printf, addr tps, addr vd
        invoke crt_scanf, addr tpi, addr d

        ; About MOVSX see at the end of the program.
        movsx eax, a                                ; Complements 0 with bits if the number is positive and complements 1 if the number is negative. 8 bits will be augmented to 32 bits.
        movsx ebx, b
        movsx ecx, d

        call max
        
        invoke crt_printf, addr s1, eax
        invoke crt__getch
        invoke crt_exit, 0
    end start

; ------------------------------------------------------------------------
; About MOVSX (Move With Sign-Extend)
;
; The MOVSX command allows you to copy data from a smaller source (second
; operand) to a larger receiver (first operand). The result will be padded
; with bits in such a way as to preserve the sign of the source. This command
; is only used when working with SIGNED INTEGERS.
;
; Limitations:
; 1)Only 16- or 32-bit general-purpose registers can be used as a receiver.
; 2)Only 8-  or 16-bit registers or memory cells can be used as a source.
; ------------------------------------------------------------------------
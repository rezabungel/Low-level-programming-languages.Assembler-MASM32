; Enter 3 unsigned integers of type "db".
; Using the comparison procedure, output the maximum.

; MOVZX - use this command

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

        ; About MOVZX see at the end of the program.
        movzx eax, a                                ; Complements with zero bits. 8 bits will be augmented to 32 bits.
        movzx ebx, b
        movzx ecx, d

        call max

        invoke crt_printf, addr s1, al
        invoke crt__getch
        invoke crt_exit, 0
    end start

; ------------------------------------------------------------------------
; About MOVZX (Move With Zero-Extend)
;
; The MOVZX command allows you to copy data from a smaller source
; (second operand) to a larger receiver (first operand). The result
; will be padded with zero bits. This command is only used when working
; with UNSIGNED INTEGERS.
;
; Limitations:
; 1)Only 16- or 32-bit general-purpose registers can be used as a receiver.
; 2)Only 8-  or 16-bit registers or memory cells can be used as a source.
; ------------------------------------------------------------------------
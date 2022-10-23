; Enter 3 signed integers from the keyboard and output the maximum.

; Solve through the procedure.
; Do not use CMP.

include \masm32\include\masm32rt.inc

.data
a dd ?
b dd ?
d dd ?
public a, b, d

.code
    start:
        mov a, sval(input("Enter a number : "))
        mov b, sval(input("Enter b number : "))
        mov d, sval(input("Enter d number : "))
        
        call max

        exit

        max proc
            mov eax, a
            mov ebx, b
            mov ecx, d
            
            .if eax > ebx
                .if eax > ecx
                    print chr$("a max",13,10)
                 .else
                    print chr$("d max",13,10)
                .endif
            .else
                .if ebx > ecx
                    print chr$("b max",13,10)
                .else
                    print chr$("d max",13,10)
                .endif
            .endif
     
            inkey
            ret
        max endp
    end start
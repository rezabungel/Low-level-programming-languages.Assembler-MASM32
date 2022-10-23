; Solve through the procedure.
; (a+b)/(a-b)

include \masm32\include\masm32rt.inc

.data
    a dd ?
    b dd ?
    va db "Enter a variable a: ", 0
    vb db "Enter a variable b: ", 0
    s1 db "chastnoe = %d ostatok = %d", 0
    tpi db "%d", 0
    tps db "%s", 0

.code
    start:
        call main
        invoke crt_exit, 0

        main proc
            invoke crt_printf, addr tps, addr va        ; API call
            invoke crt_scanf, addr tpi, addr a
        
            invoke crt_printf, addr tps, addr vb
            invoke crt_scanf, addr tpi, addr b

            mov eax, a                                  ; eax = a
            add eax, b                                  ; eax = a+b
    
            mov ebx, a                                  ; ebx = a
            sub ebx, b                                  ; ebx = a-b
    
            xor edx, edx                                ; Zeroing out. Also, zeroing can be done this way: mov edx, 0
    
            idiv ebx                                    ; (a+b)/(a-b) -> when dividing by default, the divisible is taken as eax (that is , we received eax/ecx)
    
            invoke crt_printf, addr s1, eax, edx
            invoke crt__getch
            ret
        main endp
    end start
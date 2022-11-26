;(3a+2b^2)/(2a+b)

;a real8 2.0
;b real8 3.0
;The answer should be 3.428

.586p
.model flat, stdcall
option casemap:none

include /masm32/include/masm32rt.inc

.data
    a real8 2.0
    b real8 3.0

    res real8 0.0

    const1 real8 3.0
    const2 real8 2.0

    temp real8 0.0
    temp1 real8 0.0

.code
    start:
        finit                           ; Bringing the coprocessor to the initial state (clearing the stack)
    
        fld const1                      ; Loading the value "const1" to st(0) -> st(0)=3.0
        fld a                           ; Loading the value "a" to st(0) -> st(0)=a st(1)=3.0
        fmul                            ; st(0)=st(0)*st(1)=3a
        fstp temp                       ; Saving a real number from the top of the coprocessor stack to memory -> temp=st(0)=3a

        fld b                           ; st(0)=b
        fld b                           ; st(0)=b st(1)=b
        fmul                            ; st(0)=st(0)*st(1)=b*b=b^2
        fld const2                      ; st(0)=2.0 st(1)=b^2
        fmul                            ; st(0)=st(0)*st(1)=2b^2=2b^2
        fadd temp                       ; st(0)=st(0)+temp=2b^2+3a
        fstp temp                       ; temp=st(0)=3a+2b^2

        fld const2                      ; st(0)=2.0
        fld a                           ; st(0)=a st(1)=2.0
        fmul                            ; st(0)=st(0)*st(1)=2a
        fadd b                          ; st(0)=st(0)+b=2a+b
        fstp temp1                      ; temp1=st(0)=2a+b

        fld temp                        ; st(0)=3a+2b^2
        fld temp1                       ; st(0)=2a+b st(1)=3a+2b^2

        fdiv                            ; st(0)=(3a+2b^2)/(2a+b)

        fstp res                        ; res=st(0)=(3a+2b^2)/(2a+b)

        print "res=(3a+2b^2)/(2a+b)="
        print real8$(res),13,10
        
        inkey
        exit
    end start
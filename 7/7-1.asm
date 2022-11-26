;3a^2*b-3ab

;a real8 1.5
;b real8 10.0
;The answer should be 22.5

.586p
.model flat, stdcall
option casemap:none

include /masm32/include/masm32rt.inc

.data
    a real8 1.5
    b real8 10.0
    res real8 0.0

    const real8 3.0

    temp real8 0.0
    temp1 real8 0.0

.code
    start:
         finit                           ; Bringing the coprocessor to the initial state (clearing the stack)


        fld a                           ; Loading the value "a" to st(0) -> st(0)=a
        fld a                           ; Loading the value "a" to st(0) -> st(0)=a st(1)=a
        fmul                            ; st(0)=st(0)*st(1)=a*a=a^2
        fstp temp                       ; Saving a real number from the top of the coprocessor stack to memory -> temp=st(0)=a^2

        fld const                       ; st(0)=3.0
        fld b                           ; st(0)=b st(1)=3.0
        fmul                            ; st(0)=st(0)*st(1)=3b
        fstp temp1                      ; temp1=st(0)=3b

        fld temp                        ; st(0)=a^2
        fld temp1                       ; st(0)=3b st(1)=a^2
        fmul                            ; st(0)=st(0)*st(1)=3a^2*b
        fstp temp                       ; temp=st(0)=3a^2*b

        fld const                       ; st(0)=3.0
        fld a                           ; st(0)=a st(1)=3.0
        fmul                            ; st(0)=st(0)*st(1)=3a
        fstp temp1                      ; temp1=st(0)=3a

        fld temp1                       ; st(0)=3a
        fld b                           ; st(0)=b st(1)=3a
        fmul                            ; st(0)=3ab
        fstp temp1                      ; temp1=st(0)=3ab

        fld temp                        ; st(0)=3a^2*b
        fsub temp1                      ; st(0)=st(0)-temp1=3a^2*b-3ab

        fstp res                        ; res=st(0)=3a^2*b-3ab
        
        print "res=(3a^2*b-3ab)="
        print real8$(res),13,10
        
        inkey
        exit
    end start

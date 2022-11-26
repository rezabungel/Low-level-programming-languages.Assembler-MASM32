;(sin(x)+1.5x)/0.3

.586p
.model flat, stdcall
option casemap:none

include /masm32/include/masm32rt.inc

.data
    x real8 1.57                        ; Can be changed to the number you need

    res real8 0.0

    const1 real8 1.5
    const2 real8 0.3

    temp real8 0.0

.code
    start:
        finit                           ; Bringing the coprocessor to the initial state (clearing the stack)

        fld const1                      ; st(0)=1.5
        fld x                           ; st(0)=x st(1)=1.5
        fmul                            ; st(0)=st(0)*st(1)=1.5x
        fstp temp                       ; temp=st(0)=1.5x

        fld x                           ; st(0)=x
        fsin                            ; st(0)=sin(st(0))=sin(x)
        fadd temp                       ; st(0)=st(0)+temp=sin(x)+1.5x

        fld const2                      ; st(0)=0.3 st(1)=sin(x)+1.5x

        fdiv                            ; st(0)=(sin(x)+1.5x)/0.3

        fstp res                        ; res=st(0)=(sin(x)+1.5x)/0.3

        print "x="
        print real8$(x),13,10
        
        print "res(x)=(sin(x)+1.5x)/0.3="
        print real8$(res),13,10
        
        inkey
        invoke ExitProcess, 0
    end start
;Working with a coprocessor, real numbers. 
;Calculate the four value of the function in increments of 0.5.
;The choice of the initial values of x is arbitrary.
;The number of signs in the fractional part of the result should not exceed five signs.

;Implement the function: y(x)=(sin(x)+1.5x)/0.3

.586p
.model flat, stdcall
option casemap:none

include /masm32/include/windows.inc 
include /masm32/macros/macros.asm 
uselib kernel32,user32,fpu,masm32

.data
    x real8 1.57                                                ; Can be changed to the number you need
    incr real8 0.5                                              ; Step

    const1 real8 1.5
    const2 real8 0.3

    temp real8 0.0

    titl db "Coprocessor",0
    welcom db "Let's find the value of the function:",0
    expression db "y(x) = (sin(x)+1.5x)/0.3",0
    newLine db 0ah, 0 
    szfmt db "%d. y(x) = ",0
    count dd 1
    
    result db 260 dup(?) 
    buf db 100 dup(?) 
    buf2 db 100 dup(?) 

.code
    start:
    
        mov edi, 4                                              ; Number of iterations
        invoke szCatStr, addr result, addr welcom 
        invoke szCatStr, addr result, addr newLine 
        invoke szCatStr, addr result, addr expression 
        invoke szCatStr, addr result, addr newLine
        invoke szCatStr, addr result, addr newLine

        finit                                                   ; Bringing the coprocessor to the initial state (clearing the stack)
    
      @L:
        fld const1                                              ; st(0)=1.5
        fld x                                                   ; st(0)=x st(1)=1.5
        fmul                                                    ; st(0)=st(0)*st(1)=1.5x
        fstp temp                                               ; temp=st(0)=1.5x

        fld x                                                   ; st(0)=x
        fsin                                                    ; st(0)=sin(st(0))=sin(x)
        fadd temp                                               ; st(0)=st(0)+temp=sin(x)+1.5x

        fld const2                                              ; st(0)=0.3 st(1)=sin(x)+1.5x

        fdiv                                                    ; st(0)=(sin(x)+1.5x)/0.3
       
        invoke wsprintf, addr buf2, addr szfmt, count
        invoke FpuFLtoA, 0, 4, addr buf, SRC1_FPU or SRC2_DIMM  ; Conversion of the result in the coprocessor to a string ; The first parameter is ignored (source in the coprocessor) ; The second is the number of digits in the fractional part ; The third is where to save
        invoke szCatStr, addr result, addr buf2 
        invoke szCatStr, addr result, addr buf 
        invoke szCatStr, addr result, addr newLine 

        fld x                                                   ; st(0)=x
        fadd incr                                               ; st(0)=st(0)+incr=x+0.5
        fstp x                                                  ; x=st(0)=x+0.5

        inc count
        dec edi
        jnz @L

        invoke szCatStr,addr result,addr newLine
        invoke MessageBox,0,addr result,addr titl,MB_ICONINFORMATION
        invoke ExitProcess, 0
    end start
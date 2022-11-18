; Input and output of a matrix of type dd.
; Output the min element. Output the index of the min element.

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
    matrix dd 5 dup(?)                                                              ; Declaration of the matrix
           dd 5 dup(?) 
           dd 5 dup(?)

    number_of_elements equ($-matrix)/4                                              ; Stores the number of all elements
    ncols equ lengthof matrix                                                       ; Stores the number of columns
    nrows equ number_of_elements/ncols                                              ; Stores the number of rows
    type_elemet_in_matrix equ type matrix                                           ; Stores the type of matrix elements. For dd it is 4

    temp dd ?                                                                       ; It will be needed to find the index of the row

    min dd ?                                                                        ; Stores the minimum element of the matrix
    minI dd ?                                                                       ; Stores the row index of the minimum element of the matrix
    minJ dd ?                                                                       ; Stores the column index of the minimum element of the matrix                                

    welcome db "Enter the matrix elements from the keyboard", 0ah, 0
    look_at_the_matrix db "Your matrix:", 0ah, 0
    output_of_the_element db "%d ", 0
    start_find_min db "Search for the minimum element and its indexes...", 0ah, 0
    min_elemet_with_index db "min (%d,%d) = %d",0ah, 0
    
    sep db 0ah, 0                                                                   ; We use it to transfer a line to a new line
  
.code
    start:

      ;Step 1. Input the matrix from the keyboard. 
      
        invoke crt_printf, addr welcome
        mov ebx, offset matrix
        mov ecx, nrows                                                              ; External cycle - passing through rows 

      cycleI_input:
        mov esi, 0
        push ecx                                                                    ; Save the value of the counter of the external cycle to the stack, because the nested cycle comes next
        mov ecx, ncols                                                              ; Nested cycle - passing through columns

          cycleJ_input:
            push ecx                                                                ; Save ECX to the stack, because ECX value will change (because of SVAL)
            mov [ebx+esi], sval(input("Enter the value of the matrix element: "))   ; Input and conversion to signed integer. (SVAL - convert the result to a signed integer).
            add esi, type_elemet_in_matrix                                          ; Moving on to the next element of the matrix (+4 because the type is dd) - (type_elemet_in_matrix -> store 4)
            pop ecx                                                                 ; Getting the value of the counter of the nested cycle from the stack
          loop cycleJ_input
          
        add ebx, ncols*type_elemet_in_matrix                                        ; Move on to the next row
        invoke crt_printf, addr sep                  
        pop ecx                                                                     ; Getting the value of the counter of the external cycle from the stack
      loop cycleI_input
            
      ;Step 2. Output of the resulting matrix to the console.

        invoke crt_printf, addr look_at_the_matrix
        mov ebx, offset matrix
        mov ecx, nrows                                                  ; External cycle - passing through rows 

      cycleI_output:
        mov esi, 0
        push ecx                                                        ; Save the value of the counter of the external cycle to the stack, because the nested cycle comes next
        mov ecx, ncols                                                  ; Nested cycle - passing through columns

          cycleJ_output:
            push ecx                                                    ; Save ECX to the stack, because when invoke is called, the ECX value will change
            mov eax, [ebx+esi]
            invoke crt_printf, addr output_of_the_element, eax
            add esi, type_elemet_in_matrix                              ; Moving on to the next element of the matrix (+4 because the type is dd) - (type_elemet_in_matrix -> store 4)
            pop ecx                                                     ; Getting the value of the counter of the nested cycle from the stack
          loop cycleJ_output

        add ebx, ncols*type_elemet_in_matrix                            ; Move on to the next row
        invoke crt_printf, addr sep
        
        pop ecx                                                         ; Getting the value of the counter of the external cycle from the stack
      loop cycleI_output

      ;Step 3. Search for the minimum element and its indexes.

        invoke crt_printf, addr sep
        invoke crt_printf, addr start_find_min
        
        mov ebx, offset matrix
    
        mov eax, [ebx+0]
        mov min, eax                                                    ; Before the start of the cycle, the first element of the matrix will be considered as the minimum element
        mov minI, 0
        mov minJ, 0

        mov ecx, nrows                                                  ; External cycle - passing through rows

      cycleI_find_min:
        mov esi, 0
        mov temp, ecx                                                   ; It will be needed to find the index of the row
        push ecx                                                        ; Save the value of the counter of the external cycle to the stack, because the nested cycle comes next

        mov ecx, ncols                                                  ; Nested cycle - passing through columns

          cycleJ_find_min:
            push ecx                                                    ; Save the value of the counter of the external cycle to the stack 
            mov eax, [ebx+esi]
                
           cmp eax, min                                                 ; Comparing the current and estimated minimum element
            
           jge curr_not_min                                             ; If the current element is greater than or equal to the estimated minimum, then jump "curr_not_min"

              ;Saving a new minimum element
                mov min, eax                                            

              ;Getting the row index
                mov minI, 3
                mov edx, temp
                sub minI, edx

              ;Getting the column index
                mov eax, esi                                            ; eax - divisible
                mov ecx, type_elemet_in_matrix                          ; ecx - divider
                xor edx, edx                                            ; Zeroing out. Also, zeroing can be done this way: mov edx, 0
                idiv ecx                                                ; Do -> eax/eac -> get -> eax - private, edx - remains
                mov minJ, eax
                
           curr_not_min:                                                ; We here if the current element >= the estimated minimum

            add esi, type_elemet_in_matrix                              ; Moving on to the next element of the matrix (+4 because the type is dd) - (type_elemet_in_matrix -> store 4)
            pop ecx                                                     ; Getting the value of the counter of the nested cycle from the stack
          loop cycleJ_find_min

        add ebx, ncols*type_elemet_in_matrix                            ; Move on to the next row
        pop ecx                                                         ; Getting the value of the counter of the external cycle from the stack
      loop cycleI_find_min

        invoke crt_printf, addr min_elemet_with_index, minI, minJ, min
        invoke crt__getch
        invoke crt_exit, 0
    end start
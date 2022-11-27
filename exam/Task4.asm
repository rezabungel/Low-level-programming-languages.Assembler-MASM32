; Set a one-dimensional array of natural numbers.
; Delete all odd numbers and output the remaining array of even numbers to the console and a text file.

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
    initial_array dd 5 dup(?)                                                   ; Creating an uninitialized array of 5 elements
    len_initial_array equ($-initial_array)/4                                    ; Stores the length of the array

    result_array dd 5 dup(?)                                                    ; All even numbers from the initial_array array will be put into this array
    len_result_array dd 0                                                       ; Stores the length of the array

    welcome db "Enter the initial_array elements from the keyboard:", 0ah, 0
    output_info db "Output of an even result array to console:", 0ah, 0
    output_info1 db "Output of an even result array to text file.", 0ah, 0
    output_info2 db "Output to the file is completed.", 0ah, 0
   
    sep db 0ah, 0                                                               ; We use it to transfer a line to a new line
    s1 db "Even array element = %d", 0

    fName db "result_file.txt", 0                                               ; Cells for the file
    fHandle dd ?                                                                ; Reservations in 32-bit memory ; Cells named fHandle for file save descriptor
    str1 db "Even array element =", 0
    _size dd ?
    
.code
    start:
    
      ;Step 1. Input the initial_array from the keyboard. 
      
        invoke crt_printf, addr welcome
        mov esi, offset initial_array                                           ; Address of the beginning of the array
        mov ecx, len_initial_array                                              ; Installing the cycle counter. (Cycle counter = number of elements in the array)
        
      metka_for_data_input_cycle:
            push ecx                                                            ; Save ECX to the stack, because ECX value will change
            mov [esi], sval(input("Enter the value of the array element: "))    ; Input and conversion to signed integer. (SVAL - convert the result to a signed integer).
            add esi, 4                                                          ; Moving on to the next element of the array (+4 because the type is dd)
            pop ecx                                                             ; Extracting the value from the stack for ECX
            loop metka_for_data_input_cycle                                     ; Repeat the cycle until ECX is equal to 0

        invoke crt_printf, addr sep                                     

      ;Step 2. Saving even numbers from initial_array to result_array
      
        mov ebx, offset result_array
    
        mov esi, offset initial_array     
        mov ecx, len_initial_array
        
      metka_for_finding_even_numbers:
        push ecx

        xor edx, edx                                                            ; Zeroing out. Also, zeroing can be done this way: mov edx, 0
        mov eax, [esi]
        mov ecx, 2
        idiv ecx                                                                ; Do -> eax/ecx -> get -> eax - private, edx - remains

        cmp edx, 1

        je odd_number
            mov eax, [esi]
            mov [ebx], eax
            add len_result_array, 1                                             ; Saving the number of elements in result_array
            add ebx, 4
            
       odd_number:

        add esi, 4
        pop ecx
        loop metka_for_finding_even_numbers
        
      ;Step 3. Output the result_array to the console. (result_array stores even numbers)
      
        invoke crt_printf, addr output_info  
        mov esi, offset result_array                                            ; Address of the beginning of the array
        mov ecx, len_result_array                                               ; Installing the cycle counter. (Cycle counter = number of elements in the array)
        
      metka_for_data_output_cycle:
            mov eax, [esi]                                                      ; The value from memory at the ESI address is placed in EAX
            add esi, 4                                                          ; Moving on to the next element of the array (+4 because the type is dd)                                       
            push ecx                                                            ; Save ECX to the stack, because when invoke is called, the ECX value will change                                                           
            invoke crt_printf, addr s1, eax
            invoke crt_printf, addr sep
            pop ecx                                                             ; Extracting the value from the stack for ECX
            loop metka_for_data_output_cycle                                    ; Repeat the cycle until ECX is equal to 0

        invoke crt_printf, addr sep

      ;Step 4. Output the result_array to the text file. (result_array stores even numbers)
      
        invoke crt_printf, addr output_info1
        
        invoke  CreateFile, addr fName, \                                       ; Address of the file name with characters
        GENERIC_WRITE, \                                                        ; Writing to a file
        0, NULL, \                                                              ; Multitasking options
        CREATE_ALWAYS, \                                                        ; Destroy and create a new file
        FILE_ATTRIBUTE_NORMAL, 0

        mov fHandle, eax                                                        ; Programming the device descriptor
        
        mov esi, offset result_array                                            ; Address of the beginning of the array
        mov ecx, len_result_array                                               ; Installing the cycle counter. (Cycle counter = number of elements in the array)
        
      metka_for_data_output_to_file_cycle:
            push ecx                                                            ; Save ECX to the stack, because when invoke is called, the ECX value will change 
            mov ebx, [esi]                                                      ; The value from memory at the ESI address is placed in ebx
            add esi, 4                                                          ; Moving on to the next element of the array (+4 because the type is dd)                                       
                                                                     
            invoke WriteFile, fHandle, addr str1, 20, addr _size, 0
            invoke WriteFile, fHandle, str$(ebx), len(str$(ebx)), addr _size, 0
            invoke WriteFile, fHandle, addr sep, 1, addr _size, 0

            pop ecx                                                             ; Extracting the value from the stack for ECX
            loop metka_for_data_output_to_file_cycle                            ; Repeat the cycle until ECX is equal to 0

        invoke  CloseHandle, fHandle                                            
        invoke crt_printf, addr output_info2

        inkey
        invoke crt_exit, 0
    end start
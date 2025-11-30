; Assignment #:Assignment 10
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 11/04/2024
; Revisions: 
; Date:              Modified by:

INCLUDE Irvine32.inc

ExitProcess proto, dwexitCode:dword

.data
CaseTable  DWORD   1           
           DWORD   AND_op     
           EntrySize =  ( $ - CaseTable)
           DWORD   2         
           DWORD   OR_op        
           DWORD   3            
           DWORD   NOT_op       
           DWORD   4           
           DWORD   XOR_op      
           DWORD   5           
           DWORD   EXIT_op      
NumberOfEntries = ( $ - CaseTable) / EntrySize

prompt BYTE "--- Boolean Calculator ---",0
msgA BYTE "1. x AND y",0
msgB BYTE "2. x OR y",0
msgC BYTE "3. NOT x",0
msgD BYTE "4. x XOR y",0
msgE BYTE "5. Exit program",0
msgF BYTE "Enter integer>", 0

prompt1 BYTE "Input the first 32-bit hexadecimal operand: ", 0
prompt2 BYTE "Input the second 32-bit hexadecimal operand: ", 0
errorMsg BYTE "Invalid input. Please enter a number between 1 and 5.", 0

andResultMsg BYTE "The 32-bit hexadecimal AND result is: ", 0
orResultMsg BYTE "The 32-bit hexadecimal OR result is: ", 0
notResultMsg BYTE "The 32-bit hexadecimal NOT result is: ", 0
xorResultMsg BYTE "The 32-bit hexadecimal XOR result is: ", 0 

.code
main PROC
    menu_loop:
        call MENU                   ; Show menu each time
        call ReadInt                ; Read user choice into eax
        ; Check if input is within the range
        cmp eax, 1
        jb invalid_input
        cmp eax, 5
        ja invalid_input

        mov ebx, OFFSET CaseTable    ; Point EBX to the table
        mov ecx, NumberOfEntries     ; Set loop counter based on number of entries

    L1:
        cmp eax, [ebx]               ; Check for match
        jne L2                       ; If no match, continue

        call NEAR PTR [ebx + 4]      ; Call the corresponding operation
        jmp menu_loop                ; Go back to the start of the menu loop

    L2:
        add ebx, EntrySize           ; Move to the next entry
        loop L1                      ; Repeat until ECX = 0 (all entries checked)

invalid_input:
        mov edx, OFFSET errorMsg     
        call WriteString             
        call CrLf                    
        jmp menu_loop                ; Re-prompt the menu if invalid input

main ENDP


input_first_operand PROC
    mov edx, OFFSET prompt1      
    call WriteString
    call ReadHex                 
    mov ebx, eax                ; Store first operand in EBX
    ret
input_first_operand ENDP

; Procedure to prompt for the second operand
input_second_operand PROC
    mov edx, OFFSET prompt2     
    call WriteString
    call ReadHex                 ; Read second operand
    ret
input_second_operand ENDP

MENU PROC
    mov  edx, OFFSET prompt     
    call WriteString
    call CrLf
    mov  edx, OFFSET msgA
    call WriteString
    call CrLf
    mov  edx, OFFSET msgB
    call WriteString
    call CrLf
    mov  edx, OFFSET msgC
    call WriteString
    call CrLf
    mov  edx, OFFSET msgD
    call WriteString
    call CrLf
    mov  edx, OFFSET msgE
    call WriteString
    call CrLf
    call CrLf
    mov  edx, OFFSET msgF
    call WriteString
    ret
MENU ENDP

; Procedure for AND operation
AND_op PROC
    call input_first_operand
    call input_second_operand
    and eax, ebx                
    mov edx, OFFSET andResultMsg
    call WriteString
    call WriteHex               
    call CrLf
    ret
AND_op ENDP

; Procedure for OR operation
OR_op PROC 
    call input_first_operand
    call input_second_operand
    or eax, ebx                  
    mov edx, OFFSET orResultMsg
    call WriteString
    call WriteHex                
    call CrLf
    ret
OR_op ENDP

; Procedure for NOT operation 
NOT_op PROC 
    call input_first_operand
    not ebx                      
    mov edx, OFFSET notResultMsg
    call WriteString
    mov eax, ebx                 
    call WriteHex              
    call CrLf
    ret
NOT_op ENDP

; Procedure for XOR operation
XOR_op PROC
    call input_first_operand
    call input_second_operand
    xor eax, ebx                 
    mov edx, OFFSET xorResultMsg
    call WriteString
    call WriteHex                
    call CrLf
    ret
XOR_op ENDP

EXIT_op PROC
    invoke ExitProcess, 0     
EXIT_op ENDP

END main

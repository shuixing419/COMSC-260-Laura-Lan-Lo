; Assignment #:Lab Exercise 14
; Program Description:Factorial
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 11/27/2024
; Revisions: 
; Date:              Modified by:

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

Factorial PROTO, val1: DWORD
Factorial_loop PROTO, val1: DWORD

.data
prompt1 BYTE "The output from the recursive call - ", 0
prompt2 BYTE "The output from the loop call - ", 0
overflowMsg BYTE "The factorial value is overflowed", 0
nVal DWORD 15

.code
main PROC
    ; Recursive Factorial
    mov edx, OFFSET prompt1
    call WriteString
    mov eax, nVal
    call WriteDec
    call Crlf
    INVOKE Factorial, nVal
    jo overflow         ; Jump if overflow
    call WriteDec       ; Display factorial result
    call Crlf

    ; Iterative Factorial
    mov edx, OFFSET prompt2
    call WriteString
    mov eax, nVal
    call WriteDec
    call Crlf
    INVOKE Factorial_loop, nVal
    jo overflow         ; Jump if overflow
    call WriteDec       ; Display factorial result
    call Crlf
    jno endMain         ; Exit if no overflow

overflow:
    mov edx, OFFSET overflowMsg
    call WriteString
    call Crlf

endMain:
    exit
main ENDP

Factorial PROC, val1: DWORD
    mov eax, val1        ; Get n
    cmp eax, 1           ; Base case: n <= 1
    ja L1                ; If n > 1, continue
    mov eax, 1           ; Otherwise, return 1
    ret

L1:
    dec eax              ; Prepare n-1
    PUSH eax             ; Save argument for recursive call
    CALL Factorial       ; Recursive call
    ADD esp, 4           ; Clean up stack

    mov ebx, val1        ; Get original n
    mul ebx              ; eax = eax * n
    ret
Factorial ENDP

Factorial_loop PROC, val1: DWORD
    mov ecx, val1        ; Get n
    mov eax, 1           ; Initialize result to 1

L1:
    cmp ecx, 0           ; Check if ecx == 0
    jz L2                ; If yes, exit loop
    mul ecx              ; Multiply eax by ecx
    dec ecx              ; Decrement ecx
    jmp L1               ; Repeat

L2:
    ret
Factorial_loop ENDP

END main

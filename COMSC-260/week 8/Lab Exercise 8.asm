; Assignment #:Lab Exercise 8
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 10/16/2024
; Revisions: 
; Date:              Modified by:

INCLUDE Irvine32.inc
.data
prompt1 BYTE "Enter first integer: ",0
prompt2 BYTE "Enter second integer: ",0
resultMsg BYTE "The sum is: ",0
color DWORD 17 ; Initial color value

.code
main PROC
    mov ecx, 3       

loopStart:
    ; Set background and foreground colors
    mov eax, color
    call SetTextColor
    call Clrscr       ; Clear screen after setting colors

    ; Ask user for the first integer
     mov eax, yellow + (blue * 16)
     call SetTextColor
     mov edx, OFFSET prompt1
     call WriteString
    call ReadInt      ; Input first integer
    push eax          ; Save first integer on stack

    ; Ask user for the second integer
    mov ebx, yellow + (green * 16)
    call SetTextColor
    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt      ; Input second integer
    mov ebx, eax      ; Store second integer in ebx

    ; Retrieve the first integer from the stack and add to second
    pop eax           ; Retrieve first integer
    add eax, ebx      ; Add integers

    ; Display the result
    call Crlf
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt     ; Display sum

    ; Wait for user input
    call Crlf
    call WaitMsg

    ; Update color for the next iteration (background and foreground)
    add color, 17     ; Change color for next loop

    loop loopStart    ; Repeat 3 times

    ; Return console window to default colors
    mov eax, lightGray + (black * 16)
    call SetTextColor
    call Clrscr

    exit
main ENDP
END main

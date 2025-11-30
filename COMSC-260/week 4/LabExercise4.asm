; Program Template           (Template.asm)

; Assignment #: Lab Exercise 4
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 9/18/2024
; Revisions: 
; Date:              Modified by:


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC
    ; Move the values into the registers
	mov eax, 500
    mov ebx, 200
    mov ecx, 300
    mov edx, 400
   
   
    add eax, ebx; 
    add ecx, edx; 
    sub eax, ecx; 

	INVOKE ExitProcess,0
main ENDP
END main
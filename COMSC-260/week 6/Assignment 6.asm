; Assignment #:Assignment 6
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 10/06/2024
; Revisions: 
; Date:              Modified by:
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data 
arrayW WORD 100h, 200h, 300h, 400h, 500h, 600h, 700h, 800h, 900h, 1000h, 1200h, 2000h, 3000h

.code
main PROC

mov esi, OFFSET arrayW
mov edi, OFFSET arrayW
add edi, SIZEOF arrayW
sub edi, TYPE arrayW

mov ecx, LENGTHOF arrayW / 2

L1:
    mov ax, [esi]
    mov bx, [edi]
    mov [edi], ax
    mov [esi], bx

    add esi, TYPE arrayW
    sub edi, TYPE arrayW

    loop L1

; Reset pointers for the second loop
mov esi, OFFSET arrayW
mov edi, OFFSET arrayW
add edi, SIZEOF arrayW
sub edi, TYPE arrayW

mov ecx, LENGTHOF arrayW / 2

L2:
    mov ax, [esi]
    mov bx, [edi]
    mov [edi], ax
    mov [esi], bx

    add esi, TYPE arrayW
    sub edi, TYPE arrayW

    loop L2

INVOKE ExitProcess, 0
main ENDP
END main
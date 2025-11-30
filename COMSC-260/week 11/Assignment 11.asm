; Assignment #:Assignment 11
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 11/10/2024
; Revisions: 
; Date:              Modified by:

.386
.model flat,stdcall
.stack 4096

INCLUDE Irvine32.inc

ExitProcess proto, dwExitCode:dword

MAXBUF = 128

.data
key BYTE -5, 3, 2, -3, 0, 5, 2, -4, 7, 9
prompt BYTE "Please enter one plain text: ", 0
message BYTE "This plain text after encoded: ", 0
messageR BYTE "This plain text after decoded: ", 0
keySize = $ - key
buffer BYTE MAXBUF+1 DUP(0)

.code
main PROC
    call Clrscr
    mov edx, OFFSET prompt
    call WriteString
    call Crlf
    mov ecx, MAXBUF
    mov edx, OFFSET buffer
    call ReadString
    call Crlf
    mov esi, OFFSET buffer

Encode: 
    mov ecx, keySize
    mov edi, OFFSET key
    call Encryption

    mov edx, OFFSET message
    call WriteString
    call Crlf
    mov edx, OFFSET buffer
    call WriteString
    call Crlf
    call Crlf

Decode: 
    mov esi, OFFSET buffer
    mov edi, OFFSET key
    mov ecx, keySize
    call Decryption

    mov edx, OFFSET messageR
    call WriteString
    call Crlf
    mov edx, OFFSET buffer
    call WriteString
    call Crlf
    call Crlf

    invoke ExitProcess, 0
main ENDP

Encryption PROC
L1: 
    push ecx
    cmp BYTE PTR [esi], 0
    je L4

    mov cl, [edi]
    cmp cl, 0
    jge L2
    rol BYTE PTR [esi], cl
    jmp L3

L2: 
    ror BYTE PTR [esi], cl

L3: 
    inc esi
    inc edi
    pop ecx
    loop L1
     
    or eax, 1
    jmp L5

L4: 
    pop ecx

L5: 
    ret
Encryption ENDP

Decryption PROC
L1: 
    push ecx
    cmp BYTE PTR [esi], 0
    je L4

    mov cl, [edi]
    cmp cl, 0
    jge L2
    ror BYTE PTR [esi], cl ; Reverse rotation direction for decryption
    jmp L3

L2: 
    rol BYTE PTR [esi], cl ; Reverse rotation direction for decryption

L3: 
    inc esi
    inc edi
    pop ecx
    loop L1
     
    or eax, 1
    jmp L5

L4: 
    pop ecx

L5: 
    ret
Decryption ENDP

END main

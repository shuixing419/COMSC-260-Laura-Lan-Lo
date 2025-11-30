; Assignment #:Assignment 12
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 11/17/2024
; Revisions: 
; Date:              Modified by:

INCLUDE Irvine32.inc

.data
packed_1a WORD 4536h
packed_1b WORD 7297h
sum_1 DWORD 0

packed_2a DWORD 67345620h
packed_2b DWORD 54496342h
sum_2 DWORD 2 DUP(0)

packed_3a QWORD 6734562000346521h
packed_3b QWORD 5449634205738261h
sum_3 DWORD 3 DUP(0)

.data?
hexBuffer BYTE 9 DUP(0)    ; Buffer for hexadecimal string

.code
main PROC
    ; Initialize sum and index for packed_1
    mov esi, OFFSET packed_1a
    mov edi, OFFSET packed_1b
    mov edx, OFFSET sum_1
    mov ecx, (SIZEOF packed_1a / TYPE WORD)
    call AddPacked

    ; Display the sum in hexadecimal
    mov eax, sum_1
    call WriteHex
    call Crlf

    ; Initialize sum and index for packed_2
    mov esi, OFFSET packed_2a
    mov edi, OFFSET packed_2b
    mov edx, OFFSET sum_2
    mov ecx, 2
    call AddPacked

    ; Display the sum in hexadecimal
    mov esi, OFFSET sum_2
    add esi, ((SIZEOF sum_2 / TYPE DWORD) * 4)
    mov ecx, (SIZEOF sum_2 / TYPE DWORD)
L1:
    sub esi, TYPE DWORD
    mov eax, [esi]
    call WriteHexNoLeadingZeros
    loop L1
    call Crlf

    ; Initialize sum and index for packed_3
    mov esi, OFFSET packed_3a
    mov edi, OFFSET packed_3b
    mov edx, OFFSET sum_3
    mov ecx, 4
    call AddPacked

    ; Display the sum in hexadecimal
    mov esi, OFFSET sum_3
    add esi, ((SIZEOF sum_3 / TYPE DWORD) * 4)
    mov ecx, (SIZEOF sum_3 / TYPE DWORD)
L2:
    sub esi, TYPE DWORD
    mov eax, [esi]
    call WriteHexNoLeadingZeros
    loop L2
    call Crlf

    ; Wait for user input before exiting
    call WaitMsg
    exit
main ENDP

; AddPacked procedure: Adds two packed numbers
AddPacked PROC
L1:
    ; Add low bytes
    clc
    mov al, BYTE PTR [esi]
    add al, BYTE PTR [edi]
    daa
    mov BYTE PTR [edx], al

    ; Add high bytes, include carry
    inc esi
    inc edi
    inc edx
    mov al, BYTE PTR [esi]
    adc al, BYTE PTR [edi]
    daa
    mov BYTE PTR [edx], al

    ; Add final carry, if any
    mov al, 0
    adc al, 0
    inc edx
    mov BYTE PTR [edx], al
    inc esi
    inc edi
    loop L1
    ret
AddPacked ENDP

; WriteHexNoLeadingZeros procedure: Prints a hexadecimal value without leading zeros
WriteHexNoLeadingZeros PROC
    push ebx                     ; Preserve registers
    push ecx
    push edx
    push esi

    mov esi, OFFSET hexBuffer    ; Point to the buffer
    mov ecx, 8                   ; 8 nibbles for a 32-bit value
    mov ebx, eax                 ; Copy EAX to EBX
    mov edx, 0                   ; Flag to track first non-zero digit

    ; Convert each nibble to ASCII
ConvertLoop:
    rol ebx, 4                   ; Rotate left by 4 bits to extract the highest nibble
    mov al, bl                   ; Get the nibble
    and al, 0Fh                  ; Mask the lower 4 bits
    add al, '0'                  ; Convert to ASCII
    cmp al, '9'
    jbe StoreDigit
    add al, 7                    ; Adjust for A-F

StoreDigit:
    cmp edx, 0                   ; Check if a non-zero digit has been found
    jne WriteToBuffer
    cmp al, '0'                  ; Skip leading zeros
    jne SetFlag
    jmp NextNibble

SetFlag:
    mov edx, 1                   ; Set flag to start writing digits

WriteToBuffer:
    mov [esi], al                ; Write the digit to the buffer
    inc esi

NextNibble:
    loop ConvertLoop

    ; Handle the case where the value is zero
    cmp edx, 0
    jne PrintBuffer
    mov al, '0'
    mov [esi], al
    inc esi

PrintBuffer:
    mov byte ptr [esi], 0        ; Null-terminate the string
    mov edx, OFFSET hexBuffer    ; Point EDX to the buffer
    call WriteString             ; Print the string

    ; Restore registers and return
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
WriteHexNoLeadingZeros ENDP

END main

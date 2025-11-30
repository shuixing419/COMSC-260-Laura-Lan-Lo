; Packed Decimal Addition: AddPacked Procedure
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

.code
main PROC
    ; Test 4-byte addition
    mov esi, OFFSET packed_1a
    mov edi, OFFSET packed_1b
    mov edx, OFFSET sum_1
    mov ecx, 4 ; Number of bytes to add
    call AddPacked
    mov eax, OFFSET sum_1
    call WriteHex
    call Crlf

    ; Test 8-byte addition
    mov esi, OFFSET packed_2a
    mov edi, OFFSET packed_2b
    mov edx, OFFSET sum_2
    mov ecx, 8 ; Number of bytes to add
    call AddPacked
    mov eax, OFFSET sum_2
    call WriteHex
    call Crlf

    ; Test 16-byte addition
    mov esi, OFFSET packed_3a
    mov edi, OFFSET packed_3b
    mov edx, OFFSET sum_3
    mov ecx, 16 ; Number of bytes to add
    call AddPacked
    mov eax, OFFSET sum_3
    call WriteHex
    call Crlf

    exit
main ENDP

; AddPacked Procedure
; ESI - Pointer to the first packed decimal number
; EDI - Pointer to the second packed decimal number
; EDX - Pointer to the sum
; ECX - Number of bytes to add
AddPacked PROC
    xor eax, eax        ; Clear accumulator
    xor ebx, ebx        ; Clear carry register

    AddLoop:
        mov al, BYTE PTR [esi] ; Load byte from first number
        add al, BYTE PTR [edi] ; Add byte from second number
        add al, bl             ; Add carry
        daa                    ; Decimal adjust after addition
        mov BYTE PTR [edx], al ; Store result byte
        adc bl, 0              ; Update carry flag

        ; Increment pointers
        inc esi
        inc edi
        inc edx
        loop AddLoop           ; Repeat for all bytes

    ; Handle leftover carry
    cmp bl, 0
    je EndAddPacked
    mov BYTE PTR [edx], bl     ; Store the carry if non-zero

    EndAddPacked:
    ret
AddPacked ENDP
END main

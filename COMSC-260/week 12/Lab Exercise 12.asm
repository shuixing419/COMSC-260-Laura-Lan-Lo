INCLUDE Irvine32.inc

.data
; 4-byte test values
packed_1a WORD 4536h
packed_1b WORD 7297h
sum_1    DWORD 0

; 8-byte test values
packed_2a DWORD 67345620h
packed_2b DWORD 54496342h
sum_2    DWORD 2 DUP(0)

; 16-byte test values
packed_3a QWORD 6734562000346521h
packed_3b QWORD 5449634205738261h
sum_3    DWORD 3 DUP(0)

.code
main PROC
    ; Test 4-byte addition
    mov esi, OFFSET packed_1a
    mov edi, OFFSET packed_1b
    mov edx, OFFSET sum_1
    mov ecx, 4              ; 4 bytes to process
    call AddPacked
    
    ; Display 4-byte result
    mov eax, sum_1
    call WriteDec          ; Display as decimal instead of hex
    call Crlf

    ; Test 8-byte addition
    mov esi, OFFSET packed_2a
    mov edi, OFFSET packed_2b
    mov edx, OFFSET sum_2
    mov ecx, 8              ; 8 bytes to process
    call AddPacked
    
    ; Display 8-byte result
    mov eax, sum_2
    call WriteDec          ; Display as decimal
    call Crlf

    ; Test 16-byte addition
    mov esi, OFFSET packed_3a
    mov edi, OFFSET packed_3b
    mov edx, OFFSET sum_3
    mov ecx, 16             ; 16 bytes to process
    call AddPacked
    
    ; Display 16-byte result
    mov eax, sum_3
    call WriteDec          ; Display as decimal
    call Crlf

    exit
main ENDP

; AddPacked Procedure
; Parameters:
;   ESI = pointer to first packed decimal number
;   EDI = pointer to second packed decimal number
;   EDX = pointer to sum
;   ECX = number of bytes to process
AddPacked PROC USES eax ebx ecx edx esi edi
    push ecx                ; Save original count
    dec ecx                 ; Adjust for 0-based indexing
    clc                     ; Clear carry flag initially

L1: 
    mov al, BYTE PTR [esi + ecx]    ; Get byte from first number
    adc al, BYTE PTR [edi + ecx]    ; Add byte from second number with carry
    daa                             ; Decimal adjust after addition
    mov BYTE PTR [edx + ecx], al    ; Store result
    dec ecx
    jns L1                          ; Continue if not done

    adc BYTE PTR [edx + ecx + 1], 0 ; Add final carry if any
    
    pop ecx                         ; Restore original count
    ret
AddPacked ENDP

END main
; Assignment #: Assignment 15 
; Program: Str_find Procedure
; Author: Jie Zhou
; Creation Date: 12/07/2024
; Revisions: 
; Date:              Modified by:

INCLUDE Irvine32.inc
Str_find PROTO,  pTarget: PTR BYTE,  pSource:PTR BYTE
.data
prompt1 BYTE "The target string is: ", 0
prompt2 BYTE "The source string is: ", 0
target BYTE "01ABAAAAAABABCC45ABC9012", 0
source BYTE "AAABA", 0
pos DWORD ?
str1 BYTE "Source string found at position: ", 0
str2 BYTE " in Target string (counting from zero).", 0Ah, 0Dh, 0
str3 BYTE "Unable to find Source string in Target String.", 0Ah, 0Dh, 0

.code
main PROC
    mov edx, OFFSET prompt1
    call WriteString
    mov edx, OFFSET target
    call WriteString
    call Crlf
    
    mov edx, OFFSET prompt2
    call WriteString
    mov edx, OFFSET source
    call WriteString
    call Crlf
    call Crlf
    
    INVOKE Str_find, ADDR target, ADDR source
    mov pos, eax
    test eax, eax
    jz not_found
found:
    mov edx, OFFSET str1
    call WriteString
    mov eax, pos
    call WriteDec
    
    mov edx, OFFSET str2
    call WriteString
    jmp quit
not_found:
    mov edx, OFFSET str3
    call WriteString
quit:
    call Crlf
    call WaitMsg
    INVOKE ExitProcess, 0
main ENDP

Str_find PROC USES esi edi ecx, pTarget: PTR BYTE, pSource: PTR BYTE
    ; Get lengths of target and source strings
    INVOKE Str_length, pTarget
    mov ecx, eax             ; Target length in ECX
    INVOKE Str_length, pSource
    mov edx, eax             ; Source length in EDX
    
    ; If source string is longer than target, return 0
    cmp ecx, edx
    jb no_match
    
    ; Calculate stopping point for searching
    sub ecx, edx             ; Max start position for matching
    inc ecx                  ; Add 1 to include last possible start
    
    ; Initialize pointers
    mov esi, pTarget          ; ESI points to target string
    mov edi, pSource          ; EDI points to source string
    
search_loop:
    push esi                 ; Save current target position
    push edi                 ; Save source string start
    push ecx                 ; Save remaining search iterations
    
    ;compare char
    mov ecx, edx             ; Length of source string
    repe cmpsb               
    
    ; Check if full match occurred
    jz match_found           ; If zero flag set, full match
    
    ; Restore pointers and continue searching
    pop ecx
    pop edi
    pop esi
    
    inc esi                  ; Move to next target position
    loop search_loop        ; Continue searching
    
no_match:
    xor eax, eax             ; Return 0 if no match
    ret
    
match_found:
    ; Clean up stack
    add esp, 12               ; Remove pushed values
    
    ; Calculate match position
    sub esi, pTarget          ; Get offset from target start
    sub esi, edx              ; Adjust back to start of match
    mov eax, esi              ; Return match position
    ret
Str_find ENDP
END main

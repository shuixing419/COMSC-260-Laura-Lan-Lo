
.code
main PROC

mov edx, OFFSET prompt1
call WriteString
call  ReadHex
mov  ebx,eax   ;first value stored in ebx

mov edx, OFFSET prompt2
call WriteString
call ReadHex   ;second value stored in eax

call AND_op
call OR_op
call NOT_op
call XOR_op

    exit
main ENDP

AND_op PROC
    and eax, ebx          ; AND
    mov edx, OFFSET andResultMsg
    call WriteString
    call WriteHex         ; Display result of AND operation
    call CrLf
    ret
AND_op ENDP

; Procedure for OR operation
OR_op PROC 
    or eax, ebx           ; OR 
    mov edx, OFFSET orResultMsg
    call WriteString
    call WriteHex         ; Display result of OR operation
    call CrLf
    ret
OR_op ENDP

; Procedure for NOT operation 
NOT_op PROC 
    not ebx               ;Not the first  integer
    mov edx, OFFSET notResultMsg
    call WriteString
    mov eax,ebx
    call WriteHex         ; Display result of NOT operation
    call CrLf
    ret
NOT_op ENDP

; Procedure for XOR operation
XOR_op PROC
    xor eax, ebx          ; XOR
    mov edx, OFFSET xorResultMsg
    call WriteString
    call WriteHex         ; Display result of XOR operation
    call CrLf
    ret
XOR_op ENDP

END main
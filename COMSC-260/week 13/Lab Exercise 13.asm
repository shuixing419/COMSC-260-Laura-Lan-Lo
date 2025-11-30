; Assignment #:Lab Exercise 13
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 11/20/2024
; Revisions: 
; Date:              Modified by:
; Demonstrate reference parameters   (ArrayFill.asm)

; This program fills an array with 32-bit randomly generated integers.

INCLUDE Irvine32.inc

.data
count = 25
array1 DWORD count DUP(?)
array2 DWORD count DUP(?)
array3 DWORD count DUP(?)
msg1 BYTE "===The output from Arrayfill1===",0
msg2 BYTE "===The output from Arrayfill2===",0
msg3 BYTE "===The output from Arrayfill3===",0

.code
main PROC

;ArrayFill 1
	push OFFSET array1
	push COUNT
	call ArrayFill1
	mov edx, OFFSET msg1     
	call WriteString
	call CRLF
	mov ESI, OFFSET array1
	call PrintArray

;ArrayFill 2
	push OFFSET array2
	push COUNT
	call ArrayFill2
	mov edx, OFFSET msg2    
	call WriteString
	call CRLF
	mov ESI, OFFSET array2
	call PrintArray

;ArrayFill 3
	push OFFSET array3
	push COUNT
	call ArrayFill3
	mov edx, OFFSET msg3     
	call WriteString
	call CRLF
	mov ESI, OFFSET array3
    call PrintArray

	exit
main ENDP

ArrayFill1 PROC	
	push	ebp
	mov	ebp,esp
	pushad			; save registers
	mov	esi,[ebp+12]	; offset of array
	mov	ecx,[ebp+8]	; array size
	cmp	ecx,0		; ECX == 0?
	je	L2			; yes: skip over loop
    
	mov edx, 300
	mov ebx, -100
L1:
	mov	eax, edx	 
	call	RandomRange	; from the link library
	add eax, ebx    ; get random -100--300  
	mov	[esi], EAX  
	add	esi,TYPE DWORD
	loop	L1

L2:	popad			; restore registers
	pop	ebp
	ret	8			; clean up the stack
ArrayFill1  ENDP

ArrayFill2 PROC	
	enter 0, 0
	pushad			; save registers
	mov	esi,[ebp+12]	; offset of array
	mov	ecx,[ebp+8]	; array size
	cmp	ecx,0		; ECX == 0?
	je	L2			; yes: skip over loop
    
	mov edx, 300
	mov ebx, -100
L1:
	mov	eax, edx	
	call	RandomRange	; from the link library
	add eax,ebx       ; get random -100--300
	mov	[esi], EAX
	add	esi,TYPE DWORD
	loop	L1

L2:	popad			; restore registers
	leave
	ret	8			; clean up the stack
ArrayFill2 ENDP

ArrayFill3 PROC	
    LOCAL UPPER:DWORD, LOWER:DWORD
    mov UPPER, 300       ; Upper bound for random number
    mov LOWER, -100      ; Lower bound for random number

	pushad			; save registers
	mov	esi,[ebp+12]	; offset of array
	mov	ecx,[ebp+8]	; array size
	cmp	ecx,0		; ECX == 0?
	je	L2			; yes: skip over loop
    
L1:
	mov	eax, UPPER	
	call RandomRange	
	add eax, LOWER
	mov	[esi], EAX
	add	esi,TYPE DWORD
	loop	L1

L2:	
	ret	8			; clean up the stack
ArrayFill3 ENDP



PrintArray PROC
    mov ECX, count      ; Set loop counter to array size
PrintLoop:
    mov eax, [ESI]  ; Load value from array
    call WriteInt            ; Write integer
    call CRLF                ; Newline
    add ESI, TYPE DWORD      ; Move to next element
    loop PrintLoop           ; Loop until all elements are printed
    ret
PrintArray ENDP

END main
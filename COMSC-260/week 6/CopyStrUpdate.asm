; Copying a String (CopyStr.asm)

; This program copies a string.

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:dword

.data
source  byte  "This is the source string",0
target  byte  SIZEOF source DUP(0),0

.code
main proc

	mov  esi, OFFSET source	; indirect addressing register
	mov  edi, OFFSET target	; indirect addressing register
	mov  ecx, SIZEOF source	; loop counter
L1:
	mov  al, [esi]			; get a character from source
	mov  [edi],al			; store it in the target
	inc  esi				; move to next character
	inc  edi				; move to next character
	loop L1					; repeat for entire string

	invoke ExitProcess,0
main endp
end main
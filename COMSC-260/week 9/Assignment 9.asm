; Assignment #:Assignment 9
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 10/27/2024
; Revisions: 
; Date:              Modified by:

INCLUDE Irvine32.inc

KEY = 239		  ; any value between 1-255
BUFMAX = 128      ; maximum buffer size

.data

sPrompt  BYTE  "Enter the plain text: ",0
sKey	 BYTE  "Enter the encrption key: ", 0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0
buffer   BYTE   BUFMAX+1 DUP(0)
bufSize  DWORD  ?
keyBuf   BYTE   KEY+1 DUP(0)
keySize  DWORD  ?

.code
main PROC

call InputTheString			; input the plain text

call InputEncryptKey

call TranslateBuffer		    ; encrypt the buffer
mov edx, OFFSET sEncrypt		; display encrypted message
call DisplayMessage

call TranslateBuffer		    ; decrypt the buffer
mov edx, OFFSET sDecrypt		; display decrypted message
call DisplayMessage

Invoke ExitProcess, 0
main ENDP

							; Prompts user for a plaintext string. Saves the string and its length.
	InputTheString PROC		; Receives: nothing
							; Returns: nothing

		pushad
		mov edx, OFFSET sPrompt	; display a prompt
		call WriteString
		mov ecx, BUFMAX			 ; maximum character count
		mov edx, OFFSET buffer   ; point to the buffer
		call ReadString          ; input the string
		mov bufSize, eax         ; save the length
		call Crlf
		popad
		ret

InputTheString ENDP

	InputEncryptKey PROC
		
		pushad
		mov edx, OFFSET sKey
		call WriteString
		mov ecx, KEY
		mov edx, OFFSET keyBuf
		call ReadString
		mov keySize, eax
		call Crlf
		popad
		ret

InputEncryptKey ENDP


	TranslateBuffer PROC	; Translates the string by exclusive-ORing each byte with the encryption key byte.
							; Receives: nothing
							; Returns: nothing

		pushad
		mov ecx, bufSize		; loop counter
		mov esi, 0			; index 0 in buffer
		mov edi, 0          ; index 0 in keyBuf
						
	L1:
		cmp keyBuf[edi],0
		jne L2
		mov edi, 0

		L2:	
			mov al, keyBuf[edi]
			xor buffer[esi], KEY  ; translate a byte
			inc esi				  ; point to next byte
			inc edi
		
	loop L1
	popad
	ret

TranslateBuffer ENDP

	DisplayMessage PROC		; Displays the encrypted or decrypted message.
							; Receives: EDX points to the message
							; Returns:  nothing

		pushad
		call WriteString
		mov edx, OFFSET buffer ; display the buffer
		call WriteString
		call Crlf
		call Crlf
		popad
		ret

DisplayMessage ENDP

END main
; Assignment #:Assignment 7
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 10/13/2024
; Revisions: 
; Date:              Modified by:
.386
.model flat,stdcall
.stack 4096

INCLUDE Irvine32.inc

ExitProcess proto, dwexitCode:dword

.data

lowerPrompt BYTE "Please enter the lower bound: ", 0
upperPrompt BYTE "Please enter the upper bound: ", 0
xx SDWORD ?
cc SDWORD ?
count DWORD ?

.code
main PROC

call Randomize

mov ecx, 3

L1:
mov count, ecx


mov edx, OFFSET lowerPrompt
call WriteString   
call ReadInt	  
mov xx, eax


mov edx, OFFSET upperPrompt
call WriteString    
call ReadInt		
mov cc, eax

mov eax, cc
mov ebx, xx

mov ecx, 30

L2:	
	push eax
	push ebx
	call BetterRandomRange
	pop ebx
	pop eax
	loop L2

mov ecx, count
loop L1

	invoke ExitProcess,0

main ENDP

BetterRandomRange PROC 
	
	sub eax, ebx
	call RandomRange
	add eax, ebx
	call WriteInt
	call Crlf
	ret
	
BetterRandomRange ENDP

END main
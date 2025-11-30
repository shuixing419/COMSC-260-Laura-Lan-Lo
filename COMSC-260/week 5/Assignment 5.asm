; Assignment #:Lab Exercise 5
; Program Description:
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 9/29/2024
; Revisions: 
; Date:              Modified by:

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data

bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?

.code
main PROC

  mov al,[bigEndian+3]
  mov BYTE PTR littleEndian,al
 
  mov al,[bigEndian+2]
  mov BYTE PTR littleEndian+1,al
 
  mov al,[bigEndian+1]
  mov BYTE PTR littleEndian+2,al
 
  mov al,[bigEndian]
  mov BYTE PTR littleEndian+3,al

INVOKE ExitProcess, 0
main ENDP
END main
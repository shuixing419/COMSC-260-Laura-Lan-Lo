; Program Template           (Template.asm)

; Assignment #:Assignment 4
; Program Description:SUM = (A + B) − (C + D)
; Author: Jie Zhou (student:2047477)
; Creation Date:
; Revisions: 
; Date:              Modified by:

.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode: DWORD

.data

valueA DWORD -2000
valueB DWORD 100
valueC DWORD 1000
valueD DWORD -500
sum DWORD 0

sValueA DWORD 1000
sValueB DWORD 500
sValueC DWORD 450
sValueD DWORD 100
ssum DWORD 0

.code 
main PROC

mov eax, valueA       
mov ebx, valueB       
mov ecx, valueC       
mov edx, valueD       

add eax, ebx          
add ecx, edx          
sub eax, ecx          

mov sum, eax          
mov eax, sValueA      
mov ebx, sValueB      
mov ecx, sValueC      
mov edx, sValueD      

add eax, ebx          
add ecx, edx          
sub eax, ecx          

mov ssum, eax         

INVOKE ExitProcess, 0

main ENDP
END main

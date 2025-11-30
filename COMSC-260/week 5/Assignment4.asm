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

valueA DWORD 1000
valueB DWORD 500
valueC DWORD 450
valueD DWORD 100
sum DWORD 0

sValueA DWORD -2000
sValueB DWORD 100
sValueC DWORD 1000
sValueD DWORD -500
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

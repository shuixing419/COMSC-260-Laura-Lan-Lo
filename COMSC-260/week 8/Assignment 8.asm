; Assignment #: Assignment 8
; Program Description: Random number generator
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 10/20/2024

.386
.model flat,stdcall
.stack 4096

INCLUDE Irvine32.inc

ExitProcess proto, dwexitCode:dword

.data
    string byte 101 dup(?)    ; 100 char and 1 null terminator
    ptr_string dword string   ; Pointer to the string

.code
main PROC
    call Randomize          
    mov ecx, 20              ; Loop for 20 times

generate_strings:
    ; Generate a random number between 1 and 100
    mov eax, 100
    call RandomRange         
    inc eax                  
            
    call CreateRandomString  
    
    loop generate_strings    

    invoke ExitProcess, 0    
main ENDP

CreateRandomString PROC  USES ecx esi
    mov ecx, eax             
    mov esi, OFFSET string   

generate_char:
    mov eax, 26              
    call RandomRange         
    add eax, 65              ; Convert to ASCII value of 'A'
    mov [esi], al            ; Store the character in the buffer at esi
    inc esi                  
            
    loop generate_char        ; Repeat for the length of the string

    mov byte ptr [esi], 0
    mov edx, OFFSET string
    call WriteString
    call Crlf                
    ret
CreateRandomString ENDP

END main

; Assignment #:Assignment 14
; Program£º Chess Board with Alternating Colors 
; Author: Jie Zhou (student ID: 2047477)
; Creation Date: 12/02/2024
; Revisions: 
; Date:              Modified by:


INCLUDE Irvine32.inc

; Procedure Prototypes
Print_Board PROTO, color:BYTE
PrintRow PROTO, color1:BYTE, color2:BYTE
WriteColorBlock PROTO, backcolor:BYTE

.data
rows = 8
columns = 8
white = 15        ; White color code for the background

.code
main PROC
    mov bl, 0
    mov ecx, 16            ; Loop 16 times 
main_loop:
    INVOKE Print_Board, bl 
    INVOKE Sleep, 500

    ; Cycle to the next background color
    inc bl
    cmp bl,16
    je end_program
    jmp main_loop

end_program:
    mov eax, 15              ; White color for text (foreground)
    mov ebx, 0               ; Black color for background (no need to shift, it's default)
    shl ebx, 4               ; Set background color to black (shifting to the background part)
    or eax, ebx              ; Combine foreground and background
    call SetTextColor        ; Apply the color reset

    INVOKE ExitProcess, 0     
main ENDP

Print_Board PROC color:BYTE

    mov dh, 0           ; Row number
    mov si, rows        ; Set row count to rows

board_loop:
    mov dl, 0           ; Column number
    call Gotoxy         ; Move cursor to (dh, dl)

    ; Alternate row starting colors
    test dh, 1          ; Check if row number is odd
    jz even_row         ; Jump if even row
    INVOKE PrintRow, color, white ; Odd row
    jmp row_done
even_row:
    INVOKE PrintRow, white, color ; Even row
row_done:
    call crlf           ; Move to the next line
    inc dh              ; Increment row number
    dec si              ; Decrement row counter (in cx)
    jnz board_loop      ; Repeat until si == 0

    ; Restore registers
    pop dx
    pop ax
    ret
Print_Board ENDP

PrintRow PROC color1:BYTE, color2:BYTE
    ; Save registers that will be modified
    push ax             ; Save ax (used by WriteColorBlock)
    push di             ; Save di (used for the loop)

    mov di, columns / 2 ; di controls pairs of blocks (half columns)

row_loop:
    INVOKE WriteColorBlock, color1  ; Print block with color1
    INVOKE WriteColorBlock, color2  ; Print block with color2
    dec di
    jnz row_loop                     ; Continue until di == 0

    ; Restore registers
    pop di
    pop ax
    ret
PrintRow ENDP

WriteColorBlock PROC backcolor:BYTE
    ; Save registers that are modified by this procedure
    push ax             ; Save ax (which contains al)
    push ebx            ; Save ebx (used to calculate the color combination)

    ; Set text color to white (foreground) with specified background color (backcolor)
    mov eax, white
    movzx ebx, backcolor
    shl ebx, 4          ; Multiply backcolor by 16 to shift it into the background position
    or eax, ebx         ; Combine foreground and background
    call SetTextColor

    ; Write two spaces to create a block effect
    mov al, ' '         ; Move a space character into al (to print it)
    call WriteChar      ; Output the space
    call WriteChar      ; Output another space

    ; Restore registers
    pop ebx
    pop ax
    ret
WriteColorBlock ENDP



END main
; //Testing Colors	(colors.asm)

; //Testing SetTextColor and GetTextColor.

INCLUDE Irvine32.inc

.data
str1 BYTE "Sample string, in color",0dh,0ah,0
str2 BYTE "Sample String 2 in color", 0dh, 0ah, 0

.code
main PROC
	mov	ax,yellow + (blue * 16)
	call	SetTextColor
	
	mov	edx,OFFSET str1
	call	WriteString

	mov eax, 1234566
	call WriteDec

	mov  edx, OFFSET str2
	call	WriteString

	call	GetTextColor
	call	DumpRegs

	exit
main ENDP

END main
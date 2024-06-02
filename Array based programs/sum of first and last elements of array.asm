;======================================================================
;===========	    x86 (MASM) 16 bit program		===============
;===========						===============
;===========    Finding sum of first and last numbers	===============
;===========     	in a static array		===============
;======================================================================


.model tiny
.data
	prompt1 db "Enter 8 numbers: $"
	space db " "
	array db 8 dup(?)
	prompt2 db 0ah, 0dh, "Sum of array extrema is: $"		; 0ah (10), 0dh (13) make prompt2 an array & they are used to print prompt2 on the next line
	sumMSB db ?
	sumLSB db ?
	
.code
main proc
mov ax, @data
mov ds, ax

lea si, array				; loading array
mov cx, 8				; setting counter
lea dx, prompt1				; printing first prompt
mov ah, 9
int 21h

inputLoop:
mov ah, 1				; taking input
int 21h
sub al, 48				; adjusting for ASCII

mov [si], al
inc si
mov dl, space
mov ah, 2
int 21h

loop inputLoop

lea si, array				; updating array position 
mov ah, 0
mov al, [si]				; storing first position value
add al, [si + 7]			; adding last position value
aaa

mov sumLSB, al
add sumLSB, 48				; adjusting for ASCII

mov sumMSB, ah
add sumMSB, 48

lea dx, prompt2				; printing second prompt
mov ah, 9
int 21h

mov dl, sumMSB
mov ah, 2
int 21h

mov dl, sumLSB
mov ah, 2
int 21h

mov ah, 4Ch				; terminating routine
int 21h


main endp
end main
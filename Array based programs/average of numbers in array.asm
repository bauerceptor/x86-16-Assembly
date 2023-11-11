;======================================================================
;===========	    x86 (MASM) 16 bit program		===============
;===========						===============
;===========	    Finding average of numbers		===============
;===========		in a static array		===============
;======================================================================

.model tiny
.data
	prompt1 db "Enter 8 numbers: $"
	space db " "
	array db 8 dup(?)
	prompt2 db 0ah, 0dh, "Average is: $"		; 0ah (10), 0dh (13) make prompt2 an array & they are used to print prompt2 on the next line
	quotient1 db ?
	remainder db ?
	sum db ?
	quotient2 db ? 
	radix db ".$"

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
mov cx, 7				; setting counter again
mov bl, [si]
mov sum, bl

sumLoop:
mov bl, [si + 1]			; adding numbers
add sum, bl
inc si

loop sumLoop

mov ah, 0				; flushing ah for division
mov al, sum
mov bh, 8
div bh					; first division

mov remainder, ah			; storing first remainder
mov quotient1, al			; storing first quotient
add quotient1, 48			; adjusting for ASCII

mov ah, 0
mov al, remainder
mov bl, 10
mul bl					; multiplying for negative place value
div bh					; second division

mov quotient2, al			; storing second quotient
add quotient2, 48			; adjusting for ASCII

lea dx, prompt2				; printing second prompt
mov ah, 9
int 21h

mov dl, quotient1
mov ah, 2
int 21h

mov dl, radix
mov ah, 2
int 21h

mov dl, quotient2
mov ah, 2
int 21h

mov ah, 4Ch			; terminating routine
int 21h


main endp
end main
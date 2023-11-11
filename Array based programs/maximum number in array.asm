;======================================================================
;===========	    x86 (MASM) 16 bit program		===============
;===========						===============
;===========	      Finding maximum number		===============
;===========		in a static array		===============
;======================================================================


.model tiny
.data
	prompt1 db "Enter 8 numbers: $"
	space db " "
	array db 8 dup(?)
	prompt2 db 0ah, 0dh, "Minimum number is: $"		; 0ah (10), 0dh (13) make prompt2 an array & they are used to print prompt2 on the next line

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
mov ah, 1				; taking input of numbers
int 21h

mov [si], al
inc si
mov dl, space
mov ah, 2
int 21h

loop inputLoop

lea si, array				; updating array position
mov cx, 7				; setting counter again
mov bh, [si]				; moving first item from array

checkLoop:
cmp [si + 1], bh			; comparing numbers
ja newMin

checkLoopContinue:
inc si
loop checkLoop

lea dx, prompt2				; printing second prompt
mov ah, 9
int 21h

mov dl, bh				; printing maximum number
mov ah, 2
int 21h

mov ah, 4Ch				; terminating routine
int 21h

newMin:					; updating maximum number
mov bh, [si + 1]
jmp checkLoopContinue

main endp
end main
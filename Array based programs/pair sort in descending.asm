;======================================================================
;===========	    x86 (MASM) 16 bit program		===============
;===========						===============
;===========     Sorting numbers in descending order	===============
;===========		in a static array		===============
;======================================================================


.model tiny
.data
	prompt1 db "Enter 8 numbers in random: $"
	space db " "
	array db 8 dup(?)
	prompt2 db 0ah, 0dh, "Numbers in ascending order: $"

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

mov [si], al
inc si
mov dl, space
mov ah, 2
int 21h

loop inputLoop



;----------------      sorting in ascending     ------------




mov ax, @data
mov ds, ax

mov ch, 7				; setting counter for outer loop
outerLoop:
lea si, array				; updating array position


mov cl, 7               		; setting counter for inner loop
innerLoop:
mov bl, [si]
cmp bl, [si+1]
;cmp [si+1], bl
jb update
inc si
dec cl

cmp cl, 1
jae innerLoop

dec ch
cmp ch, 1
jae outerLoop



;-------------      printing result     ---------------


toPrint:

lea si, array
lea dx, prompt2
mov ah, 9
int 21h

mov cx, 8
printLoop:
mov dl, [si]
mov ah, 2
int 21h
inc si

mov dl, space
mov ah, 2
int 21h

loop printLoop

mov ah, 4Ch
int 21h


















;---------------------      performing swap       ---------------------------

update:
mov al, 0
mov al, bl
mov bl, [si+1]
mov [si], bl
mov bl, al
mov [si+1], bl

inc si

dec cl
cmp cl, 1
jae innerLoop

dec ch
cmp ch, 1
jae outerLoop
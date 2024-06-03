;; a simple encryption/decryption program in 16bit assembly that uses arrays data structures


.model tiny
.stack 100h

.data 

    input_text db 255 DUP ('$') 
    gen_text db 255 DUP ('$')   
    shift db 0                
    activity db 0             

    welcome db 10, 13, 10, 13,"------------------Welcome to the Caesar Cipher program!-------------------$"
    activity_prompt db 10, 13, 10, 13, "Enter 'e' to Encrypt or 'd' to decrypt: $"
    input_prompt db 10, 13, "Enter a text (press 9 to terminate): $"
    shift_prompt db 10, 13, "Enter the shift number: $"
    gen_text_message db 10, 13, "The generated text is: $"
    repeat_prompt db 10, 13, "Do you wish to encrypt/decrypt any text again? (y / n) $"

.code 

main proc
    
    mov ax, @data
    mov ds, ax

    main_loop:
    
    lea dx, welcome 
    mov ah, 9
    int 21h
     
    lea dx, activity_prompt
    mov ah, 9                               ; encrypt or decrypt
    int 21h

    mov ah, 1
    int 21h
    mov activity, al

    lea dx, input_prompt                    ; input message
    mov ah, 9
    int 21h
                      
                      
    lea si, input_text
    mov cx, 255
    inputLoop:
    
    mov ah, 1
    int 21h
    
    cmp al, '9'
    je end_input
    
    mov [si], al
    inc si
    loop inputLoop

    
    continue:

    lea dx, shift_prompt                    ; getting shift
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48                              ; ASCII adjustment
    mov shift, al

    lea si, input_text
    lea di, gen_text
    mov al, activity
    mov bl, shift
    
    call caeser_cipher

    lea dx, gen_text_message                ; outputting answer text
    mov ah, 9
    int 21h
    
    lea dx, gen_text
    mov ah, 9
    int 21h

    lea dx, repeat_prompt
    mov ah, 9
    int 21h

    mov ah, 1                               ; repeat loop program
    int 21H
    cmp al, 'y'
    JE main_loop                            ; end program

    mov ah, 4Ch
    int 21h
    
main endp


caeser_cipher PROC
    ; Input: si = input_text, di = gen_text, al = activity, ah = action, bl = shift
    ; Output: di = gen_text

    mov cx, 0          
    mov ah, al         

    next_character:
        mov al, [si]                        ; loading character from input_text
        cmp al, '$'                         ; checking if it is the last character or not
        JE end_caeser_cipher

        cmp al, 'a'
        JL check_uppercase

        cmp al, 'z'
        JG check_uppercase

        ; lowercase characters check
        process_lowercase:
            cmp al, 'a'
            JL check_uppercase

            cmp al, 'z'
            JG check_uppercase

            ; encryption
            cmp ah, 'e'
            JE process_lowercase_encrypt
            ; decryption
            cmp ah, 'd'
            JE process_lowercase_decrypt

            JMP store_character

        process_lowercase_encrypt:
            ; encryption
            cmp al, 'z'
            JE process_wraparound_lowercase_encrypt

            add al, bl                      ; adding the shift
            cmp al, 'z'
            JBE store_character

            JMP process_continue

        process_wraparound_lowercase_encrypt:
            sub al, 26                      ; wraparound to 'a'

            JMP store_character

        process_lowercase_decrypt:
            ; decryption
            cmp al, 'a'
            JE process_wraparound_lowercase_decrypt

            sub al, bl                      ; subtracting the shift
            cmp al, 'a'
            JAE store_character

            JMP process_continue

        process_wraparound_lowercase_decrypt:
            add al, 26                      ; wraparound to 'z'

        process_continue:
            JMP store_character

        check_uppercase:
            cmp al, 'A'
            JL process_non_alphabetic

            cmp al, 'Z'
            JG process_non_alphabetic

            ; uppercase characters check
            process_uppercase:
                ; encryption
                cmp ah, 'e'
                JE process_uppercase_encrypt
                ; decryption
                cmp ah, 'd'
                JE process_uppercase_decrypt

                JMP store_character

            process_uppercase_encrypt:
                ; encryption
                cmp al, 'Z'
                JE process_wraparound_uppercase_encrypt

                add al, bl                    ; adding the shift
                cmp al, 'Z'
                JBE store_character

                JMP process_continue_uppercase

            process_wraparound_uppercase_encrypt:
                sub al, 26                    ; wraparound to 'A'

                JMP store_character

            process_uppercase_decrypt:
                ; decryption
                cmp al, 'A'
                JE process_wraparound_uppercase_decrypt

                sub al, bl                    ; subtracting the shift
                cmp al, 'A'
                JAE store_character

                JMP process_continue_uppercase

            process_wraparound_uppercase_decrypt:
                add al, 26                    ; wraparound to 'Z'

            process_continue_uppercase:
                JMP store_character

        process_non_alphabetic:
            ; non-alphabet characters;; leave it unchanged
            JMP store_character

        store_character:
            mov [di], al                    
            inc si        
            inc di        
            inc cx        
            cmp cx, 255                     ; checking if reached max buffer size
            JGE end_caeser_cipher

        JMP next_character

    end_caeser_cipher:
        

        ret
caeser_cipher ENDP

              
              end_input:
              JMP continue


end main

.intel_syntax noprefix
.global itoa_digit
.global itoa

itoa:
    xor rcx, rcx       # Initialize digit count tracker (counter = 0)
    mov rax, rdi       # Move input integer into rax

    # Special case for input == 0
    cmp rax, 0
    jne extract_loop
    
    # Handle zero explicitly
    mov rdi, 0
    call itoa_digit
    mov [rsi], al
    mov rax, 1
    ret

extract_loop:
    test rax, rax
    je write_setup

    xor rdx, rdx
    mov r8, 10
    div r8             # rax = quotient, rdx = remainder (digit)

    push rdx           # Push digit remainder onto stack
    inc rcx            # Increment digit counter
    jmp extract_loop

write_setup:
    mov r11, rcx       # Save total digit count to return later
    xor r9, r9         # Initialize buffer index offset (i = 0)

write_loop:
    cmp r9, r11
    jge done

    pop rdx            # Pop raw digit value from stack
    mov rdi, rdx
    call itoa_digit    # Convert integer digit to ASCII character in rax

    mov [rsi + r9], al # Store ASCII character in destination buffer
    inc r9             # Increment buffer index
    jmp write_loop

done:
    mov rax, r11       # Return total character count
    ret

itoa_digit:
    # Convert single digit integer (0-9) to ASCII character ('0'-'9')
    mov rax, rdi
    add rax, 0x30
    ret

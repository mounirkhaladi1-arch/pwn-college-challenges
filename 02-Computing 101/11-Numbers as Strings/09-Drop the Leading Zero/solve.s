.intel_syntax noprefix
.global itoa_digit
.global itoa

itoa:
    # Check if input is less than 10
    cmp rdi, 10
    jl single_digit

    # --- TWO DIGIT LOGIC (10 - 99) ---
    mov rax, rdi
    xor rdx, rdx
    mov rcx, 10
    div rcx              # rax = tens, rdx = ones

    # Convert & write tens to [rsi]
    push rdx
    mov rdi, rax
    call itoa_digit
    mov [rsi], al
    pop rdx

    # Convert & write ones to [rsi + 1]
    mov rdi, rdx
    call itoa_digit
    mov [rsi + 1], al

    mov rax, 2           # Return count = 2
    ret

single_digit:
    # --- SINGLE DIGIT LOGIC (0 - 9) ---
    call itoa_digit      # Converts rdi to ASCII character in rax
    mov [rsi], al        # Write single character to buffer
    mov rax, 1           # Return count = 1
    ret

itoa_digit:
    # Copy raw integer value directly from rdi into rax
    mov rax, rdi
    
    # Add ASCII base offset (0x30 / '0') to convert integer to character
    add rax, 0x30
    ret

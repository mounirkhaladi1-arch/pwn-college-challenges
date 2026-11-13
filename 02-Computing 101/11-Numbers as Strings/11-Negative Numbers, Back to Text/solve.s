.intel_syntax noprefix
.global itoa_digit
.global itoa

itoa:
    xor r10, r10
    xor r9, r9
 
    cmp rdi, 0
    jge non_neg
    mov byte ptr [rsi], 0x2d
    neg rdi
    inc r9
    inc r10

non_neg:
    # Check if input is less than 10
    cmp rdi, 10
    jl single_digit

    # --- MULTI-DIGIT / DIVISION LOGIC ---
    mov rax, rdi

loop:
    xor rdx, rdx
    mov rcx, 10
    div rcx              # rax = quotient, rdx = remainder (ones)

    mov rdi, rdx
    push rax
    call itoa_digit
    mov rdx, rax
    pop rax 
    push rdx

    inc r10     
    cmp rax, 0
    jne loop

write_loop:
    pop rdx
    mov [rsi+r9], dl
    inc r9
    cmp r10, r9
    jne write_loop
    mov rax, r10
    ret

single_digit:
    # --- SINGLE DIGIT LOGIC (0 - 9) ---
    call itoa_digit      # Converts rdi to ASCII character in rax
    mov [rsi+r9], al     # Write single character to buffer at offset r9
    mov rax, r9
    inc rax              # Return total count = r9 + 1
    ret

itoa_digit:
    # Copy raw integer value directly from rdi into rax
    mov rax, rdi
    
    # Add ASCII base offset (0x30 / '0') to convert integer to character
    add rax, 0x30
    ret

.intel_syntax noprefix
.global itoa_digit

itoa_digit:
    # Copy raw integer value directly from rdi into rax
    mov rax, rdi
    
    # Add ASCII base offset (0x30 / '0') to convert integer to character
    add rax, 0x30
    ret

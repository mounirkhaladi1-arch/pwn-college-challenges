.intel_syntax noprefix
.global atoi_digit

atoi_digit:
    # Load single ASCII character byte into rax with zero extension
    movzx rax, byte ptr [rdi]
    
    # Subtract ASCII offset (0x30) to convert character to integer value
    sub rax, 0x30
    
    ret

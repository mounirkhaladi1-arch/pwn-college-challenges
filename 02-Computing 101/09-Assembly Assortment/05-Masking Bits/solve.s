.intel_syntax noprefix  
.global LOBYTE

LOBYTE:
    # 1. Mask the input value to keep only the lowest 8 bits (0xff)
    and rdi, 0xff
    
    # 2. Move the masked result into rax as the return value
    mov rax, rdi
    
    # 3. Return from the function
    ret

.intel_syntax noprefix  
.global chr_lower

chr_lower:
    # 1. Set the 6th bit (0x20) to convert uppercase to lowercase
    or rdi, 0x20
    
    # 2. Move the converted character into rax as the return value
    mov rax, rdi
    
    # 3. Return from the function
    ret

.intel_syntax noprefix  
.global solve

solve:
    # 1. Move the input value from rdi into rax for manipulation and return
    mov rax, rdi
    
    # 2. Shift right by 8 bits to move byte 1 into the lowest byte position
    shr rax, 8
    
    # 3. Mask with 0xff to clear any remaining upper bits
    and rax, 0xff
    
    # 4. Return the extracted byte
    ret

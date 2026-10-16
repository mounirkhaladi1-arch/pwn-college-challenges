.intel_syntax noprefix  
.global solve

solve:
    # 1. Move the input value from rdi into rax for manipulation and return
    mov rax, rdi
    
    # 2. Shift the value left by 4 bits (equivalent to multiplying by 16)
    shl rax, 4
    
    # 3. Return the shifted result
    ret

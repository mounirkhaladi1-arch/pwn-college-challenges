.intel_syntax noprefix  
.global solve

solve:
    # 1. Move the incoming argument (secret in rdi) into the return register (rax)
    mov rax, rdi
    
    # 2. Return control back to the calling harness
    ret

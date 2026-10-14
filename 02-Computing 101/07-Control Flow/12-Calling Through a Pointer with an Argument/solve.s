.intel_syntax noprefix  
.global solve

solve:
    # 1. Save the callback function pointer (currently in rdi) into rax before rdi is overwritten
    mov rax, rdi
    
    # 2. Load the required argument (1337) into rdi as expected by the callback ABI
    mov rdi, 1337
    
    # 3. Call the function pointer via the scratch register
    call rax
    
    # 4. Return cleanly back to the harness runner
    ret

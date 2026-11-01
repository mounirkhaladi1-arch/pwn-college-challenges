.intel_syntax noprefix  
.global solve

solve:
    # 1. Call the load_secret function passed via the function pointer in rdi
    call rdi
    
    # 2. Retrieve the 8-byte stale value left behind on the stack at [rsp - 0x10] into rax
    mov rax, qword ptr [rsp - 0x10]
    
    # 3. Return the stale secret value
    ret

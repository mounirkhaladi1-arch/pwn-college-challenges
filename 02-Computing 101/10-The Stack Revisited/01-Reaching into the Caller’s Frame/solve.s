.intel_syntax noprefix  
.global solve

solve:
    # 1. Set file descriptor to 1 (stdout)
    mov rdi, 1
    
    # 2. Load the effective address of the flag in the caller's stack frame into rsi
    lea rsi, [rsp + 0x40]
    
    # 3. Set the write length to 128 bytes
    mov rdx, 128
    
    # 4. Set syscall number to 1 (sys_write)
    mov rax, 1
    
    # 5. Invoke the system call to print the flag
    syscall

    ret

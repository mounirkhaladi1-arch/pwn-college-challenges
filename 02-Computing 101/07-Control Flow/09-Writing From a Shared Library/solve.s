.intel_syntax noprefix  
.global solve

solve:
    # 1. Remap incoming function arguments to sys_write ABI registers
    # Incoming: rdi = buffer pointer, rsi = length
    # Target sys_write: rdi = fd (1), rsi = buffer pointer, rdx = length
    
    mov rdx, rsi        # Move length from rsi into rdx (write size)
    mov rsi, rdi        # Move buffer pointer from rdi into rsi (write buffer)
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rax, 1          # sys_write syscall number
    syscall

    # 2. Clean exit back to the harness runner
    xor rdi, rdi        # Set exit/return code to 0
    mov rax, 60         # sys_exit syscall number
    syscall

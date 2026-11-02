.intel_syntax noprefix
.global _start

_start:
    # 1. Write the environment variable string (pointed to by envp[0] at [rsp + 24]) to stdout
    mov rdi, 1             # File descriptor: stdout (1)
    mov rsi, [rsp + 24]    # Pointer to envp[0] ("FLAG=...")
    mov rdx, 140           # Length of bytes to write (padded buffer size)
    mov rax, 1             # System call: sys_write
    syscall

    # 2. Clean process exit
    xor rdi, rdi           # Exit code: 0 (Success)
    mov rax, 60            # System call: sys_exit
    syscall

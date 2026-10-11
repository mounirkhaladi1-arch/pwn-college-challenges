.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 0          # Set file descriptor to 0 (stdin)
    mov rsi, rsp        # Point buffer to the stack pointer (rsp)
    mov rdx, 128        # Read up to 128 bytes
    mov rax, 0          # Read syscall number
    syscall
    
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    # mov rsi, rsp      # Reuses same value from previous call
    # mov rdx, 128      # Reuses same value from previous call
    mov rax, 1          # Write syscall number
    syscall
    
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # Exit syscall number
    syscall

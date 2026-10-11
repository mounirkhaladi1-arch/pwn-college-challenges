.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rsi, [rsp+16]   # Address of the first argument string stored at rsp+16
    mov rdx, 64         # Set write buffer length to 64 bytes (to capture the full flag)
    mov rax, 1          # Write syscall number
    syscall
    
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # Exit syscall number
    syscall

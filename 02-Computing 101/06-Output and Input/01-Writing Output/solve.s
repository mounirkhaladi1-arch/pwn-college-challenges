.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rsi, [rsp+16]   # Address of the first argument stored at rsp+16
    mov rdx, 1          # Number of characters to write
    mov rax, 1          # Write syscall number
    syscall
    # Missing exit syscall causes the crash here! I thought they would handle the exit themselves, and I was right lol

.intel_syntax noprefix  
.global _start

_start:
    # 1. Load pointer to the filename using RIP-relative addressing
    lea rdi, [rip+path] # Calculate dynamic position-independent address of "path"
    mov rsi, 0          # Set access mode to 0 (O_RDONLY / Read-Only)
    mov rax, 2          # sys_open syscall number
    syscall             # Returns custom file descriptor in rax

    # 2. Read from the opened file descriptor into memory
    mov rdi, rax        # Move the new file descriptor into rdi
    mov rsi, rsp        # Point buffer destination to stack memory (rsp)
    mov rdx, 128        # Request up to 128 bytes max capacity
    mov rax, 0          # sys_read syscall number
    syscall             # Returns actual bytes read in rax

    # 3. Write the captured data to stdout
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rdx, rax        # Transfer exact byte count from rax to write length (rdx)
    mov rax, 1          # sys_write syscall number
    syscall

    # 4. Clean exit with status 42
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # sys_exit syscall number
    syscall

path:
    .asciz "/flag"      # Null-terminated string stored in the binary data section

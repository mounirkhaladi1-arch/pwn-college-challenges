.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 0          # Set file descriptor to 0 (stdin)
    mov rsi, rsp        # Point buffer to stack memory
    mov rdx, 128        # Request up to 128 bytes max buffer capacity
    mov rax, 0          # Read syscall number
    syscall             # Returns actual bytes read in rax

    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rdx, rax        # Transfer exact byte count from rax to write length (rdx)
    # mov rsi, rsp      # Buffer pointer remains at rsp
    mov rax, 1          # Write syscall number
    syscall
    
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # Exit syscall number
    syscall

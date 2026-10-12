.intel_syntax noprefix  
.global _start

_start:
    # 1. Construct the filename string "/flag" byte by byte onto the stack
    mov byte ptr [rsp], '/'
    mov byte ptr [rsp+1], 'f'
    mov byte ptr [rsp+2], 'l'
    mov byte ptr [rsp+3], 'a'
    mov byte ptr [rsp+4], 'g'
    mov byte ptr [rsp+5], 0       # Null terminator

    # 2. Open the hardcoded filename
    mov rdi, rsp        # Point rdi to the stack address containing "/flag"
    mov rsi, 0          # Set access mode to 0 (O_RDONLY / Read-Only)
    mov rax, 2          # sys_open syscall number
    syscall             # Returns custom file descriptor in rax

    # 3. Read from the opened file descriptor into memory
    mov rdi, rax        # Move the new file descriptor into rdi
    mov rsi, rsp        # Point buffer destination to stack memory (overwriting the string is fine)
    mov rdx, 128        # Request up to 128 bytes max capacity
    mov rax, 0          # sys_read syscall number
    syscall             # Returns actual bytes read in rax

    # 4. Write the captured data to stdout
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rdx, rax        # Transfer exact byte count from rax to write length (rdx)
    mov rax, 1          # sys_write syscall number
    syscall

    # 5. Clean exit with status 42
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # sys_exit syscall number
    syscall

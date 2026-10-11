.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 1          # we set the FD (File Descriptors) to 1 stdin 
    mov rsi, [rsp+16]   # where to start writing ? ( the first argument its adress is on rsp+16 so we mov [rsp+16] to take the real value (in hex for sure ) )
    mov rdx, 1          # how much characters to write ? (1 for now ) 
    mov rax, 1          # write syscall code (not exit!)
    syscall
    # Missing exit syscall causes the crash here! I  thought they will handle the exit them self and i was true lol

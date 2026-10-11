.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 1337
    int3
    mov rax, 60         # exit syscall code
    syscall

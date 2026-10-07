.intel_syntax noprefix
.global _start

_start:
    pop rdi     # pop argc directly from top of stack into rdi
    mov rax, 60 # exit syscall code
    syscall     # make the syscall

.intel_syntax noprefix
.global _start

_start:
    mov rdi, [rsp + 128] # get the value from the stack at an offset of 128 bytes
    mov rax, 60          # exit syscall code
    syscall              # make the syscall

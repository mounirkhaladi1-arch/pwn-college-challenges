.intel_syntax noprefix
.global _start

_start:
    mov rdi, [rsp+16] # get pointer from stack offset 16
    mov rdi, [rdi]    # dereference pointer to load final value
    mov rax, 60       # exit syscall code
    syscall           # make the syscall

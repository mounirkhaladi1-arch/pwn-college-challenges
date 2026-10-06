.intel_syntax noprefix
.global _start

_start:
    mov rdi, [rsp] # get argument count from the stack
    mov rax, 60    # exit syscall
    syscall        # make the syscall

.intel_syntax noprefix
.global _start

_start:
mov rdi, [rax] # dereferences the pointer inside rax to pull the secret exit status
mov rax, 60    # exit system call code (sys_exit)
syscall

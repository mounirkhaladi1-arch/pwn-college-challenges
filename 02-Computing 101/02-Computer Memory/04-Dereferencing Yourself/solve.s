.intel_syntax noprefix
.global _start

_start:
mov rdi, [rdi] # dereferences rdi to overwrite its pointer value with the actual secret data
mov rax, 60    # exit system call code (sys_exit)
syscall

.intel_syntax noprefix
.global _start

_start:
mov rdi, [rax] # dereferences rax to read secret_location_1 into rdi
mov rdi, [rdi] # dereferences rdi to load the actual secret_value into rdi
mov rax, 60    # exit system call code (sys_exit)
syscall

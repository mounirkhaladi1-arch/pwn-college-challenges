.intel_syntax noprefix
.global _start

_start:
mov rdi, [123400] # loading the dynamic secret value from the level 2 memory address
mov rax, 60       # exit system call code (sys_exit)
syscall

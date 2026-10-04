.intel_syntax noprefix
.global _start

_start:
mov rdi, [133700] # dereferences address 133700 to pull the hidden numerical constant
mov rax, 60       # loads the standard sys_exit identifier
syscall

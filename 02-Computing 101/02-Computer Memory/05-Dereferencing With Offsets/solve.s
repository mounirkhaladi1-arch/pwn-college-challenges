.intel_syntax noprefix
.global _start

_start:
mov rdi, [rdi+8] # dereferences rdi with an 8-byte offset to read the hidden value
mov rax, 60      # exit system call code (sys_exit)
syscall

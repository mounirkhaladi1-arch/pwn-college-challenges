.intel_syntax noprefix
.global _start

_start:
mov rdi, [567800] # loads the secret pointer address stored at absolute location 567800
mov rdi, [rdi]    # dereferences the retrieved address to load the actual secret exit code value
mov rax, 60       # exit system call code (sys_exit)
syscall


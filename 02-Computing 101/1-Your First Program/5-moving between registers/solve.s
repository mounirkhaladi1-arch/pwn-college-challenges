.intel_syntax noprefix  
.global _start

_start:
mov rdi, rsi # setting to secret exit code rsi (echo $?= $rsi) 
mov rax, 60 # exit syscall code 
syscall

mov rdi, 42 # setting exit code to 42 (echo $?= 42)
mov rax, 60 # exit syscall code
syscall

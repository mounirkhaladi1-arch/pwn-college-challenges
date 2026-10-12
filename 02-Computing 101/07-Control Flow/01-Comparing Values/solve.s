.intel_syntax noprefix  
.global _start

_start:
    # 1. Compare argc (stored at [rsp]) against the immediate value 42
    cmp word ptr [rsp], 42
    
    # 2. Set dil to 1 if equal (zero flag set), 0 otherwise
    setz dil
    
    # 3. Exit with the comparison result as the exit status code
    mov rax, 60         # sys_exit syscall number
    syscall

.intel_syntax noprefix  
.global _start

_start:
    # 1. Load the pointer to argv[1] into rax
    mov rax, [rsp+16]
    
    # 2. Compare the first byte of the string against the character 'p'
    cmp byte ptr [rax], 'p'
    
    # 3. Set dil to 1 if equal (zero flag set), 0 otherwise
    setz dil
    
    # 4. Exit with the comparison result as the exit code
    mov rax, 60         # sys_exit syscall number
    syscall

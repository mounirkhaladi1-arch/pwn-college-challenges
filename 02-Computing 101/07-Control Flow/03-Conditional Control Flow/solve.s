.intel_syntax noprefix  
.global _start

_start:
    # 1. Load the pointer to argv[1] and compare its first byte against 'p'
    mov rax, [rsp+16]
    cmp byte ptr [rax], 'p'
    
    # 2. Branch to the 'fail' label if the character is not equal to 'p'
    jne fail

    # 3. Fall-through Success Path (exit code 0)
    xor rdi, rdi        # Clear rdi (rdi = 0 for successful execution)
    mov rax, 60         # sys_exit syscall number
    syscall

fail:
    # 4. Alternative Failure Path (exit code 1)
    mov rdi, 1          # Set exit status code to 1 (failure)
    mov rax, 60         # sys_exit syscall number
    syscall

.intel_syntax noprefix  
.global _start

_start:
    # 1. Load pointer to argv[1]
    mov rax, [rsp+16]
    
    # 2. Check first character ('p')
    cmp byte ptr [rax], 'p'
    jne fail

    # 3. Check second character ('w')
    cmp byte ptr [rax+1], 'w'
    jne fail

    # 4. Check third character ('n')
    cmp byte ptr [rax+2], 'n'
    jne fail

    # 5. Success Path: All characters matched (exit code 0)
    xor rdi, rdi        # Clear rdi (rdi = 0)
    mov rax, 60         # sys_exit syscall number
    syscall

fail:
    # 6. Failure Path: Mismatch detected at any point (exit code 1)
    mov rdi, 1          # Set exit status code to 1
    mov rax, 60         # sys_exit syscall number
    syscall

.intel_syntax noprefix  
.global solve

solve:
    # 1. Save the caller's original callee-saved registers onto the stack
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15

    # 2. Perform work: load the required value (0x1337) into all callee-saved registers
    mov r15, 0x1337
    mov r14, 0x1337
    mov r13, 0x1337
    mov r12, 0x1337
    mov rbx, 0x1337
    mov rbp, 0x1337

    # 3. Call the check function (passed in rdi)
    call rdi

    # 4. Restore the caller's original register values in strict reverse order (LIFO)
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx

    # 5. Return cleanly back to the harness
    ret

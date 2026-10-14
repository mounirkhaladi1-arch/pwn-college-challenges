.intel_syntax noprefix  
.global solve

solve:
    # 1. Save live caller-saved registers (plus arguments needed later) onto the stack
    push rsi
    push rax
    push rcx
    push rdi
    push rdx 
    push r8
    push r9 
    push r10
    push r11

    # 2. Call the clobber function (rdi), which deliberately overwrites caller-saved registers
    call rdi

    # 3. Restore registers from the stack in strict reverse order (LIFO)
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdx
    pop rdi
    pop rcx
    pop rax 
    pop rsi

    # 4. Call the flag-printing function (now safely preserved in rsi)
    call rsi

    # 5. Return cleanly back to the harness
    ret

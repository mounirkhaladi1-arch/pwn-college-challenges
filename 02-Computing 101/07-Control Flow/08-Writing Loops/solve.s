.intel_syntax noprefix  
.global _start

_start:
    # 1. Initialize character counter (rsi = 0)
    xor rsi, rsi

    # 2. Load argv[1] pointer into rdx
    mov rdx, [rsp+16]

loop:
    # 3. Check if current byte is the null terminator (0)
    cmp byte ptr [rdx], 0
    je exit             # If null byte reached, break out of loop

    # 4. Advance pointer and increment counter
    inc rdx             # Move to the next character address
    inc rsi             # Increment length counter
    jmp loop            # Repeat loop

exit:
    # 5. Move total length into rdi and exit
    mov rdi, rsi        # rdi = calculated string length
    mov rax, 60         # sys_exit syscall number
    syscall

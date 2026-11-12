.intel_syntax noprefix
.global atoi_digit
.global atoi

atoi:
    mov r8, rdi        # Save base string pointer
    xor rcx, rcx       # Initialize index counter (i = 0)
    xor r9, r9         # Initialize integer accumulator
    mov r10, 1         # Default sign multiplier is +1 (positive)

check_neg:
    # Check for leading minus sign ('-' = 0x2d)
    cmp byte ptr [rdi], 0x2d
    jne loop
    mov r10, -1        # Set sign multiplier to -1 if negative
    lea r8, [r8 + 1]   # Advance base pointer past the minus sign

loop:
    # 1. Validate if current character is a valid decimal digit (0-9)
    movzx r11, byte ptr [r8 + rcx]
    sub r11, 0x30
    cmp r11, 9
    ja done            # If not 0-9 (junk character or underflow), exit loop

    # 2. Check for null terminator (end of string)
    cmp byte ptr [r8 + rcx], 0
    je done

    # 3. Process valid digit character via atoi_digit
    lea rdi, [r8 + rcx]
    call atoi_digit    # Returns digit value in rax

    # Accumulate: total = (total * 10) + digit
    imul r9, 10
    add r9, rax

    inc rcx            # Move to next character index
    jmp loop

done:
    mov rax, r9        # Move accumulated value into rax
    imul rax, r10      # Apply sign multiplier (+1 or -1)
    ret

atoi_digit:
    # Load single ASCII byte and strip 0x30 offset
    movzx rax, byte ptr [rdi]
    sub rax, 0x30
    ret

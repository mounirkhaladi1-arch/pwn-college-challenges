.intel_syntax noprefix
.global atoi_digit
.global atoi

atoi:
    # Save the base string pointer in r8
    mov r8, rdi
    xor rcx, rcx       # rcx acts as our string index counter (i = 0)
    xor r9, r9         # r9 acts as our running integer accumulator

loop:
    # Check for null terminator (end of string)
    cmp byte ptr [r8 + rcx], 0
    je done

    # Load address of current character into rdi for atoi_digit
    lea rdi, [r8 + rcx]
    call atoi_digit    # Returns single digit value in rax

    # Accumulate: total = (total * 10) + digit
    imul r9, 10
    add r9, rax

    inc rcx            # Move to next character index
    jmp loop

done:
    mov rax, r9        # Move final parsed integer into rax for return
    ret

atoi_digit:
    # Load single ASCII byte, strip 0x30 offset to get integer value
    movzx rax, byte ptr [rdi]
    sub rax, 0x30
    ret

.intel_syntax noprefix
.global itoa_digit
.global itoa

itoa:
    # 1. Clear rdx and load dividend into rax for 64-bit unsigned division (rdx:rax / 10)
    xor rdx, rdx
    mov rax, rdi
    mov rcx, 10
    div rcx            # rax = quotient (tens), rdx = remainder (units)

    # 2. Convert quotient (tens digit) to ASCII
    mov rdi, rax
    call itoa_digit
    mov r10, rax       # Save tens ASCII character in r10

    # 3. Convert remainder (units digit) to ASCII
    mov rdi, rdx
    call itoa_digit    # Returns units ASCII character in rax

    # 4. Write ASCII characters into the destination buffer (rsi)
    mov [rsi], r10b    # Store tens digit at buf[0]
    mov [rsi + 1], al  # Store units digit at buf[1]

    # 5. Return total character count (2)
    mov rax, 2
    ret

itoa_digit:
    # Convert single digit integer (0-9) to ASCII character ('0'-'9')
    mov rax, rdi
    add rax, 0x30
    ret

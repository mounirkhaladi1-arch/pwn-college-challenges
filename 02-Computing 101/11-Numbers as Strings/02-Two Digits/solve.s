.intel_syntax noprefix
.global atoi_digit
.global atoi

atoi:
    # Save the base string pointer in r8
    mov r8, rdi

    # 1. Process the first digit (tens place)
    call atoi_digit
    imul rax, 10       # Multiply the tens digit by 10
    mov r9, rax        # Temporarily store the scaled result in r9

    # 2. Process the second digit (units place)
    lea rdi, [r8 + 1]  # Load the address of the second character into rdi
    call atoi_digit    # Convert the second character to integer

    # 3. Combine tens and units: (tens * 10) + units
    add rax, r9
    ret

atoi_digit:
    # Load single ASCII character byte and subtract 0x30 to get integer value
    movzx rax, byte ptr [rdi]
    sub rax, 0x30
    ret

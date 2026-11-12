.global atoi_digit
.global atoi
.global _start

_start:
    # 1. Retrieve argv[1] pointer safely from the stack
    mov r8, [rsp + 16]    # r8 holds the base string pointer
    xor rcx, rcx          # Initialize index counter (i = 0)
    xor r9, r9            # Initialize integer accumulator
    mov r10, 1            # Default sign multiplier (+1)
    xor r11, r11          # Intermediate register for bounds check

check_neg:
    # 2. Check if the first character is a minus sign ('-' = 0x2d)
    cmp byte ptr [r8], 0x2d
    jne loop
    mov r10, -1           # Set negative sign multiplier
    lea r8, [r8 + 1]      # Advance base pointer past the sign

loop:
    # 3. Unsigned boundary check & digit conversion loop
    movzx r11, byte ptr [r8 + rcx]
    sub r11, 0x30         # Convert ASCII to integer digit
    cmp r11, 9
    ja done               # Exit loop if not a valid 0-9 digit

    cmp byte ptr [r8 + rcx], 0
    je done               # Exit loop on null terminator

    # Process valid digit character via atoi_digit logic abstraction
    lea rdi, [r8 + rcx]
    call atoi_digit       # Returns digit value in rax

    # Accumulate: total = (total * 10) + digit
    imul r9, 10
    add r9, rax

    inc rcx
    jmp loop

done:
    # 4. Final scaling by sign multiplier and system exit
    mov rax, r9
    imul rax, r10         # Apply sign multiplier (+1 or -1)
    mov rdi, rax          # Move final result into rdi for exit status
    mov rax, 60           # sys_exit syscall number
    syscall

atoi_digit:
    movzx rax, byte ptr [rdi]
    sub rax, 0x30
    ret

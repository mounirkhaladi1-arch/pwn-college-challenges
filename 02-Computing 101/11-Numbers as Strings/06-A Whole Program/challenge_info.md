# Challenge Documentation: a-whole-program

## 🛠️ Challenge Overview & Target Track
* Module: numbers-as-strings (computing-101)
* Challenge Name: a-whole-program
* Objective: Transition from shared library functions (.so) to a raw standalone ELF executable. Receive a command-line argument string from argv[1], parse it into a signed integer using custom atoi logic, and exit the process using that integer as the exit status code (exit(status)) via syscall 60.

---

## ⚙️ Low-Level Mechanics & Standalone Entry Points

1. **Standalone ABI Stack Layout (_start):** In a raw ELF executable without standard libc initialization, the kernel initializes the stack upon execution:
   * [rsp] = argc (argument count)
   * [rsp + 8] = argv[0] (pointer to program name string)
   * [rsp + 16] = argv[1] (pointer to target number string)
2. **Sign Detection (0x2d):** Before entering the parsing loop, inspect the first byte of argv[1]. If it matches '-' (0x2d), record a negative multiplier (r10 = -1) and advance the pointer (lea r8, [r8 + 1]) so the digit loop skips the sign character.
3. Unsigned Boundary Loop & Error Handling: Iterates character-by-character through memory:
   * Uses an unsigned boundary check (ja done) to immediately stop processing upon hitting any non-digit character (including spaces, letters, or null bytes 0x00), allowing messy or un-terminated inputs to be handled cleanly.
   * Normalizes ASCII digits to literal numeric values (sub r11, 0x30).
   * Scales the running total by a base-10 shift (imul r9, 10) and appends the new digit (add r9, rax).
4. System Exit Handler: Multiplies the accumulated absolute value by the sign register (imul rax, r10) and passes the final numeric output directly to rdi as the program's return status, executing a direct Linux system call (syscall 60).

---

## 💻 Source Implementation (solve.s)
```assembly
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

# Challenge Documentation: `string-to-integer`

## 🛠️ Challenge Overview & Target Track
- **Module:** `numbers-as-strings` (`computing-101`)
- **Challenge Name:** `string-to-integer`
- **Objective:** Implement a fully generalized `atoi` routine in x86-64 assembly that iterates through an arbitrary null-terminated ASCII string, converts each digit character dynamically, accumulates the total value, and handles numbers of any length.

---

## 🔬 Low-Level Mechanics & Dynamic Loop Iteration

1. **Static Base Pointer (`r8`):** Preserving the original string address in a scratch register (`r8`) prevents pointer corruption during loop iterations.
2. **Index-Based Effective Address (`lea rdi, [r8 + rcx]`):** Utilizing a loop counter (`rcx`) as an index offset against a fixed base pointer ensures safe, linear traversal through the string from index `0` until hitting the null terminator (`0x00`).
3. **Accumulator Scaling (`imul r9, 10`):** As each new digit is parsed, the existing accumulated value in `r9` is multiplied by 10 to shift places, and the new digit value is added (`r9 = (r9 * 10) + digit`).

---

## 💻 Source Implementation (`solve.s`)

```assembly
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


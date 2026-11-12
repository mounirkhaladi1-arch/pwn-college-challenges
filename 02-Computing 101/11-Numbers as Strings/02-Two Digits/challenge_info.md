# Challenge Documentation: `two-digits`

## 🛠️ Challenge Overview & Target Track
- **Module:** `numbers-as-strings` (`computing-101`)
- **Challenge Name:** `two-digits`
- **Objective:** Implement a multi-character `atoi` routine in x86-64 assembly that converts a two-digit ASCII string (e.g., `"42"`) into its integer value by processing the tens place, multiplying by 10, and adding the units place.
* 👉 **[direct link to challenge](https://pwn.college/computing-101/numbers-as-strings/)**

---

## 🔬 Low-Level Mechanics & Pointer Arithmetic

1. **Pointer Preservation (`r8`):** When functions are called or pointers are manipulated, preserving the base memory address of the string in a callee-saved or scratch register (like `r8`) prevents data loss across subroutines.
2. **Positional Weighting (`imul`):** The first character represents the tens column. After converting it via `atoi_digit`, multiplying the result by 10 (`imul rax, 10`) scales it to its correct base-10 value.
3. **Effective Address Loading (`lea`):** To read the second character without dereferencing or corrupting pointers, `lea rdi, [r8 + 1]` safely computes and loads the memory address of the subsequent byte into `rdi` for the next `atoi_digit` call.

---

## 💻 Source Implementation (`solve.s`)

```assembly
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

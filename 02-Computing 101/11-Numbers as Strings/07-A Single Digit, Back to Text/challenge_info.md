# Challenge Documentation: `a-single-digit-back-to-text`

## 🛠️ Challenge Overview & Target Track
- **Module:** [numbers-as-strings](https://pwn.college/computing-101/numbers-as-strings/) (`computing-101`)
- **Challenge Name:** `a-single-digit-back-to-text`
- **Objective:** Implement an `itoa_digit` routine in x86-64 assembly that converts a single-digit integer value (`0-9`) into its corresponding ASCII character code (`'0'-'9'`, values `0x30` to `0x39`) as a shared library function.

---

## 🔬 Low-Level Mechanics & Direct Register Handling

1. **Integer Argument Passing by Value:** Unlike string parsing where inputs are pointers (`char*`), numerical arguments in the System V AMD64 ABI are passed **directly by value** inside registers (`rdi`).
2. **Direct Copy (`mov rax, rdi`):** Because the raw integer is already populated inside `rdi`, copying it straight into `rax` avoids invalid memory dereferencing (`[rdi]`), preventing segmentation faults.
3. **ASCII Offset Addition (`add rax, 0x30`):** Adding `0x30` (decimal `48`) maps numerical digits `0 through 9` directly to their respective ASCII representations.

---

## 💻 Source Implementation (`solve.s`)

```assembly
.intel_syntax noprefix
.global itoa_digit

itoa_digit:
    # Copy raw integer value directly from rdi into rax
    mov rax, rdi
    
    # Add ASCII base offset (0x30 / '0') to convert integer to character
    add rax, 0x30
    ret
```

---

## 🚀 Build, Link & Validation Workflow

```bash
# 1. Assemble source into object file
as -o solve.o solve.s

# 2. Link object file into a shared library object
ld -shared -o solve.so solve.o

# 3. Run official challenge check against the shared library
/challenge/check solve.so
```

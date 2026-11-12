# Challenge Documentation: `drop-the-leading-zero`

## 🛠️ Challenge Overview & Target Track
- **Challenge Name:** `drop-the-leading-zero`
- **Objective:** Extend the `itoa` implementation to handle numbers from `0` to `99` dynamically by checking if the input is less than `10`. Single-digit numbers must be written as a single character with a return count of `1`, dropping any leading zeros, while numbers `10` to `99` output two characters with a return count of `2`.
* 👉 **[direct link to challenge](https://pwn.college/computing-101/numbers-as-strings/)**

---

## 🔬 Low-Level Mechanics & Conditional Branching

1. **Value Range Check (`cmp rdi, 10` / `jl`):** Before applying division, inspect the integer value passed in `rdi`. If it is strictly less than 10, branch directly to single-digit formatting (`single_digit`) to bypass division and tens-place writing.
2. **Single-Digit Path (`0-9`):** Directly pass the value in `rdi` to `itoa_digit`, write the resulting ASCII byte into `[rsi]`, and return character count `1` in `rax`.
3. **Two-Digit Path (`10-99`):** Execute unsigned division by 10 (`div rcx`), extract the quotient (tens) and remainder (ones), convert both using `itoa_digit`, store them sequentially at `[rsi]` and `[rsi + 1]`, and return character count `2` in `rax`.

---

## 💻 Source Implementation (`solve.s`)

```assembly
.intel_syntax noprefix
.global itoa_digit
.global itoa

itoa:
    # Check if input is less than 10
    cmp rdi, 10
    jl single_digit

    # --- TWO DIGIT LOGIC (10 - 99) ---
    mov rax, rdi
    xor rdx, rdx
    mov rcx, 10
    div rcx              # rax = tens, rdx = ones

    # Convert & write tens to [rsi]
    push rdx
    mov rdi, rax
    call itoa_digit
    mov [rsi], al
    pop rdx

    # Convert & write ones to [rsi + 1]
    mov rdi, rdx
    call itoa_digit
    mov [rsi + 1], al

    mov rax, 2           # Return count = 2
    ret

single_digit:
    # --- SINGLE DIGIT LOGIC (0 - 9) ---
    call itoa_digit      # Converts rdi to ASCII character in rax
    mov [rsi], al        # Write single character to buffer
    mov rax, 1           # Return count = 1
    ret

itoa_digit:
    # Copy raw integer value directly from rdi into rax
    mov rax, rdi
    
    # Add ASCII base offset (0x30 / '0') to convert integer to character
    add rax, 0x30
    ret

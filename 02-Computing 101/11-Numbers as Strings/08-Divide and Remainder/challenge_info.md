# Challenge Documentation: `divide-and-remainder`

## 🛠️ Challenge Overview & Target Track
- **Module:** [numbers-as-strings](https://pwn.college/computing-101/numbers-as-strings/) (`computing-101`)
- **Challenge Name:** `divide-and-remainder`
- **Objective:** Implement an `itoa` routine in x86-64 assembly that accepts a two-digit integer and a buffer pointer (`rsi`), extracts the tens and units digits via division, converts them using `itoa_digit`, writes them into the output buffer, and returns the total written character count (`2`) in `rax`.

---

## 🔬 Low-Level Mechanics & Integer Division (`div`)

1. **Division Setup (`div rcx`):** The x86 `div` instruction divides the 128-bit value formed by `rdx:rax` by the divisor in `rcx` (set to `10`). Before executing `div`, the high bits in `rdx` must be cleared (`xor rdx, rdx`), and the integer to convert is placed into `rax`.
2. **Quotient & Remainder Extraction:** 
   - The quotient (tens digit) lands in `rax` and is passed in `rdi` to `itoa_digit`.
   - The remainder (units digit) lands in `rdx` and is passed in `rdi` to `itoa_digit`.
3. **Buffer Storing (`rsi`):** The ASCII characters returned by `itoa_digit` are written sequentially into the destination buffer pointer stored in `rsi` (`[rsi]` for the tens digit, `[rsi + 1]` for the units digit), with the final count (`2`) returned in `rax`.

---

## 💻 Source Implementation (`solve.s`)

```assembly
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

---

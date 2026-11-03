# Challenge Documentation: `a-single-digit`

## 🛠️ Challenge Overview & Target Track
- **Module:** `numbers-as-strings` (`computing-101`)
- **Challenge Name:** `a-single-digit`
- **Objective:** Implement a shared library function `atoi_digit(char *str)` that receives a pointer to a single ASCII character digit, converts it into its corresponding mathematical integer value, and returns it in `rax`.

---

## 🔬 Low-Level Mechanics & ASCII Conversion

When handling text input in systems programming, numerical digits are represented as ASCII byte characters (`'0'` through `'9'`) rather than raw binary integers:
1. **ASCII Encoding Offset:** `'0'` is encoded as byte `0x30`, `'1'` as `0x31`, up to `'9'` at `0x39`.
2. **Byte-Size Loading (`movzx`):** Because input pointers point to a single-byte character string, using a full 64-bit load (`mov rax, [rdi]`) pulls in adjacent stack memory garbage, yielding incorrect values. `movzx rax, byte ptr [rdi]` correctly loads just 1 byte and zero-extends the remaining upper bits of `rax`.
3. **Integer Decoding:** Subtracting `0x30` (`sub rax, 0x30`) strips the ASCII character encoding offset, mapping `'0'-'9'` directly to numerical integers `0-9`.

---

## 💻 Source Implementation (`solve.s`)

```assembly
.intel_syntax noprefix
.global atoi_digit

atoi_digit:
    # Load single ASCII character byte into rax with zero extension
    movzx rax, byte ptr [rdi]
    
    # Subtract ASCII offset (0x30) to convert character to integer value
    sub rax, 0x30
    
    ret

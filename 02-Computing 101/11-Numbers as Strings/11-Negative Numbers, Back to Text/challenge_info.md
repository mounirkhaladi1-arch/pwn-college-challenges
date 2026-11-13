# Challenge Documentation: `negative-numbers-back-to-text`

## 🛠️ Challenge Overview & Target Track
- **Module:** [numbers-as-strings](https://pwn.college/computing-101/numbers-as-strings/) (`computing-101`)
- **Challenge Name:** `negative-numbers-back-to-text`
- **Objective:** Successfully implement a fully generalized, signed `itoa` routine supporting arbitrary-length negative and positive integers, handling sign injection (`'-'`), absolute value conversion via `neg`, stack-based LIFO digit reversal, offset buffer writing, and correct return length counting.

---

## 🔬 Low-Level Mechanics & Signed Conversion Validation

1. **Signed Comparison (`jge`):** Using signed conditional checks (`cmp rdi, 0` followed by `jge non_neg`) correctly identifies negative integers (`< 0`) without confusing them with high-bit unsigned values.
2. **Sign Prepending & Offset Tracking:** When a number is negative, `0x2d` (`'-'`) is stored at `[rsi]`, the integer is negated (`neg rdi`), and `r9` / `r10` counters are incremented to offset subsequent digit writes.
3. **Arbitrary-Length Division Loop:** Repeated division by `10` extracts digits from right to left, pushing converted ASCII remainders onto the stack before popping them in correct left-to-right order into the destination buffer.

---

## 💻 Source Implementation (`itoa.s` / `solve.s`)

```assembly
.intel_syntax noprefix
.global itoa_digit
.global itoa

itoa:
    xor r10, r10
    xor r9, r9
 
    cmp rdi, 0
    jge non_neg
    mov byte ptr [rsi], 0x2d
    neg rdi
    inc r9
    inc r10

non_neg:
    # Check if input is less than 10
    cmp rdi, 10
    jl single_digit

    # --- MULTI-DIGIT / DIVISION LOGIC ---
    mov rax, rdi

loop:
    xor rdx, rdx
    mov rcx, 10
    div rcx              # rax = quotient, rdx = remainder (ones)

    mov rdi, rdx
    push rax
    call itoa_digit
    mov rdx, rax
    pop rax 
    push rdx

    inc r10     
    cmp rax, 0
    jne loop

write_loop:
    pop rdx
    mov [rsi+r9], dl
    inc r9
    cmp r10, r9
    jne write_loop
    mov rax, r10
    ret

single_digit:
    # --- SINGLE DIGIT LOGIC (0 - 9) ---
    call itoa_digit      # Converts rdi to ASCII character in rax
    mov [rsi+r9], al     # Write single character to buffer at offset r9
    mov rax, r9
    inc rax              # Return total count = r9 + 1
    ret

itoa_digit:
    # Copy raw integer value directly from rdi into rax
    mov rax, rdi
    
    # Add ASCII base offset (0x30 / '0') to convert integer to character
    add rax, 0x30
    ret

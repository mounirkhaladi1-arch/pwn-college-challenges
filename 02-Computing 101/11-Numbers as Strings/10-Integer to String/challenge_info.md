# Challenge Documentation: `integer-to-string`

## 🛠️ Challenge Overview & Target Track
- **Module:** [numbers-as-strings](https://pwn.college/computing-101/numbers-as-strings/) (`computing-101`)
- **Challenge Name:** `integer-to-string`
- **Objective:** Implement a fully generalized `itoa` routine that handles arbitrary-length integers. Extract digits from right to left using a division loop, preserve the correct digit order by pushing remainders onto the stack, pop and convert them using `itoa_digit`, write them sequentially into the output buffer (`rsi`), and return the total written character count in `rax`.
* 👉 **[direct link to Module](https://pwn.college/computing-101/numbers-as-strings/)**

---

## 🔬 Low-Level Mechanics & Stack Reversal Loop

1. **Repeated Division (`div`):** To convert an arbitrarily large integer, continuously divide by 10 (`rcx = 10`) until the quotient in `rax` becomes zero. Each remainder (`rdx`) represents a single decimal digit from right to left (least significant to most significant).
2. **Stack LIFO Reversal (`push` / `pop`):** Because division extracts the lowest digit first, pushing each remainder onto the stack reverses their order naturally. Popping them back off retrieves them in left-to-right (most significant to least significant) order.
3. **Buffer Assembly (`rsi`):** Using an index counter (`r9`), pop each raw digit off the stack, convert it to ASCII via `itoa_digit`, store it sequentially into `[rsi + r9]`, increment the length counter, and return the total count in `rax`.

---

## 💻 Source Implementation (`solve.s`)

```assembly
.intel_syntax noprefix
.global itoa_digit
.global itoa

itoa:
    xor rcx, rcx       # Initialize digit count tracker (counter = 0)
    mov rax, rdi       # Move input integer into rax

    # Special case for input == 0
    cmp rax, 0
    jne extract_loop
    
    # Handle zero explicitly
    mov rdi, 0
    call itoa_digit
    mov [rsi], al
    mov rax, 1
    ret

extract_loop:
    test rax, rax
    je write_setup

    xor rdx, rdx
    mov r8, 10
    div r8             # rax = quotient, rdx = remainder (digit)

    push rdx           # Push digit remainder onto stack
    inc rcx            # Increment digit counter
    jmp extract_loop

write_setup:
    mov r11, rcx       # Save total digit count to return later
    xor r9, r9         # Initialize buffer index offset (i = 0)

write_loop:
    cmp r9, r11
    jge done

    pop rdx            # Pop raw digit value from stack
    mov rdi, rdx
    call itoa_digit    # Convert integer digit to ASCII character in rax

    mov [rsi + r9], al # Store ASCII character in destination buffer
    inc r9             # Increment buffer index
    jmp write_loop

done:
    mov rax, r11       # Return total character count
    ret

itoa_digit:
    # Convert single digit integer (0-9) to ASCII character ('0'-'9')
    mov rax, rdi
    add rax, 0x30
    ret

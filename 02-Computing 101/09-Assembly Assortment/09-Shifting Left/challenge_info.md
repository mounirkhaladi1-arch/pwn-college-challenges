# challenge: shifting-left (shifting bits left using the shl instruction)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / shifting-left

- **challenge level:** implementing a custom shared library function in x86-64 assembly (`solve`) to perform a logical left shift by 4 bits on a 64-bit input integer

- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)


---

## 🧠 core rules & mechanisms

- **Left Shift Operation (`shl`):** The `shl` instruction shifts the bits of the destination operand to the left by the specified count (4 bits in this challenge). Each position shifted to the left multiplies the value by 2, meaning a 4-bit left shift multiplies the entire integer by 16 ($2^4$) and shifts hexadecimal digits left by one place.

- **Register Routing:** The input argument is received in `rdi`. Moving it into `rax` (`mov rax, rdi`) enables the operation to be performed directly on the return register before executing `shl rax, 4` and returning.


---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Move the input value from rdi into rax for manipulation and return
    mov rax, rdi
    
    # 2. Shift the value left by 4 bits (equivalent to multiplying by 16)
    shl rax, 4
    
    # 3. Return the shifted result
    ret

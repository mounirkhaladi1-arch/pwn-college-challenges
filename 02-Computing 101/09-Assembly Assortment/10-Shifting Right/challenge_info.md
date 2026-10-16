# challenge: shifting-right (extracting bytes via right shifting and masking)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / shifting-right

- **challenge level:** implementing a custom shared library function in x86-64 assembly (`solve`) to extract byte 1 (bits 8 through 15) from a 64-bit input integer using a right shift followed by a bitwise mask

- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)


---

## 🧠 core rules & mechanisms

- **Right Shift Operation (`shr`):** The `shr` instruction shifts the bits of the value to the right by a specified amount (8 bits in this case). Shifting right by 8 bits moves the target byte (bits 8-15) down to the lowest byte position (bits 0-7).

- **Isolating the Target Byte via Masking:** After shifting right, upper bits may still contain data depending on the original value. Applying a bitwise `and` operation with `0xff` (`and rax, 0xff`) clears all bits above the lowest byte, leaving precisely the isolated 8-bit target value.

- **Register Routing:** The input argument is received in `rdi`. Moving it into `rax` (`mov rax, rdi`) allows the shift and mask operations to be performed directly on the return register before returning.


---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Move the input value from rdi into rax for manipulation and return
    mov rax, rdi
    
    # 2. Shift right by 8 bits to move byte 1 into the lowest byte position
    shr rax, 8
    
    # 3. Mask with 0xff to clear any remaining upper bits
    and rax, 0xff
    
    # 4. Return the extracted byte
    ret

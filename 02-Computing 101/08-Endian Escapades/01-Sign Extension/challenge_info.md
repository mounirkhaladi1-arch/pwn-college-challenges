# challenge: sign-extension (converting signed bytes to 64-bit integers via `movsx`)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

* **dojo track / module:** endian-escapades / sign-extension
* **challenge level:** implementing a shared library function (`solve`) that receives a pointer to a signed byte (`rdi`), sign-extends it from 8 bits to 64 bits, and returns the properly scaled signed value in `rax`
* **execution format:** shared object compilation (`as`, `ld -shared`), harness testing (`/challenge/harness /tmp/your-program.so`), and automated validation

---

## 🧠 core rules & mechanisms

* **Signed vs. Unsigned Data Representation:** In two's complement arithmetic, the most significant bit (MSB) acts as the sign bit. If the MSB is `1`, the number is negative.
* **The Danger of Zero/Sign Extension Mismatches:** A standard 32-bit move (`mov eax, [rdi]`) or zero extension leaves the upper 32 or 56 bits as zero, incorrectly treating negative bytes (e.g., `0x80` through `0xff`) as large positive integers instead of negative values (like `-128` or `-1`).
* **Sign-Extending Move (`movsx`):** The `movsx` instruction copies a smaller source operand into a larger destination register while automatically replicating the sign bit across all remaining upper bits, preserving the exact negative magnitude.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Load the signed byte from the pointer in rdi and sign-extend it into 64-bit rax
    movsx rax, byte ptr [rdi]
    
    # 2. Return the sign-extended 64-bit value back to the harness
    ret

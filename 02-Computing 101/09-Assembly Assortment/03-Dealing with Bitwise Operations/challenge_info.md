# challenge: dealing-with-bitwise-operations (reversing bitwise check operations in assembly)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / dealing-with-bitwise-operations

- **challenge level:** analyzing bitwise operations performed on user input bytes (such as `xor`) and reversing the calculation to determine the required input character value that satisfies the comparison check (`cmp`)

- **execution format:** binary static analysis, bitwise inversion, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

- **Reversing Bitwise Checks:** When a binary modifies input bytes via bitwise instructions (e.g., `xor BYTE PTR [rax], 0x65`) before comparing the result (`cmp BYTE PTR [rax], 0x4`), you must apply the same bitwise operation again to undo it (`0x4 ^ 0x65 = 0x61` or character `'a'`), because XOR is its own inverse.

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
- Successfully calculated and verified the required input character: **`a`**

- Executing the target binary with the reconstructed input:

  `/challenge/reverse-me a`

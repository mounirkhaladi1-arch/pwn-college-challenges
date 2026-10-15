# challenge: reverse-the-calculation (reversing arithmetic check operations in assembly)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / reverse-the-calculation

- **challenge level:** analyzing arithmetic operations performed on user input bytes (such as `add` or sub-instructions) and reversing the calculation to determine the required input character value that satisfies the comparison check (`cmp`)

- **execution format:** binary static analysis, arithmetic inversion, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

- **Reversing Arithmetic Checks:** When a binary modifies input bytes via arithmetic instructions (e.g., `add BYTE PTR [rax], 0x1e`) before comparing the result (`cmp BYTE PTR [rax], 0x57`), you must invert the operation to find the original input character (`0x57 - 0x1e = 0x39` or character `'9'`).

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
- Successfully calculated and verified the required input character: **`9`**

- Executing the target binary with the reconstructed input:

  `/challenge/reverse-me 9`

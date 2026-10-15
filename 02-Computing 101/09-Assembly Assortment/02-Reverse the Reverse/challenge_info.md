# challenge: reverse-the-reverse (reversing subtraction check operations in assembly)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / reverse-the-reverse

- **challenge level:** analyzing subtraction operations performed on user input bytes (such as `sub`) and reversing the calculation to determine the required input character value that satisfies the comparison check (`cmp`)

- **execution format:** binary static analysis, arithmetic inversion, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

- **Reversing Subtraction Checks:** When a binary modifies input bytes via subtraction instructions (e.g., `sub BYTE PTR [rax], 0xe`) before comparing the result (`cmp BYTE PTR [rax], 0x36`), you must invert the operation by adding back the subtracted value to find the original input character (`0x36 + 0xe = 0x44` or character `'D'`).

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
- Successfully calculated and verified the required input character: **`D`**

- Executing the target binary with the reconstructed input:

  `/challenge/reverse-me D`

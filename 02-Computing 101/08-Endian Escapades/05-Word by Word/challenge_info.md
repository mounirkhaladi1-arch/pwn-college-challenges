# challenge: word-by-word (reversing 16-bit word chunks in little-endian order)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

- **dojo track / module:** endian-escapades / word-by-word

- **challenge level:** extracting and decoding 16-bit word constant segments from binary checks to reconstruct and pass multi-part passwords to target binaries

- **execution format:** binary static analysis, direct constant extraction from disassembly, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

- **Granular Word Slicing:** When binaries validate input in 16-bit chunks (word-by-word) rather than full qwords or dwords, you must isolate each 2-byte segment, read it directly without reversing from `objdump`, and order them into the final input string.

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
- Successfully extracted word components into the correct ASCII sequence: **`M9ddhA1uLsu7Deol`**

- Executing the target binary with the reconstructed password:

  `/challenge/reverse-me M9ddhA1uLsu7Deol`

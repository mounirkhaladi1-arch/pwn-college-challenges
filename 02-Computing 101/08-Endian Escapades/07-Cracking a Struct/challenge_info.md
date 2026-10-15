# challenge: cracking-a-struct (reversing mixed-size struct fields in little-endian order)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

- **dojo track / module:** endian-escapades / cracking-a-struct

- **challenge level:** extracting and decoding mixed-size structured constant segments (combining quadwords, dwords, words, and bytes) from binary checks to reconstruct and pass multi-part passwords to target binaries

- **execution format:** binary static analysis, direct constant extraction from disassembly, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

- **Structured Mixed-Size Slicing:** When binaries validate structured inputs containing varying data widths (such as a 64-bit qword followed by a 32-bit dword, 16-bit word, and individual bytes), you must isolate each segment according to its specific pointer offset, read the comparison constants directly without reversing from `objdump`, and assemble them in sequence into the final input string.

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
- Successfully extracted structured components into the correct ASCII sequence: **`tlOGG75g7qMVCOkV`**

- Executing the target binary with the reconstructed password:

  `/challenge/reverse-me tlOGG75g7qMVCOkV`

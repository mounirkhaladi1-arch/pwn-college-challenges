# challenge: byte-by-byte (reversing individual byte segments)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

- **dojo track / module:** endian-escapades / byte-by-byte

- **challenge level:** extracting and decoding individual byte constant segments from binary checks to reconstruct and pass multi-part passwords to target binaries

- **execution format:** binary static analysis, direct constant extraction from disassembly, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

- **Granular Byte Slicing:** When binaries validate input byte-by-byte (via `mov al, BYTE PTR [...]` and `cmp al, 0xXX`), you must isolate each individual 1-byte segment, read it directly without reversing from `objdump`, and order them into the final input string.

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
- Successfully extracted byte components into the correct ASCII sequence: **`qSQrjIFNrZf3HHgT`**

- Executing the target binary with the reconstructed password:

  `/challenge/reverse-me qSQrjIFNrZf3HHgT`

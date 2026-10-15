# challenge: scrambled-struct (reversing scrambled mixed-size struct fields)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

- **dojo track / module:** endian-escapades / scrambled-struct

- **challenge level:** extracting and decoding mixed-size structured constant segments out of sequential order based on explicit memory offsets (`[rdi+offset]`), reading direct constants from disassembly, and reconstructing the full input password

- **execution format:** binary static analysis, offset-based manual sorting, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

- **Offset-Based Reordering:** When binaries validate struct fields out of sequential order (e.g., comparing offset `+0xe` before offset `+0x8` or `+0x0`), you must map each extracted segment to its exact destination offset rather than the order of appearance in the assembly trace, and order them correctly into the final input string.

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
- Successfully extracted and reordered scrambled components into the correct ASCII sequence: **`o78t0rxOlPQcFcis`**

- Executing the target binary with the reconstructed password:

  `/challenge/reverse-me o78t0rxOlPQcFcis`

# challenge: qword-by-qword (reversing multiple 64-bit little-endian constants)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

* **dojo track / module:** endian-escapades / qword-by-qword
* **challenge level:** using static analysis (`objdump`) to extract multiple hardcoded 64-bit quadword constants (`movabs rbx`) verified across sequential memory offsets (`[rdi]` and `[rdi+0x8]`), and constructing a multi-qword command-line argument string
* **execution format:** binary disassembly (`objdump -d -M intel`), manual little-endian decoding per 8-byte chunk, and interactive validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

* **Multi-Qword Validation:** When passwords exceed 8 bytes, binaries often split the validation into multiple 64-bit chunks, comparing input quadwords against successive memory locations or pointer offsets (e.g., `QWORD PTR [rdi]` and `QWORD PTR [rdi+0x8]`).
* **Sequential Little-Endian Reconstruction:** Each 8-byte chunk embedded via `movabs` must be individually converted from hex, reversed to account for little-endian storage order, and concatenated together to form the full multi-block string.

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
* **Chunk 1 (`[rdi]`):** `movabs rbx, 0x5357417552705374` -> Bytes: `74 53 70 52 75 41 57 53` -> ASCII: **`tSpRuAWS`**
* **Chunk 2 (`[rdi+0x8]`):** `movabs rbx, 0x664d746a496f4a74` -> Bytes: `74 4a 6f 49 6a 74 4d 66` -> ASCII: **`tJoIjtMf`**

Concatenating both quadwords yields the full input string: **`tSpRuAWStJoIjtMf`** (plus any required trailing characters/nulls expected by the argument parser). Passing this into `/challenge/reverse-me` satisfies all `cmp` checks and releases the flag.

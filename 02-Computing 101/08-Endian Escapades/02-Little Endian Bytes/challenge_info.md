# challenge: little-endian-bytes (reversing and decoding little-endian 64-bit hex constants)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

* **dojo track / module:** endian-escapades / little-endian-bytes
* **challenge level:** using static analysis (`objdump`) to extract hardcoded 64-bit quadword constants from compiled binary checks, accounting for little-endian byte ordering, and translating hex chunks into valid ASCII passwords
* **execution format:** binary disassembly (`objdump -d -M intel`), manual byte reversal via scripting/logic, and interactive validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

* **Little-Endian Architecture:** x86_64 processors store multi-byte integers in memory in little-endian order, meaning the least significant byte (LSB) is stored at the lowest memory address. When values are embedded directly into immediate assembly instructions (like `movabs rbx, 0x4f67533663565750`), raw hex dumps must be read backward byte-by-byte to reconstruct the original string sequence.
* **Static Disassembly Extraction:** Inspecting binary sections with `objdump` reveals immediate comparisons (`cmp rax, rbx`), allowing you to extract expected binary secrets without running dynamic debuggers.
* **Byte Slicing & Decoding:** Reversing the byte array (`bytes.fromhex(hex_string)[::-1]`) transforms raw memory quadwords back into readable ASCII strings accepted by the command-line argument parser.

---

## 📄 analysis & extraction breakdown

From the `objdump` disassembly trace:
* Instruction: `movabs rbx, 0x4f67533663565750`
* Hex byte stream: `50 57 56 63 36 53 67 4f`
* ASCII conversion (reversed for little-endian layout): **`PWVc6SgO`**

Passing this decoded password string into `/challenge/reverse-me PWVc6SgO` satisfies the 64-bit register comparison (`cmp rax, rbx`) and releases the flag.

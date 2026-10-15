# challenge: dword-by-dword (reversing 32-bit dword chunks in little-endian order)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/endian-escapades/)**

---

## 🔗 environment details

* **dojo track / module:** endian-escapades / dword-by-dword
* **challenge level:** extracting and decoding smaller 32-bit dword constant segments from binary checks to reconstruct and pass multi-part passwords to target binaries
* **execution format:** binary static analysis, little-endian byte reordering via Python scripting, and interactive execution validation (`/challenge/reverse-me <password>`)

---

## 🧠 core rules & mechanisms

* **Granular Dword Slicing:** When binaries validate input in 32-bit chunks (dword-by-dword) rather than full 64-bit qwords, you must isolate each 4-byte segment, read it directly without reversing from `objdump`, and order them into the final input string.

---

## 📄 analysis & extraction breakdown

From the interactive session trace:
* Successfully decoded dword components into the correct ASCII sequence: **`megPTOHk9X6H4ySo`**
* Executing the target binary with the reconstructed password:
  `/challenge/reverse-me megPTOHk9X6H4ySo`

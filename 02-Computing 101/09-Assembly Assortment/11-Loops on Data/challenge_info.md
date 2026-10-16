# challenge: loops-on-data (reversing and traversing embedded data structures in assembly)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / loops-on-data

- **challenge level:** reverse-engineering an ELF binary (`/challenge/reverse-me`) using `objdump` and `gdb` to inspect memory contents, track pointer iteration, and extract an embedded secret string/password

- **execution format:** analyzing disassembly, debugging register state transitions (`rdi` and `rsi`), and executing the target binary with the correct argument


---

## 🧠 core rules & mechanisms

- **Data Inspection via GDB:** By setting up instruction-level execution (`starti`, `si`) and examining memory addresses pointed to by registers (`x/s $rsi`), we can read embedded string literals directly from memory segments (e.g., address `0x402000`).

- **String Comparison Loops:** The binary loads a pointer to the embedded password into `rsi` and the user-supplied argument pointer from the stack (`[rsp+0x10]`) into `rdi`. It then loops byte-by-byte, comparing `al` from `rsi` against `BYTE PTR [rdi]` until reaching the null terminator (`0x0`).


---

## 📄 source implementation / solution notes

```text
# Disassembly analysis revealed string storage at 0x402000:
# Examining $rsi via GDB yielded the exact password string required to pass the check.
# Executing /challenge/reverse-me with the retrieved password outputs the flag.

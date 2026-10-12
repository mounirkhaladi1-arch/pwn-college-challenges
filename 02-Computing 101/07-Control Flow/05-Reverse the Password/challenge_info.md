# challenge: reverse-the-password (reverse engineering byte-by-byte string comparisons in SUID binaries)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

- **dojo track / module:** computing-101 / control-flow

- **challenge level:** reverse engineering a compiled SUID binary (`/challenge/reverse-me`) that validates a hidden multi-byte password byte-by-byte using immediate hex values (`cmp` instructions).

- **execution format:** static/dynamic analysis via GDB (`disassemble`) or `objdump`, quick Python one-shot hex conversion, and direct execution to preserve SUID privileges and print the flag.


---

## 🧠 core rules & mechanisms

- **SUID Privilege Drop Limitation:** Running a SUID binary inside a debugger like GDB drops its elevated privileges. Because the program calls `open("/flag")`, executing it under GDB causes the system call to fail silently. Debugging is strictly for reading disassembly; the binary must be executed directly outside GDB.

- **Immediate Hex Mismatch Checks:** Instead of comparing against ASCII characters directly, the compiled binary compares `argv[1]` bytes against raw hexadecimal immediate values (e.g., `0x6b`, `0x71`).

- **Sequential Short-Circuiting:** The binary evaluates bytes sequentially using `cmp` and `jne <fail>`, requiring every single character of the input to align with the target sequence.


---

## ⚡ analysis, python handling & execution

```bash
# 1. Inspect the binary disassembly via GDB
gdb /challenge/reverse-me
(gdb) starti
(gdb) disassemble

# 2. Quick python one-shot conversion for the password
python3 -c 'print(chr(0x6b) + chr(0x71) + chr(0x67) + chr(0x6b))'

# 3. Run the binary directly outside GDB to preserve SUID privileges and retrieve the flag
/challenge/reverse-me kqgk

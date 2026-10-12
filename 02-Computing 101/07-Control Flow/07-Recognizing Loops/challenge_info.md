# challenge: recognizing-loops (looping string comparison & byte validation)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

- **dojo track / module:** computing-101 / control-flow

- **challenge level:** reverse engineering a loop-based string validator in `/challenge/reverse-me` that iterates through a target password buffer on the stack and compares it character-by-character against `argv[1]`.

- **execution format:** GDB inspection (`disassemble`, `si`), byte-to-character sequence translation, and direct command-line verification.


---

## 🧠 core rules & mechanisms

- **Loop-Based String Checking:** Instead of a massive chain of `cmp` instructions or a jump table, loops use `inc rdi` and `inc rsi` pointers to iterate dynamically through strings until hitting the null terminator (`0x0`).

- **Case and Sequence Sensitivity:** Every single byte (including exact casing like lowercase `'e'` vs uppercase `'E'`) must match the stack sequence precisely.

- **SUID Preservation:** Debug in GDB to inspect the stack-initialized password bytes, but run the final command directly outside the debugger to keep SUID privileges active.



---

## ⚡ analysis, python handling & execution

```bash
# 1. Start execution in GDB with a placeholder argument to populate the stack
gdb /challenge/reverse-me
(gdb) starti placeholder
(gdb) disassemble
(gdb) si  # Step through stack mov instructions to view the loop function. Even though stacking hardcoded bytes in rsp then moving rsp to rsi is enough evidence, you might want to make sure and explore more.

# 2. Quick python one-shot conversion of the stack bytes (e.g., 0x52, 0x65, 0x41, 0x4f, 0x46, 0x32)
python3 -c 'print("".join([chr(0x52), chr(0x65), chr(0x41), chr(0x4F), chr(0x46), chr(0x32)]))'

# 3. Exit GDB and run the binary directly with the correct string (ReAOF2) to get the flag
/challenge/reverse-me ReAOF2

# challenge: conditionals-without-conditionals (jump table switch-case matching)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

- **dojo track / module:** computing-101 / control-flow

- **challenge level:** reverse engineering a jump-table-based switch construct in `/challenge/reverse-me` that maps input byte values directly to code destinations without conditional branch instructions (`cmp`/`jne`).

- **execution format:** GDB dynamic analysis (`starti`, `x/256a`), jump table outlier hunting, offset calculation, and direct command-line validation.


---

## 🧠 core rules & mechanisms

- **Jump Table Architecture:** Instead of sequential comparisons, the program zero-outs `rax`, loads the first input byte into the low-byte register (`al`), multiplies it by 8, indexes an array of 8-byte code addresses in memory, and executes an indirect jump (`jmp rax`).

- **Constant-Time Case Dispatch:** This implements a 256-case switch statement entirely via memory lookups. Almost all unused entries point to the shared `fail` label, while the correct character points to `success`.

- **SUID Preservation:** As always, debug via GDB to inspect memory tables, but execute the binary directly outside the debugger to preserve SUID privileges and retrieve the flag.


---

## ⚡ analysis, GDB inspection & execution

```bash
# 1. Start execution in GDB with a 1-byte placeholder argument
gdb /challenge/reverse-me
(gdb) starti A
(gdb) disassemble

# 2. Dump the entire 256-entry jump table (base address found in the mov rax, [rax*8+...] instruction)
(gdb) x/256a 0x401088

# 3. Scan the output to find the outlier address pointing to <success> instead of <fail>
# Calculate character value: (Slot_Address - Base_Address) / 8
# Example: 0x4013c8 - 0x401088 = 0x340 -> 832 / 8 = 104 ('h'), or 0x4013d0 -> 105 ('i')

# 4. Exit GDB and run the binary directly with the recovered character
/challenge/reverse-me i

# challenge: examining-memory (inspecting stack memory contents directly with gdb)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** examining arbitrary memory addresses directly using GDB's examine (`x`) command with format specifiers
* **execution format:** interactive shell prompt (`gdb`, `starti`, `x $rsp`, `x/d $rsp`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Stack Pointer (`$rsp`):** In initial program execution states, the stack pointer register points directly to the top of the stack, housing crucial initial runtime parameters like `argc`.
* **Examine Memory Command (`x`):** GDB's `x` command inspects raw memory contents at a specified address. Passing a register like `$rsp` (e.g., `x $rsp`) reads raw data stored at that address.
* **Display Format Modifiers (`/d` & `/x`):**
  * `x $rsp` (or `x/x $rsp`): Displays memory content in **hexadecimal** format (e.g., `0x000000bd`).
  * `x/d $rsp`: Displays memory content in **decimal** format (e.g., `189`).
  * Both submission formats (`0x000000bd` or `189`) are valid for `/challenge/submit-number`.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~examining-memory:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)
Warning: 'set logging on', an alias for the command 'set logging enabled', is deprecated.
Use 'set logging enabled on'.

(gdb) starti

Dump of assembler code for function main:
=> 0x0000000000401000 <+0>:     mov    rdi,0x0
   0x0000000000401007 <+7>:     mov    rax,0x3c
   0x000000000040100e <+14>:    syscall
End of assembler dump.

0x0000000000401000 in main ()
(gdb) x rsp
No symbol table is loaded.  Use the "file" command.
(gdb) x $rsp
0x7fffffffe3f0: 0x000000bd
(gdb) x/d $rsp
0x7fffffffe3f0: 189
(gdb) q

ubuntu@introspecting~examining-memory:~$ /challenge/submit-number 0x000000bd
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

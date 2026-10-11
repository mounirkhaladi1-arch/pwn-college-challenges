# challenge: disassembling-in-gdb (manual disassembly execution)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** manually initiating program execution and running `disassemble` inside `gdb`
* **execution format:** interactive shell prompt (`gdb`, `starti`, `disassemble`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Interactive Control:** Taking full manual control of the debugging session after startup (`starti`).
* **Command Correction:** Handling typographical errors in interactive prompts (e.g., catching `disassamble` typo and correcting it to `disassemble`).
* **Value Retrieval:** Extracting the immediate hexadecimal constant loaded into `rdi` (`0x799`).

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~disassembling-in-gdb:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)
Warning: 'set logging on', an alias for the command 'set logging enabled', is deprecated.
Use 'set logging enabled on'.

(gdb) starti

HACKER: You successfully started your program!
HACKER: Now, run the 'disassemble' command to view the assembly code.
HACKER: Read the assembly to find the secret number stored in rdi and
HACKER: submit that with /challenge/submit-number. Good luck!
HACKER: When you're done, quit GDB with 'quit' (or 'q').

0x0000000000401000 in main ()
(gdb) disassamble
Undefined command: "disassamble". Try "help".
(gdb) disassemble
Dump of assembler code for function main:
=> 0x0000000000401000 <+0>:     mov    rdi,0x799
   0x0000000000401007 <+7>:     mov    rdi,0x0
   0x000000000040100e <+14>:    mov    rax,0x3c
   0x0000000000401015 <+21>:    syscall
End of assembler dump.
(gdb) q

ubuntu@introspecting~disassembling-in-gdb:~$ /challenge/submit-number 0x799
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

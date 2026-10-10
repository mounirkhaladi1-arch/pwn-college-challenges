# challenge: starting-programs-in-gdb (running and disassembling inside the debugger)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** initiating binary execution via `starti` and viewing assembly with `disassemble` in `gdb`
* **execution format:** interactive shell prompt (`gdb`, `starti`, `disassemble`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Starting Execution (`starti`):** Launches the target binary at its very first instruction, allowing runtime inspection before execution proceeds further.
* **Disassembly Inspection (`disassemble`):** Prints out the assembly instruction stream of the active function in memory.
* **Secret Extraction:** Reading the operand loaded into registers (such as `mov rdi, 0x6e3`) right before it gets overwritten.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~starting-programs-in-gdb:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)
Warning: 'set logging on', an alias for the command 'set logging enabled', is deprecated.
Use 'set logging enabled on'.

(gdb) starti

HACKER: You successfully started your program!
HACKER: I am now going to invoke the 'disassemble' command for you.
HACKER: Read the assembly to find the secret number stored in rdi and
HACKER: submit that with /challenge/submit-number. Good luck!

(gdb) disassemble
Dump of assembler code for function main:
=> 0x0000000000401000 <+0>:     mov    rdi,0x6e3
   0x0000000000401007 <+7>:     mov    rdi,0x0
   0x000000000040100e <+14>:    mov    rax,0x3c
   0x0000000000401015 <+21>:    syscall
End of assembler dump.

HACKER: You can now quit GDB by typing 'quit' (or just 'q').
0x0000000000401000 in main ()
(gdb) q

ubuntu@introspecting~starting-programs-in-gdb:~$ /challenge/submit-number 0x6e3
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

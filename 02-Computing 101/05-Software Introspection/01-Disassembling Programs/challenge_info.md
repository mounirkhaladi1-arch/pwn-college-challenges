# challenge: disassemble-me (extracting secrets via objdump)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** binary disassembly and secret extraction using `objdump`
* **execution format:** interactive shell prompt (`objdump`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Disassembly with `objdump`:** Converts raw machine code back into human-readable assembly instructions.
* **Intel Syntax Enforcement:** Using the `-M intel` flag is mandatory to ensure registers and operands are ordered logically (destination on the left).
* **Secret Extraction:** Identifying immediate values loaded into registers (e.g., `mov rdi, 0x174f`) right before they are overwritten or used by system calls.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~disassembling-programs:~$ objdump -d -M intel /challenge/disassemble-me

/challenge/disassemble-me:     file format elf64-x86-64

Disassembly of section .text:

0000000000401000 <__bss_start-0x1000>:
  401000:       48 c7 c7 4f 17 00 00     mov    rdi,0x174f
  401007:       48 c7 c7 00 00 00 00     mov    rdi,0x0
  40100e:       48 c7 c0 3c 00 00 00     mov    rax,0x3c
  401015:       0f 05                    syscall

ubuntu@introspecting~disassembling-programs:~$ /challenge/submit-number 0x174f
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

# challenge: stepping-through-instructions (single-stepping through assembly instructions)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** stepping through instructions using `stepi` (`si`) to inspect register states when disassembly is censored
* **execution format:** interactive shell prompt (`gdb`, `starti`, `si`, `print $rdi`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Dynamic Analysis vs. Censored Disassembly:** When static values are obfuscated/censored in assembly listings, executing the binary allows observation of actual register states at runtime.
* **Single Instruction Stepping (`stepi` / `si`):** Advances execution by exactly one machine instruction, updating register states.
* **Register Inspection:** Evaluating register contents post-execution (e.g., `print $rdi`) recovers runtime secrets regardless of static code obfuscation.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~stepping-through-instructions:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)
Warning: 'set logging on', an alias for the command 'set logging enabled', is deprecated.
Use 'set logging enabled on'.

(gdb) starti

Dump of assembler code for function main:
=> 0x0000000000401000 <+0>:     mov    rdi,CENSORED
   0x0000000000401007 <+7>:     mov    rdi,0x0
   0x000000000040100e <+14>:    mov    rax,0x3c
   0x0000000000401015 <+21>:    syscall
End of assembler dump.

HACKER: The disassembly above shows the program, but the secret value is CENSORED!
HACKER: You can't read it from the code, but you CAN execute the instruction
HACKER: and then read the register. Use 'stepi' (or 'si') to execute one instruction.
0x0000000000401000 in main ()
(gdb) si

Dump of assembler code for function main:
   0x0000000000401000 <+0>:     mov    rdi,CENSORED
=> 0x0000000000401007 <+7>:     mov    rdi,0x0
   0x000000000040100e <+14>:    mov    rax,0x3c
   0x0000000000401015 <+21>:    syscall
End of assembler dump.

HACKER: You stepped forward! The 'mov rdi, CENSORED' instruction just executed.
HACKER: I'll now read the rdi register for you:

(gdb) print $rdi
$1 = 27132

HACKER: There's your secret! Submit it with /challenge/submit-number.
HACKER: You can quit GDB with 'quit' (or 'q').
0x0000000000401007 in main ()
(gdb) q

ubuntu@introspecting~stepping-through-instructions:~$ /challenge/submit-number 27132
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

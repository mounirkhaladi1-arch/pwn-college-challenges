# challenge: setting-register-values (modifying processor state in gdb)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** modifying live CPU registers using `set $rdi = <val>` during execution
* **execution format:** interactive shell prompt (`gdb`, `starti`, `si`, `set $rdi=1337`, `print $rdi`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **State Manipulation (`set`):** Allows an analyst to inject custom values directly into CPU registers at runtime using `set $register = value`.
* **Execution Flow Impact:** Overriding `rdi` to `1337` prior to executing `add rdi, CENSORED` alters the arithmetic operation outcome, yielding a new calculated secret (`34402`).
* **Sequence:** `starti` $\rightarrow$ `si` (passes `mov rdi, 0`) $\rightarrow$ `set $rdi=1337` $\rightarrow$ `si` (executes `add rdi, CENSORED`) $\rightarrow$ `print $rdi` $\rightarrow$ `q` $\rightarrow$ submit.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~setting-register-values:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)
(gdb) starti

Dump of assembler code for function main:
=> 0x0000000000401000 <+0>:     mov    rdi,0x0
   0x0000000000401007 <+7>:     add    rdi,CENSORED
   0x000000000040100e <+14>:    mov    rdi,0x0
   0x0000000000401015 <+21>:    mov    rax,0x3c
   0x000000000040101c <+28>:    syscall
End of assembler dump.

HACKER: Use 'stepi' to execute the first instruction.
0x0000000000401000 in main ()
(gdb) set $rdi=1337
(gdb) si

Dump of assembler code for function main:
   0x0000000000401000 <+0>:     mov    rdi,0x0
=> 0x0000000000401007 <+7>:     add    rdi,CENSORED
   0x000000000040100e <+14>:    mov    rdi,0x0
   0x0000000000401015 <+21>:    mov    rax,0x3c
   0x000000000040101c <+28>:    syscall
End of assembler dump.

HACKER: The first instruction set rdi to 0.
HACKER: Use 'set $rdi = 1337' to change it, then use 'stepi' once more.
0x0000000000401007 in main ()
(gdb) set $rdi= 1337
(gdb) si

Dump of assembler code for function main:
   0x0000000000401000 <+0>:     mov    rdi,0x0
   0x0000000000401007 <+7>:     add    rdi,CENSORED
=> 0x000000000040100e <+14>:    mov    rdi,0x0
   0x0000000000401015 <+21>:    mov    rax,0x3c
   0x000000000040101c <+28>:    syscall
End of assembler dump.

HACKER: Your changed register produced a secret number!
HACKER: Use 'print $rdi' to read it, then submit it with /challenge/submit-number.
HACKER: When you're done, quit GDB with 'quit' (or 'q').
0x000000000040100e in main ()
(gdb) print $rdi
$1 = 34402
(gdb) q

ubuntu@introspecting~setting-register-values:~$ /challenge/submit-number 34402
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

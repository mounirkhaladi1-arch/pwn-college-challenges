# challenge: popping-stack-values (extracting runtime stack data via gdb)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** extracting stack-based runtime state (`argc`) before it gets overwritten
* **execution format:** interactive shell prompt (`gdb`, `starti`, `si`, `print $rdi`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Runtime Stack State:** Unlike hardcoded constants, parameters like `argc` (argument count) reside dynamically on the stack and depend entirely on process launch parameters.
* **Stack Popping (`pop rdi`):** Pulls the top value off the stack and stores it into `rdi`.
* **Interception Window:** Because the subsequent instruction (`mov rdi, 0x0`) immediately wipes out the register, the analyst must execute a single step (`si`) right after `pop rdi` and query the register (`print $rdi`) to capture the secret (`142`) before it vanishes.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~popping-stack-values:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)

(gdb) starti

Dump of assembler code for function main:
=> 0x0000000000401000 <+0>:     pop    rdi
   0x0000000000401001 <+1>:     mov    rdi,0x0
   0x0000000000401008 <+8>:     mov    rax,0x3c
   0x000000000040100f <+15>:    syscall
End of assembler dump.

0x0000000000401000 in main ()
(gdb) si

Dump of assembler code for function main:
   0x0000000000401000 <+0>:     pop    rdi
=> 0x0000000000401001 <+1>:     mov    rdi,0x0
   0x0000000000401008 <+8>:     mov    rax,0x3c
   0x000000000040100f <+15>:    syscall
End of assembler dump.

0x0000000000401001 in main ()
(gdb) print $rdi
$1 = 142
(gdb) q

ubuntu@introspecting~popping-stack-values:~$ /challenge/submit-number 142
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

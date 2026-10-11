# challenge: reading-register-values (inspecting CPU registers with gdb)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** manually querying register values using `print $rdi` after single-stepping
* **execution format:** interactive shell prompt (`gdb`, `starti`, `si`, `print $rdi`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Register Syntax in GDB:** CPU registers are evaluated using the `$` prefix (e.g., `$rdi`, `$rax`, `$rip`).
* **Manual Inspection:** Utilizing the `print` command (`p`) to read the exact decimal or hex value stored in an active register post-instruction execution.
* **Workflow Loop:** `starti` $\rightarrow$ `si` (execute `mov rdi, CENSORED`) $\rightarrow$ `print $rdi` (extract secret `27594`) $\rightarrow$ `q` $\rightarrow$ submit.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~reading-register-values:~$ gdb /challenge/debug-me
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

HACKER: The disassembly is CENSORED! Use 'stepi' to execute the first instruction.
0x0000000000401000 in main ()
(gdb) si

Dump of assembler code for function main:
   0x0000000000401000 <+0>:     mov    rdi,CENSORED
=> 0x0000000000401007 <+7>:     mov    rdi,0x0
   0x000000000040100e <+14>:    mov    rax,0x3c
   0x0000000000401015 <+21>:    syscall
End of assembler dump.

HACKER: You just executed 'mov rdi, CENSORED' --- the secret is now in rdi!
HACKER: Use 'print $rdi' to read the register value!
HACKER: When you're done, quit GDB with 'quit' (or 'q').
0x0000000000401007 in main ()
(gdb) print $rdi
$1 = 27594
(gdb) q

ubuntu@introspecting~reading-register-values:~$ /challenge/submit-number 27594
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

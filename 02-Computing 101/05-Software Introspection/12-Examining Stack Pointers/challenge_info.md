# challenge: examining-stack-pointers (dereferencing stack argument pointers and reading strings in gdb)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** examining multi-level stack pointers and string structures using advanced GDB format specifiers (`/a` and `/s`)
* **execution format:** interactive shell prompt (`gdb`, `starti`, `x/a $rsp+16`, `x/s <address>`, `q`)

---

## 🧠 core rules & mechanisms

* **Stack Layout for Arguments:** Beyond `argc` (at `$rsp`), the stack stores pointers to individual program arguments (`argv`). For instance, `$rsp+16` holds the memory address pointing directly to the first argument's string data.
* **Address Format Modifier (`/a`):** Using `x/a $rsp+16` instructs GDB to display the memory contents as a hexadecimal address (e.g., `0x7fffffffed4e`).
* **String Format Modifier (`/s`):** Using `x/s <address>` dereferences the pointer and reads the raw memory as a null-terminated ASCII string, directly revealing hidden data like flags stored in argument vectors.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~examining-stack-pointers:~$ gdb /challenge/debug-me
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
(gdb) x/a $rsp+16
0x7fffffffeb00: 0x7fffffffed4e
(gdb) x/s 0x7fffffffed4e
0x7fffffffed4e: "pwn.college{Y1KBj42WWsXn95jpBTSTPZNdW4z.0VOzczMywCO1AjM2EzW}"
(gdb) q

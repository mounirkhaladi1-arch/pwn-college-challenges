# challenge: quitting-gdb (exiting the debugger session)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** Quiting GDB `gdb`
* **execution format:** interactive shell prompt (`gdb`, `quit` / `q`)

---

## 🧠 core rules & mechanisms

* **Interactive Session Control:** Debugger sessions must be explicitly terminated using the `quit` command (or its shorthand `q`).
* **Automated Verification:** Completing the correct debugger launch and exit sequence triggers the validation mechanism automatically.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~quitting-gdb:~$ gdb /challenge/debug-me 
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...

warning: ~/.gdbinit-gef.py: No such file or directory
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)
Warning: 'set logging on', an alias for the command 'set logging enabled', is deprecated.
Use 'set logging enabled on'.



You successfully started GDB!
Here is the secret number: 5350
Submit that with /challenge/submit-number.

HACKER: Now, quit GDB by typing 'quit' (or just 'q').

(gdb) q

You quit GDB! Great job.
CORRECT! Here is your flag:
pwn.college{REDACTED}
ubuntu@introspecting~quitting-gdb:~$ 

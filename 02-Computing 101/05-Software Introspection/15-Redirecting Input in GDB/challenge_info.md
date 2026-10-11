# challenge: redirecting-input-in-gdb (stdin redirection during debugger execution)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** redirecting standard input (`stdin`) files into a binary while running inside `gdb`
* **execution format:** interactive shell prompt (`gdb`, `r < /challenge/secret`, `q`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **Standard Input Redirection in GDB:** Just like standard shell redirection, GDB permits routing files into a program's `stdin` by appending redirection operators (such as `< /path/to/input`) directly after the `run` or `r` command.
* **Resolving Paths Interactively:** Using tab-completion inside GDB (e.g., `/challenge/s<TAB>`) helps pinpoint exact resource files (like `/challenge/secret`) when path names are partially known or obscured.
* **Execution & Output Extraction:** Redirecting the required input file allows the binary to process its payload, print the resulting secret number (`30159`), and exit normally for final validation.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~redirecting-input-in-gdb:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
...
(No debugging symbols found in /challenge/debug-me)
(gdb) r < /challenge/secret
Starting program: /challenge/debug-me < /challenge/secret
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
secret number: 30159
[Inferior 1 (process 135) exited normally]
(gdb) q

ubuntu@introspecting~redirecting-input-in-gdb:~$ /challenge/submit-number 30159
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

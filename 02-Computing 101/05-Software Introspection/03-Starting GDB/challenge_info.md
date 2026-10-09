# challenge: starting-gdb (introduction to the gnu debugger)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** launching and inspecting binaries using `gdb`
* **execution format:** interactive shell prompt (`gdb`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **The GNU Debugger (`gdb`):** The standard Linux tool for close monitoring, runtime inspection, and bug hunting of target processes.
* **Basic Execution:** Loading a binary into the debugger via `gdb /path/to/binary` initializes the debugging session and reads symbols (if available).
* **Automated Hinting:** Initial introductory challenges in this module output the target secret directly upon successful debugger attachment.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~starting-gdb:~$ gdb /challenge/debug-me 
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)

You successfully started GDB!
Here is the secret number: 4576
Submit that with /challenge/submit-number. Goodbye!

ubuntu@introspecting~starting-gdb:~$ /challenge/submit-number 4576
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

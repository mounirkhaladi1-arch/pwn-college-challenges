# challenge: trace-me (syscall introspection via strace)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** dynamic tracing and system call snooping using `strace`
* **execution format:** interactive shell prompt (`strace`, `/challenge/submit-number`)

---

## 🧠 core rules & mechanisms

* **System Call Tracing (`strace`):** Intercepts and records every system call invoked by a target program, along with its arguments and return values.
* **Syntax convention:** Follows a C-like notation: `syscall_name(arg1, arg2, ...) = return_value`.
* **Alarm SNOOPING:** Identifying hidden parameters passed to system calls (such as the `alarm(seconds)` timer) that dictate program runtime behavior.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~tracing-syscalls:~$ strace /challenge/trace-me 
execve("/challenge/trace-me", ["/challenge/trace-me"], 0x7ffea8ff49e0 /* 16 vars */) = 0
alarm(3798)                             = 0
exit(0)                                 = ?
+++ exited with 0 +++

ubuntu@introspecting~tracing-syscalls:~$ /challenge/submit-number 3798
CORRECT! Here is your flag:
pwn.college{[REDACTED]}

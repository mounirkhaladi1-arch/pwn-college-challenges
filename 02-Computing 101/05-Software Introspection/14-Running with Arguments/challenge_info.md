# challenge: running-with-arguments (passing command-line arguments in gdb)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** passing command-line arguments to binaries during execution inside `gdb`
* **execution format:** interactive shell prompt (`gdb`, `run` / `r pwn`)

---

## 🧠 core rules & mechanisms

* **Argument Passing in GDB (`run` / `r`):** While `starti` halts execution at the very beginning without parameters, the `run` command (abbreviated as `r`) launches the program from the start while allowing command-line arguments to be appended (e.g., `r pwn`).
* **Inferior Mapping:** Arguments provided after `run` populate `argv[1]`, `argv[2]`, etc., exactly as they would when executing the binary directly from a standard shell.
* **Direct Execution & Flag Retrieval:** Passing the required expected argument (`pwn`) satisfies the program's input validation logic, causing it to print the flag and exit normally.

---

## 🛠️ execution sample & prompt flow

```text
ubuntu@introspecting~running-with-arguments:~$ gdb /challenge/debug-me
GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1
...
Reading symbols from /challenge/debug-me...
(No debugging symbols found in /challenge/debug-me)
(gdb) r pwn
Starting program: /challenge/debug-me pwn

This GDB supports auto-downloading debuginfo from the following URLs:
  [https://debuginfod.ubuntu.com](https://debuginfod.ubuntu.com)
...
pwn.college{4eVQY74lj26SfsaSnzp0zh6G00q.01M1kDNywCO1AjM2EzW}
[Inferior 1 (process 147) exited normally]
(gdb)

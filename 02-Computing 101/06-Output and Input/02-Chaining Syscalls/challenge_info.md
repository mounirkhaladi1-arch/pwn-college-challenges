# challenge: chaining-syscalls (chaining write and exit system calls cleanly)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/hello-hackers/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / Output and Input
* **challenge level:** chaining multiple consecutive kernel syscalls (`write` followed by `exit`) in raw assembly without crashing
* **execution format:** custom assembly compilation (`as`, `ld`), interactive testing, and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Sequential Syscall Execution:** In bare-metal assembly without standard libraries, chaining tasks simply means setting up the appropriate registers for one system call, triggering `syscall`, and then immediately overwriting the registers with new values to trigger the next system call.
* **The `write` Phase:** 
  * `rax = 1` (`sys_write`)
  * `rdi = 1` (`stdout`)
  * `rsi = [rsp+16]` (`argv[1]` pointer)
  * `rdx = 1` (length of 1 byte)
* **The `exit` Phase:** 
  * `rax = 60` (`sys_exit`)
  * `rdi = 42` (custom exit status code checked via `echo $?` in the shell)

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rsi, [rsp+16]   # Address of the first argument stored at rsp+16
    mov rdx, 1          # Number of characters to write
    mov rax, 1          # Write syscall number
    syscall
    
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # Exit syscall number
    syscall

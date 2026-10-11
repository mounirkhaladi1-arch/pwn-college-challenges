# challenge: writing-strings (writing multi-byte strings and full flags to stdout)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/hello-hackers/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / Output and Input
* **challenge level:** extending the `write` system call buffer length to output full multi-character argument strings (such as 64-byte security flags)
* **execution format:** custom assembly compilation (`as`, `ld`), interactive testing, and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Buffer Length Register (`rdx`):** While previous challenges set `rdx = 1` to output a single character byte, writing entire strings or complete flags requires increasing the length counter (`rdx = 64`) to match the payload size.
* **Full Argument Buffer:** Moving `[rsp+16]` into `rsi` points the kernel directly to the beginning of the string buffer, and `rdx` dictates how many continuous bytes the `write` system call reads from that pointer down to `stdout`.
* **Clean Termination:** Following the string write with `mov rax, 60` and `syscall` ensures a clean exit code (`42`) without triggering segfaults.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rsi, [rsp+16]   # Address of the first argument string stored at rsp+16
    mov rdx, 64         # Set write buffer length to 64 bytes (to capture the full flag)
    mov rax, 1          # Write syscall number
    syscall
    
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # Exit syscall number
    syscall

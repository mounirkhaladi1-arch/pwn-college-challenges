# challenge: reading-data (reading input from stdin via system calls and echoing to stdout)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/hello-hackers/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / Output and Input
* **challenge level:** reading data from standard input (`stdin`) into memory using `sys_read`, echoing it back via `sys_write`, and cleanly exiting
* **execution format:** custom assembly compilation (`as`, `ld`), pipeline testing (`echo ... | solve`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **The `read` System Call (`rax = 0`):** Instructs the kernel to read incoming bytes from a file descriptor into memory.
* **Input File Descriptor (`rdi = 0`):** Setting `rdi = 0` targets Standard Input (`stdin`), allowing the program to receive piped input or keyboard data.
* **Stack Memory Buffer (`rsi = rsp`):** Uses the top of the stack (`rsp`) as a valid, writable memory region to store the incoming bytes.
* **Register Persistence Optimization:** Because Linux system calls preserve `rsi` and `rdx` across certain calls, the buffer address and byte count configured during `read` can carry straight into the subsequent `write` call without redundant register re-loads.
* **Clean Termination:** Concludes execution using the `exit` system call (`rax = 60`) with exit status `42` (`rdi = 42`).

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 0          # Set file descriptor to 0 (stdin)
    mov rsi, rsp        # Point buffer to the stack pointer (rsp)
    mov rdx, 128        # Read up to 128 bytes
    mov rax, 0          # Read syscall number
    syscall
    
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    # mov rsi, rsp      # Reuses same value from previous call
    # mov rdx, 128      # Reuses same value from previous call
    mov rax, 1          # Write syscall number
    syscall
    
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # Exit syscall number
    syscall

# challenge: reading-exactly (dynamic buffer sizing using `read` return values)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/Output-and-Input/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / Output and Input
* **challenge level:** capturing a dynamic input stream via `sys_read`, extracting its exact length from `rax`, and passing it to `sys_write` via `rdx`
* **execution format:** custom assembly compilation (`as`, `ld`), pipeline testing, and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Dynamic Return Values (`rax`):** Upon completion of a system call, the kernel places the return value into `rax`. For `sys_read`, `rax` contains the exact count of bytes actually read.
* **Size Hand-off (`mov rdx, rax`):** The byte count captured in `rax` must be transferred into `rdx` before `rax` is overwritten by the next system call number.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 0          # Set file descriptor to 0 (stdin)
    mov rsi, rsp        # Point buffer to stack memory
    mov rdx, 128        # Request up to 128 bytes max buffer capacity
    mov rax, 0          # Read syscall number
    syscall             # Returns actual bytes read in rax

    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rdx, rax        # Transfer exact byte count from rax to write length (rdx)
    # mov rsi, rsp      # Buffer pointer remains at rsp
    mov rax, 1          # Write syscall number
    syscall
    
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # Exit syscall number
    syscall

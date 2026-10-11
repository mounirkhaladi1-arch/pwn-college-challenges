# challenge: writing-output (writing raw bytes to stdout using system calls)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/hello-hackers/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / hello-hackers
* **challenge level:** invoking the `write` system call to output characters from command-line arguments (`argv[1]`)
* **execution format:** custom assembly compilation (`as`, `ld`), interactive testing, and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **The `write` System Call (`rax = 1`):** Instructs the Linux kernel to write data from a specified buffer to a file descriptor.
* **File Descriptors (`rdi`):** Setting `rdi = 1` targets Standard Output (`stdout`), directing the written bytes straight to the screen.
* **Buffer Pointer (`rsi`):** Pulling from `[rsp+16]` dereferences the address of the program's first argument (`argv[1]`), pointing the syscall directly to the target character/string.
* **Length Specification (`rdx`):** Defines the exact number of bytes to transfer (e.g., `rdx = 1` for a single character).
* **The Crash Phenomenon:** Without a subsequent `exit` syscall (`rax = 60`), the CPU continues blindly executing random bytes following the code section, eventually triggering a `Segmentation fault` (though automated checkers often pass successfully as long as the output byte is written).

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
    # Missing exit syscall causes the crash here! I thought they would handle the exit themselves, and I was right lol

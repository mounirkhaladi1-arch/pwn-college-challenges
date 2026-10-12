# challenge: rip-relative-strings (position-independent data access via RIP-relative addressing)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/hello-hackers/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / hello-hackers
* **challenge level:** utilizing RIP-relative addressing (`lea rdi, [rip+path]`) to reference a null-terminated string (`.asciz`) stored in the data section without hardcoding absolute memory addresses
* **execution format:** custom assembly compilation (`as`, `ld`), standalone execution (`./solve`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **RIP-Relative Addressing (`[rip + offset]`):** In x86_64, the instruction pointer (`rip`) always points to the next instruction to be executed. By referencing `rip + path`, the CPU calculates the exact distance to the string data at runtime, regardless of where the program is loaded into memory.
* **The `lea` Instruction (Load Effective Address):** Unlike `mov`, which fetches the *value* stored at a memory address, `lea` calculates the *address itself* and stores it into the destination register (`rdi`).
* **The `.asciz` Directive:** Declares a null-terminated ASCII string in the assembly file's data section, cleanly separating code execution from static data strings.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Load pointer to the filename using RIP-relative addressing
    lea rdi, [rip+path] # Calculate dynamic position-independent address of "path"
    mov rsi, 0          # Set access mode to 0 (O_RDONLY / Read-Only)
    mov rax, 2          # sys_open syscall number
    syscall             # Returns custom file descriptor in rax

    # 2. Read from the opened file descriptor into memory
    mov rdi, rax        # Move the new file descriptor into rdi
    mov rsi, rsp        # Point buffer destination to stack memory (rsp)
    mov rdx, 128        # Request up to 128 bytes max capacity
    mov rax, 0          # sys_read syscall number
    syscall             # Returns actual bytes read in rax

    # 3. Write the captured data to stdout
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rdx, rax        # Transfer exact byte count from rax to write length (rdx)
    mov rax, 1          # sys_write syscall number
    syscall

    # 4. Clean exit with status 42
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # sys_exit syscall number
    syscall

path:
    .asciz "/flag"      # Null-terminated string stored in the binary data section

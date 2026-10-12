# challenge: hardcoding-the-filename (embedding strings byte-by-byte on the stack for `sys_open`)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/hello-hackers/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / hello-hackers
* **challenge level:** constructing the string `"/flag\0"` directly on the stack one byte at a time using `mov BYTE PTR` instructions, obtaining its memory pointer, and passing it to `sys_open`
* **execution format:** custom assembly compilation (`as`, `ld`), standalone execution (`./solve`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Stack String Construction (`mov BYTE PTR`):** When command-line arguments are not provided, strings must be built natively in writable memory. Using `mov BYTE PTR [rsp+offset], 'char'` places individual ASCII values sequentially onto the stack.
* **Null Termination (`\0`):** C-style and system-level string pointers require a terminating null byte (`0`) so the kernel knows exactly where the string ends.
* **Pointer Retrieval (`mov rdi, [rsp]` vs `mov rdi, rsp`):** 
  * *Correction note:* In the working solve script, `mov rdi, [rsp]` actually loads the 8-byte value at `rsp` (the packed string letters interpreted as an integer like `0x67616c662f` / `"/flag"`), which serves as a direct pointer or register-embedded string approach depending on register width, or more accurately pointing to the stack layout where `rsp` holds the pointer or value. Specifically, passing `rsp` itself (`mov rdi, rsp`) provides the memory address of the string buffer.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Construct the filename string "/flag" byte by byte onto the stack
    mov byte ptr [rsp], '/'
    mov byte ptr [rsp+1], 'f'
    mov byte ptr [rsp+2], 'l'
    mov byte ptr [rsp+3], 'a'
    mov byte ptr [rsp+4], 'g'
    mov byte ptr [rsp+5], 0       # Null terminator

    # 2. Open the hardcoded filename
    mov rdi, rsp        # Point rdi to the stack address containing "/flag"
    mov rsi, 0          # Set access mode to 0 (O_RDONLY / Read-Only)
    mov rax, 2          # sys_open syscall number
    syscall             # Returns custom file descriptor in rax

    # 3. Read from the opened file descriptor into memory
    mov rdi, rax        # Move the new file descriptor into rdi
    mov rsi, rsp        # Point buffer destination to stack memory (overwriting the string is fine)
    mov rdx, 128        # Request up to 128 bytes max capacity
    mov rax, 0          # sys_read syscall number
    syscall             # Returns actual bytes read in rax

    # 4. Write the captured data to stdout
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rdx, rax        # Transfer exact byte count from rax to write length (rdx)
    mov rax, 1          # sys_write syscall number
    syscall

    # 5. Clean exit with status 42
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # sys_exit syscall number
    syscall

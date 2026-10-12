# challenge: opening-files (file system traversal via `sys_open`, `sys_read`, and `sys_write`)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/hello-hackers/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / hello-hackers
* **challenge level:** extracting a file path from command-line arguments on the stack (`[rsp+16]`), opening the file via `sys_open`, reading its raw contents using the custom file descriptor, and echoing it to `stdout`
* **execution format:** custom assembly compilation (`as`, `ld`), command-line argument passing (`./solve /flag`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Command-Line Arguments via Stack (`[rsp+16]`):** When a binary is executed with arguments (e.g., `/flag`), the operating system places pointers to those strings on the stack. `[rsp+16]` points directly to the first argument string (`argv[1]`).
* **The `open` System Call (`rax = 2`):** Asks the kernel to open a file by its path pointer (`rdi`) with specific access modes (`rsi = 0` for read-only). Returns a unique **File Descriptor (FD)** starting from `3` in `rax`.
* **Custom File Descriptor Routing:** The resulting file descriptor from `sys_open` replaces `0` (stdin) in `rdi` for the subsequent `sys_read` call, seamlessly redirecting the read source from keyboard/pipes to disk files.
* **Dynamic Size Hand-off:** Capturing the actual byte count returned by `sys_read` in `rax` and passing it to `rdx` ensures only valid file contents are written out, avoiding trailing stack garbage.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Open the file passed via command-line arguments
    mov rdi, [rsp+16]   # Point rdi to the filename string address (argv[1])
    mov rsi, 0          # Set access mode to 0 (O_RDONLY / Read-Only)
    mov rax, 2          # sys_open syscall number
    syscall             # Returns custom file descriptor in rax (e.g., 3)

    # 2. Read from the opened file descriptor into memory
    mov rdi, rax        # Move the new file descriptor into rdi
    mov rsi, rsp        # Point buffer destination to stack memory (rsp)
    mov rdx, 128        # Request up to 128 bytes max capacity
    mov rax, 0          # sys_read syscall number
    syscall             # Returns actual bytes read in rax

    # 3. Write the captured data to stdout
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    # mov rsi, rsp      # Buffer pointer remains at rsp
    mov rdx, rax        # Transfer exact byte count from rax to write length (rdx)
    mov rax, 1          # sys_write syscall number
    syscall

    # 4. Clean exit with status 42
    mov rdi, 42         # Set exit status code to 42
    mov rax, 60         # sys_exit syscall number
    syscall

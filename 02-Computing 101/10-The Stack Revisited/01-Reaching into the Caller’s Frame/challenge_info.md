# challenge: reaching-into-the-callers-frame (inspecting caller stack frames and leaking data via sys_write)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/the-stack-revisited/)**

---

## 🔗 environment details

- **dojo track / module:** the-stack-revisited / reaching-into-the-callers-frame
- **challenge level:** implementing a custom shared library function in x86-64 assembly (`solve`) to index into the caller's stack frame at `[rsp + 0x40]` and write the captured flag bytes to stdout using the `sys_write` system call
- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)

---

## 🧠 core rules & mechanisms

- **Caller Frame Indexing:** When `solve` is invoked via `call`, the stack pointer (`rsp`) points to the return address pointing back to the caller. The caller's local variables reside at positive offsets from `rsp`, specifically at `[rsp + 0x40]` as defined by this challenge structure.
- **Effective Address Calculation (`lea`):** Using `lea rsi, [rsp + 0x40]` loads the exact memory address of the flag into the `rsi` register, establishing the pointer required by the `sys_write` buffer argument.
- **Write System Call (`sys_write`):** Setting file descriptor `rdi` to `1` (stdout), buffer `rsi` to `[rsp + 0x40]`, length `rdx` to `128` bytes, and syscall number `rax` to `1` correctly dumps the flag data directly to stdout[cite: 1].

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Set file descriptor to 1 (stdout)
    mov rdi, 1
    
    # 2. Load the effective address of the flag in the caller's stack frame into rsi
    lea rsi, [rsp + 0x40]
    
    # 3. Set the write length to 128 bytes
    mov rdx, 128
    
    # 4. Set syscall number to 1 (sys_write)
    mov rax, 1
    
    # 5. Invoke the system call to print the flag
    syscall

    ret

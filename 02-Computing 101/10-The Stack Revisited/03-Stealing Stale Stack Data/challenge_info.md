# challenge: stealing-stale-stack-data (leaking stale flag buffers from callee frames)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/the-stack-revisited/)**

---

## 🔗 environment details

- **dojo track / module:** the-stack-revisited / stealing-stale-stack-data
- **challenge level:** implementing a custom shared library function in x86-64 assembly (`solve`) to invoke `read_flag` via function pointer in `rdi`, load the effective address of the 128-byte stale flag buffer at `[rsp - 0x88]` using `lea`, set `rdi` to `1` (stdout), and invoke `sys_write`
- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)

---

## 🧠 core rules & mechanisms

- **Function Pointer Invocation:** The challenge passes the `read_flag` function pointer in `rdi`. Executing `call rdi` invokes it safely.
- **Stale Buffer Leakage:** After `read_flag` returns, its local 128-byte flag buffer remains intact on the stack frame below `rsp` at negative offset `[rsp - 0x88]`.
- **System Call Setup:** `sys_write` requires `rdi = 1` (stdout), `rsi = [rsp - 0x88]`, `rdx = 128`, and `rax = 1`.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Call the read_flag function pointer passed in rdi
    call rdi
    
    # 2. Load the effective address of the stale 128-byte flag buffer into rsi
    lea rsi, qword ptr [rsp-0x88]
    
    # 3. Set file descriptor to 1 (stdout)
    mov rdi, 1
    
    # 4. Set write length to 128 bytes
    mov rdx, 128
    
    # 5. Set syscall number to 1 (sys_write)
    mov rax, 1
    
    # 6. Invoke syscall to dump the flag to stdout
    syscall

    ret

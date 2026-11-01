# challenge: loading-stale-stack-data (retrieving stale stack data left behind after function calls)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/the-stack-revisited/)**

---

## 🔗 environment details

- **dojo track / module:** the-stack-revisited / loading-stale-stack-data
- **challenge level:** implementing a custom shared library function in x86-64 assembly (`solve`) to call a function pointer received in `rdi` (`load_secret`), then read and return an 8-byte stale value left on the stack at `[rsp - 0x10]` via `rax`
- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)

---

## 🧠 core rules & mechanisms

- **Function Pointer Invocation:** The challenge passes a function pointer to `load_secret` inside the `rdi` register. Executing `call rdi` invokes this routine.
- **Stale Stack Frame Residue:** When `load_secret` finishes execution and returns, it leaves behind an 8-byte stale value on its stack frame, which from `solve`'s stack perspective resides at `[rsp - 0x10]`.
- **Value Return via `rax`:** Moving the qword at `[rsp - 0x10]` into `rax` (`mov rax, qword ptr [rsp - 0x10]`) allows `solve` to return the target secret directly to the harness.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Call the load_secret function passed via the function pointer in rdi
    call rdi
    
    # 2. Retrieve the 8-byte stale value left behind on the stack at [rsp - 0x10] into rax
    mov rax, qword ptr [rsp - 0x10]
    
    # 3. Return the stale secret value
    ret

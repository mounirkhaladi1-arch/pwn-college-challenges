# challenge: writing-from-a-shared-library (compiling and exporting position-independent shared objects)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** writing a shared library function (`solve`) that accepts a buffer pointer and length via standard calling conventions, maps them to system write parameters, and outputs the flag to `stdout`
* **execution format:** shared object compilation (`as`, `ld -shared`), harness testing (`/challenge/harness /tmp/your-program.so`), and automated validation

---

## 🧠 core rules & mechanisms

* **Shared Object Export (`.global solve`):** Instead of an executable with an entry point (`_start`), shared libraries export named entry symbols (like `solve:`) linked with the `-shared` flag so external harnesses can invoke them dynamically.
* **Calling Convention vs. Syscall ABI Clash:** 
  * *Function Entry (`solve(buf, len)`):* `rdi` holds the buffer address, and `rsi` holds the length.
  * *System Call (`sys_write`):* `rdi` must hold the file descriptor (`1` for stdout), `rsi` must hold the buffer address, and `rdx` must hold the write length.
* **Register Juggling & Timing:** Because parameters arrive in `rdi` and `rsi` while `sys_write` demands a specific layout (`rdi`, `rsi`, `rdx`), timing and register routing order are critical to prevent overwriting data before it's safely mapped. Moving `rsi` to `rdx` *before* modifying `rdi` prevents data clobbering.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Remap incoming function arguments to sys_write ABI registers
    # Incoming: rdi = buffer pointer, rsi = length
    # Target sys_write: rdi = fd (1), rsi = buffer pointer, rdx = length
    
    mov rdx, rsi        # Move length from rsi into rdx (write size)
    mov rsi, rdi        # Move buffer pointer from rdi into rsi (write buffer)
    mov rdi, 1          # Set file descriptor to 1 (stdout)
    mov rax, 1          # sys_write syscall number
    syscall

    # 2. Clean exit back to the harness runner
    xor rdi, rdi        # Set exit/return code to 0
    mov rax, 60         # sys_exit syscall number
    syscall

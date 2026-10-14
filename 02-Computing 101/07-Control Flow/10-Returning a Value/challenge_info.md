# challenge: returning-a-value (returning data via standard calling convention return registers)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** implementing a shared library function (`solve`) that receives a random 64-bit secret as an argument and returns it unchanged to the calling harness via the standard function return register (`rax`)
* **execution format:** shared object compilation (`as`, `ld -shared`), harness testing with simulated inputs (`/challenge/harness /tmp/your-program.so <secret>`), and automated validation

---

## 🧠 core rules & mechanisms

* **Function Arguments (`rdi`):** Under standard System V AMD64 ABI calling conventions, the first argument passed to a function lands in `rdi`. Here, the harness passes a random 64-bit secret directly into `solve(secret)`.
* **Return Values (`rax`):** Functions return scalar values (integers, pointers) back to their callers by placing the result into the `rax` register before returning.
* **The `ret` Instruction:** Unlike standalone programs that terminate via a `sys_exit` syscall (`mov rax, 60; syscall`), shared library functions return control back to the calling process using the `ret` instruction, popping the return address off the stack and jumping back to the harness.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Move the incoming argument (secret in rdi) into the return register (rax)
    mov rax, rdi
    
    # 2. Return control back to the calling harness
    ret

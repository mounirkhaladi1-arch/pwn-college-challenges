# challenge: saving-callee-saved-registers (preserving non-volatile registers under ABI conventions)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** implementing a shared library function (`solve`) that preserves incoming callee-saved registers (`rbx`, `rbp`, `r12`, `r13`, `r14`, `r15`), safely utilizes them to perform work (loading `0x1337`), and restores the caller's original register values before returning
* **execution format:** shared object compilation (`as`, `ld -shared`), harness testing (`/challenge/harness /tmp/your-program.so`), and automated validation

---

## 🧠 core rules & mechanisms

* **Callee-Saved (Non-Volatile) Registers:** Under standard System V AMD64 ABI conventions, registers like `rbx`, `rbp`, and `r12` through `r15` belong to the caller. If a callee (your function) modifies them, it **must** restore their exact original values before returning.
* **Preservation via Stack Pushes:** By pushing the incoming callee-saved registers onto the stack at the start of `solve`, their original values are locked in place.
* **Stack Cleanup & Restoration (LIFO):** After performing local operations (such as populating the registers with `0x1337` for the checker callback), popping them back off the stack in reverse order restores the caller's environment completely transparently.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Save the caller's original callee-saved registers onto the stack
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15

    # 2. Perform work: load the required value (0x1337) into all callee-saved registers
    mov r15, 0x1337
    mov r14, 0x1337
    mov r13, 0x1337
    mov r12, 0x1337
    mov rbx, 0x1337
    mov rbp, 0x1337

    # 3. Call the check function (passed in rdi)
    call rdi

    # 4. Restore the caller's original register values in strict reverse order (LIFO)
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx

    # 5. Return cleanly back to the harness
    ret

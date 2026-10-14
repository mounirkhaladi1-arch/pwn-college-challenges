# challenge: saving-caller-saved-registers (preserving volatility via stack push/pop preservation)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** implementing a shared library function (`solve`) that receives a clobber function (`rdi`) and a flag printer (`rsi`), preserves live caller-saved registers (`rax`, `rcx`, `rdx`, `r8`, `r9`, `r10`, `r11`) across the destructive call, and invokes the flag function
* **execution format:** shared object compilation (`as`, `ld -shared`), harness execution (`/challenge/harness /tmp/your-program.so`), and automated validation

---

## 🧠 core rules & mechanisms

* **Caller-Saved vs. Callee-Saved Registers:** Under System V AMD64 ABI guidelines, caller-saved registers (`rax`, `rcx`, `rdx`, `rsi`, `rdi`, `r8`-`r11`) can be freely overwritten by any subroutine called. If data must survive across a function call, the *caller* is responsible for saving them.
* **Stack Preservation via `push` and `pop`:** Storing registers onto the stack (`push`) before executing a potentially destructive function (`call rdi`) and restoring them in reverse order (`pop`) ensures live values remain intact.
* **LIFO Stack Discipline (Last-In, First-Out):** Because the stack operates on LIFO ordering, registers must be popped back in exact reverse order of how they were pushed. Pushing `rsi`, `rax`, `rcx`, etc., means popping them backwards (`r11`, `r10`, ..., `rsi`) to match stack alignment.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Save live caller-saved registers (plus arguments needed later) onto the stack
    push rsi
    push rax
    push rcx
    push rdi
    push rdx 
    push r8
    push r9 
    push r10
    push r11

    # 2. Call the clobber function (rdi), which deliberately overwrites caller-saved registers
    call rdi

    # 3. Restore registers from the stack in strict reverse order (LIFO)
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdx
    pop rdi
    pop rcx
    pop rax 
    pop rsi

    # 4. Call the flag-printing function (now safely preserved in rsi)
    call rsi

    # 5. Return cleanly back to the harness
    ret

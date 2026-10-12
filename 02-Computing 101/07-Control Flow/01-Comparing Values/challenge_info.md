# challenge: comparing-values (conditional evaluation using `cmp` and `setz`)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** comparing argument count (`argc` located at `[rsp]`) against an immediate value (`42`) using `cmp`, evaluating conditional status with `setz`, and returning the result as the exit code
* **execution format:** custom assembly compilation (`as`, `ld`), command-line argument passing (`./solve ...`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **`argc` Location on Stack:** When a binary executes, the very top of the stack (`[rsp]`) holds the argument count (`argc`), representing how many command-line parameters were provided.
* **The `cmp` Instruction:** Subtracts the source operand from the destination operand (`destination - source`) without storing the result, but updates the CPU status flags (such as Zero Flag, Carry Flag, etc.) based on the outcome.
* **The `setz` Instruction:** Sets an 8-bit register (like `dil`) to `1` if the Zero Flag is set (meaning the comparison resulted in equality, i.e., `argc == 42`), or `0` otherwise.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Compare argc (stored at [rsp]) against the immediate value 42
    cmp word ptr [rsp], 42
    
    # 2. Set dil to 1 if equal (zero flag set), 0 otherwise
    setz dil
    
    # 3. Exit with the comparison result as the exit status code
    mov rax, 60         # sys_exit syscall number
    syscall

# challenge: writing-loops (implementing dynamic string length calculation via loops)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** calculating the dynamic length of `argv[1]` by iterating through memory byte-by-byte until a null terminator (`0`) is hit, utilizing loop labels, conditional jumps, and an accumulator counter
* **execution format:** custom assembly compilation (`as`, `ld`), multi-argument string testing (`./solve pwn`, `./solve 'two words'`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Pointer Iteration (`inc rdx`):** Moving through a string in memory requires advancing the memory address pointer itself byte-by-byte rather than just the value inside it.
* **Accumulator Register (`rsi`):** Using a dedicated register (`rsi`) initialized to zero (`xor rsi, rsi`) to track the character count, incrementing it (`inc rsi`) on every successful loop iteration before hitting a null byte.
* **Loop Termination (`je exit`):** Checking the dereferenced byte `cmp byte ptr [rdx], 0` ensures the loop halts gracefully the exact moment the string ends, passing the final length into `rdi` for the exit code.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Initialize character counter (rsi = 0)
    xor rsi, rsi

    # 2. Load argv[1] pointer into rdx
    mov rdx, [rsp+16]

loop:
    # 3. Check if current byte is the null terminator (0)
    cmp byte ptr [rdx], 0
    je exit             # If null byte reached, break out of loop

    # 4. Advance pointer and increment counter
    inc rdx             # Move to the next character address
    inc rsi             # Increment length counter
    jmp loop            # Repeat loop

exit:
    # 5. Move total length into rdi and exit
    mov rdi, rsi        # rdi = calculated string length
    mov rax, 60         # sys_exit syscall number
    syscall

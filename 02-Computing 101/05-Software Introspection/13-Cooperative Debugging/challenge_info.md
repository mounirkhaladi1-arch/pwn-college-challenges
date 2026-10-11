# challenge: cooperative-debugging (cooperative debugging via software breakpoints)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/introspecting/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / introspecting
* **challenge level:** implementing cooperative debugging by triggering software breakpoints (`int3`) from custom assembly
* **execution format:** custom assembly compilation (`as`, `ld`), interactive testing (`gdb`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Cooperative vs. Preemptive Debugging:** Unlike preemptive debugging where a debugger forces a program to start paused (`starti`), cooperative debugging allows the binary itself to signal when it wants to pause execution.
* **The `int3` Instruction:** A software breakpoint instruction (opcode `0xCC`). When a program executes `int3` while attached to a debugger or checker script, it triggers a trap, pausing execution and handing control smoothly over to the debugger. Running outside a debugger causes a `Trace/breakpoint trap` and terminates.
* **Checker Logic:** The automated checker runs the compiled binary under GDB, hits the `int3` breakpoint, inspects `$rdi` to ensure it equals `1337`, and issues the flag upon success.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    mov rdi, 1337
    int3
    mov rax, 60         # exit syscall code
    syscall

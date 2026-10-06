# challenge: stored addresses

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/memory/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** 06 - stored addresses
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this file contains a basic text-based layout designed for static evaluation. the goal is to load a custom status parameter into the primary argument register by tracing an intermediate pointer address nested within another absolute memory address.

---

## 🛠️ technical implementation
* **source syntax:** executes a two-stage memory loading sequence by fetching a target memory coordinate pointer from address `567800` into `rdi`, then dereferencing that register `[rdi]` to extract the literal numeric data payload:
  ```assembly
  mov rdi,
  mov rdi, [rdi]
  mov rax, 60
  syscall
  ```
* **verification workflow:** these source lines are not compiled into a standalone engine here. instead, the text buffer is parsed directly by the platform's verification scripts:
  ```bash
  /challenge/check solve.s
  ```

# challenge: exit codes

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/your-first-program/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** your first program
* **challenge level:** 03 - exit codes
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this file contains a basic text-based layout designed for static evaluation. the goal is to load a custom status parameter into the primary argument register before the execution flow reaches the exit block.

---

## 🛠️ technical implementation
* **source syntax:** moves the status value `42` into `rdi`, sets `rax` to `60`, and writes the exit execution statement:
  ```assembly
  mov rdi, 42
  mov rax, 60
  syscall
  ```
* **verification workflow:** these source lines are not compiled into a standalone engine here. instead, the text buffer is parsed directly by the platform's verification scripts:
  ```bash
  /challenge/check solve.s
  ```

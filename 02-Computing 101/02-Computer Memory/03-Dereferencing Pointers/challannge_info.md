# challenge: dereferencing pointers

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/memory/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** 03 - dereferencing pointers
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this file contains a basic text-based layout designed for static evaluation. the goal is to load a custom status parameter into the primary argument register by dereferencing a target base tracking register.

---

## 🛠️ technical implementation
* **source syntax:** implements register-indirect addressing by wrapping the register pointer in brackets `[rax]` to dereference its internal data address directly into `rdi`:
  ```assembly
  .intel_syntax noprefix
  .global _start

  _start:
  mov rdi, [rax] # dereferences the pointer inside rax to pull the secret exit status
  mov rax, 60    # exit system call code (sys_exit)
  syscall
  ```
* **verification workflow:** these source lines are not compiled into a standalone engine here. instead, the text buffer is parsed directly by the platform's verification scripts:
  ```bash
  /challenge/check solve.s
  ```

# challenge: dereferencing with offsets

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/memory/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** 05 - dereferencing with offsets
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this file contains a basic text-based layout designed for static evaluation. the goal is to load a custom status parameter into the primary argument register by dereferencing a base tracking register using a fixed displacement offset.

---

## 🛠️ technical implementation
* **source syntax:** implements displacement-indirect addressing by adding a static boundary layer numeric value directly to the tracking register within the brackets `[rdi+8]` to point further into memory:
  ```assembly
  mov rdi, [rdi+8]
  mov rax, 60
  syscall
  ```
* **verification workflow:** these source lines are not compiled into a standalone engine here. instead, the text buffer is parsed directly by the platform's verification scripts:
  ```bash
  /challenge/check solve.s
  ```

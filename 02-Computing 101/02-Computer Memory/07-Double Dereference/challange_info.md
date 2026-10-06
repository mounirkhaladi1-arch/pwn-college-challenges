# challenge: double dereference

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/memory/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** 07 - double dereference
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this file contains a basic text-based layout designed for static evaluation. the goal is to load a custom status parameter into the primary argument register by executing a multi-stage pointer traversal tracking chain that resolution routes through nested register structures.

---

## 🛠️ technical implementation
* **source syntax:** performs a sequential multi-stage dereferencing sequence by extracting `secret_location_1` from the dynamic address inside `[rax]`, followed by a final memory read `[rdi]` to parse the underlying literal `secret_value` payload data into the process exit channel:
  ```assembly
  mov rdi, [rax]
  mov rdi, [rdi]
  mov rax, 60
  syscall
  ```
* **verification workflow:** these source lines are not compiled into a standalone engine here. instead, the text buffer is parsed directly by the platform's verification scripts:
  ```bash
  /challenge/check solve.s
  ```

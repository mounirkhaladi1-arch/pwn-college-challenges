# challenge: moving between registers

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/your-first-program/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** your first program
* **challenge level:** 05 - moving between registers
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this challenge introduces register-to-register data transfers. the system automatically pre-populates a hidden dynamic value into a specific tracking register. the objective is to safely copy this tracking state into the destination argument register without breaking system conventions.

---

## 🛠️ technical implementation
* **source syntax:** references the standard headers if manually generating a standalone execution file, or presents the pure logical instruction path to overwrite the exit code register dynamically:
  ```assembly
  mov rdi, rsi # copies the dynamically initialized secret state from rsi into rdi
  mov rax, 60  # exit syscall code
  syscall
  ```
* **verification workflow:** the platform's evaluation wrapper dynamically configures the initial target state within `rsi` before executing and analyzing your source lines:
  ```bash
  /challenge/check solve.s
  ```

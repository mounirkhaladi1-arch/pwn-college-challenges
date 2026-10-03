# challenge: building executables

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/your-first-program/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** your first program
* **challenge level:** 04 - building executables
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this file contains a structured assembly text layout designed to teach manual binary compilation workflows. unlike previous tasks, this challenge transitions away from running the script parameters raw through the checker, and requires linking an executable binary block.

---

## 🛠️ technical implementation
* **source syntax:** defines the standard dialect header `.intel_syntax noprefix`, registers the globally visible entry pointer `.global _start`, and sets the status logic:
  ```assembly
  .intel_syntax noprefix  
  .global _start

  _start:
  mov rdi, 42 # setting exit code to 42 (echo $?= 42) 
  mov rax, 60 # exit syscall code 
  syscall
  ```
* **verification workflow:** instead of passing the raw `.s` source buffer alone, the system check script evaluates the final compiled output file:
  ```bash
  /challenge/check program
  ```

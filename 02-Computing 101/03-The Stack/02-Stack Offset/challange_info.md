# challenge: the stack

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/the-stack/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** 08 - the stack
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism

this challenge explores reading values from the stack at a specific offset using the stack pointer register (`rsp`). instead of reading directly from the top of the stack, we access data located further down by adding an offset (128 bytes) to `rsp` to load the target value into the exit status register.

---

## 🛠️ technical implementation

* **source syntax:** reads a qword from the stack at an offset of 128 bytes from `rsp` into `rdi`, sets the syscall number for exit (`60`) in `rax`, and triggers the syscall:
  ```assembly
  .intel_syntax noprefix
  .global _start

  _start:
      mov rdi, [rsp + 128] # get the value from the stack at an offset of 128 bytes
      mov rax, 60          # exit syscall code
      syscall              # make the syscall

# challenge: popping from the stack

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/the-stack/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** the stack
* **challenge level:** popping from the stack
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism

this challenge explores the core behavior of stack memory operations using the `pop` instruction. while previous levels read stack data using direct memory dereferencing (`mov`), this level requires popping values off the stack directly. executing `pop rdi` retrieves the `argc` value stored at `[rsp]` while automatically adjusting the stack pointer, satisfying the 3-instruction limit requirement to exit with the argument count.

---

## 🛠️ technical implementation

* **source syntax:** pops the argument count off the top of the stack into `rdi`, sets `rax` to the exit syscall number (`60`), and invokes the kernel:
  ```assembly
  .intel_syntax noprefix
  .global _start

  _start:
      pop rdi     # pop argc from the top of the stack into rdi
      mov rax, 60 # exit syscall code
      syscall     # make the syscall

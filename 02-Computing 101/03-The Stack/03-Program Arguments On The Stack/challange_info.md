# challenge: stack double dereference / offset

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/memory/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** memory / stack double offset dereference
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism

this challenge combines stack offset indexing with multi-stage pointer dereferencing. instead of reading directly from the top of the stack, it targets a pointer stored at an offset of 16 bytes (`[rsp+16]`), and then performs a second-stage memory dereference (`[rdi]`) to retrieve the actual target value, passing it into the exit code channel.

---

## 🛠️ technical implementation

* **source syntax:** we load a pointer from `rsp + 16` into `rdi`, dereference `rdi` to get the final target value, set the exit syscall number (`60`) in `rax`, and trigger the syscall:
  ```assembly
  .intel_syntax noprefix
  .global _start

  _start:
      mov rdi, [rsp+16] # get pointer from stack offset 16
      mov rdi, [rdi]    # dereference pointer to load final value
      mov rax, 60       # exit syscall code
      syscall           # make the syscall

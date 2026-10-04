# challenge: accessing memory

## 🛠️ quick access
👉 **[direct link to challenge] ( https://pwn.college/computing-101/memory/ )**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** 01 - accessing memory
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this challenge introduces direct memory addressing. the platform initializes a secret dynamic numeric integer value inside a specific absolute location memory slot. the objective is to read the data residing at that pointer coordinate and move it into the process return execution channel.

---

## 🛠️ technical implementation
* **source syntax:** utilizes bracket notation `[...]` to treat the target numerical value as an absolute memory pointer address offset instead of an immediate value:
  ```assembly
  .intel_syntax noprefix
  .global _start

  _start:
  mov rdi, [133700] # dereferences address 133700 to pull the hidden numerical constant
  mov rax, 60       # loads the standard sys_exit identifier
  syscall
  ```

### ⚙️ compilation & verification workflow
build the assembly code using standard compiler paths and submit the final linked executable binary module parameters to the check script:
```bash
as -o solve.o solve.s
ld -o solve solve.o
/challenge/check solve
```

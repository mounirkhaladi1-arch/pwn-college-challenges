# challenge: loading from memory

## 🛠️ quick access
👉 **[direct link to challenge](https://pwn.college/computing-101/memory/)**

---

## 🔗 environment details
* **dojo track:** computing 101
* **module:** computer memory
* **challenge level:** 02 - loading from memory
* **core solution file:** `solve.s`

---

## 🧠 challenge context & mechanism
this challenge reinforces direct memory addressing constraints with a variable coordinate offset. the platform alters the location of the hidden state parameter to a new memory offset slot. the objective is to read the data residing at this updated pointer coordinate.

---

## 🛠️ technical implementation
* **source syntax:** utilizes bracket notation `[...]` to dereference the new absolute tracking coordinates `123400` directly into the return status register:
  ```assembly
  .intel_syntax noprefix
  .global _start

  _start:
  mov rdi, [123400] # dereferences absolute memory pointer to load the secret data constant
  mov rax, 60       # loads the standard sys_exit execution number
  syscall
  ```

### ⚙️ compilation & verification workflow
build the source script using standard assembly tools within the terminal workspace environment and execute validation verification loops:
```bash
as -o solve.o solve.s
ld -o solve solve.o
/challenge/check solve
```

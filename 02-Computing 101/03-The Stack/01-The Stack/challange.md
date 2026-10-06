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

this challenge explores process initialization stack structures where `rsp` (the stack pointer) initially references runtime metadata passed by the operating system[cite: 1]. upon binary execution, `[rsp]` directly stores the command-line argument count (`argc`)[cite: 1]. the target mechanism requires extracting this dynamic integer value directly from `[rsp]` and using it to populate the primary exit code channel[cite: 1].

---

## 🛠️ technical implementation

* **source syntax:** dereferences the stack pointer register `[rsp]` to retrieve the active argument count `argc` directly into `rdi`, before triggering the standard kernel exit termination routine via `sys_exit` (`60`)[cite: 1]:
  ```assembly
  mov rdi, [rsp]
  mov rax, 60
  syscall

# Challenge: Your First Syscall

## 🛠️ Quick Access
👉 **[Direct Link to Challenge](https://pwn.college/computing-101/your-first-program/)**

---

## 🔗 Environment Details
* **Dojo Track:** Computing 101
* **Module:** Your First Program
* **Challenge Level:** 02 - Your First Syscall
* **Core Solution File:** `solve.s`

---

## 🧠 Challenge Context & Progressive Evolution
This exercise expands on basic register manipulation by introducing direct core operating system interactions. The objective is to transition from static memory loading into active software execution control, preventing process crashes by implementing a manual termination routine.

---

## 🛠️ Technical Implementation & Logic Flow
* **Instruction Execution:** Moves the immediate system call identifier `60` (corresponding to `sys_exit` in the Linux kernel) into the `rax` register, followed by the execution command:
  ```assembly
  mov rax, 60
  syscall # invoke exit system call (sys_exit) to terminate cleanly
  ```
* **Verification Command:** To evaluate the source logic layout directly within the official environment sandbox workspace, execute the testing suite framework parameters:
  ```bash
  /challenge/check solve.s
  ```

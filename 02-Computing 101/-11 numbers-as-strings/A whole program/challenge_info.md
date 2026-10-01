# Challenge Documentation: A Whole Program (Numbers as Strings)

This directory contains my low-level solution and validation layout for the **A Whole Program** challenge, which serves as the final integration stage of the **Numbers as Strings** module on the pwn.college platform.

## 🔗 Official References
* **Platform:** [pwn.college](https://pwn.college)
* **Module:** Numbers as Strings
* **Challenge Name:** A Whole Program
* **Core Solution File:** `solve.s`

---

## 🧠 Challenge Context & Progressive Evolution
This challenge marks a major architectural shift in the module. Previously, the exercises required writing functions packaged inside loadable shared libraries (`.so`). In this challenge, we transition into writing a **complete, standalone executable** that starts execution directly from the global entry point **`_start`** and manages its own system termination.

---

## 🛠️ Technical Implementation & Logic Flow
The program reads a text representation of a number passed as a command-line argument, converts it into a raw integer using an `atoi` algorithm, and returns the value via the program's shell exit code.

### Core Execution Stages in `solve.s`:
1. **Stack Argument Parsing:** Upon initialization, the program retrieves the target string pointer directly from the execution stack at offset `[rsp + 16]` (`argv[1]`), avoiding high-level library abstraction.
2. **Signed Value Handling:** The logic checks the first byte for a leading minus sign (`-` / `0x2d`). If detected, it advances the pointer past the sign and flags the total for a final negation via `neg` or `imul rax, -1`.
3. **Unsigned Boundary Loop:** Iterates character-by-character through memory, executing a continuous conversion loop:
   * Employs an unsigned boundary check (`ja`) to immediately stop processing upon hitting any non-digit character (including spaces, letters, or `0x00`), allowing messy or un-terminated inputs to be handled cleanly.
   * Normalizes ASCII digits to literal numeric values (`sub rbx, 0x30`).
   * Scales the running total by a base-10 shift (`imul rax, 10`) and appends the new digit.
4. **System Exit Handler:** Because this is a full standalone program, the final numeric output is passed directly to the `rdi` register as the program's return status, and execution is halted safely via a direct Linux system call (`syscall` 60). Since shell exit codes are a single byte, the input values fall strictly between `0` and `255`.

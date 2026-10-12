# challenge: conditional-control-flow (branching execution using `jne` and labels)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** implementing dynamic execution paths using comparison (`cmp`) and conditional jumps (`jne`), routing the program to distinct success and failure exit blocks based on user input
* **execution format:** custom assembly compilation (`as`, `ld`), command-line argument testing (`./solve pwn` vs `./solve abc`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Conditional Jumps (`jne` / `je`):** Inspects CPU status flags (specifically the Zero Flag set by `cmp`) to alter the instruction pointer (`rip`). `jne` (Jump if Not Equal) takes the branch if the comparison values differ; otherwise, it "falls through" to the next sequential instruction.
* **Code Labels (`label:`):** Symbolic placeholders resolved by the assembler into absolute memory offsets. They allow jump instructions to target specific code blocks without hardcoding fragile memory addresses.
* **Execution Path Separation:** Structuring code so that the "success" path falls through sequentially while error or alternate paths are branched around or jumped to prevents linear code bottlenecks.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Load the pointer to argv[1] and compare its first byte against 'p'
    mov rax, [rsp+16]
    cmp byte ptr [rax], 'p'
    
    # 2. Branch to the 'fail' label if the character is not equal to 'p'
    jne fail

    # 3. Fall-through Success Path (exit code 0)
    xor rdi, rdi        # Clear rdi (rdi = 0 for successful execution)
    mov rax, 60         # sys_exit syscall number
    syscall

fail:
    # 4. Alternative Failure Path (exit code 1)
    mov rdi, 1          # Set exit status code to 1 (failure)
    mov rax, 60         # sys_exit syscall number
    syscall

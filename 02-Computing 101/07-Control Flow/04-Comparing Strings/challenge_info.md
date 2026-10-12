# challenge: comparing-strings (multi-byte string matching with chained conditional jumps)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** evaluating a multi-character string argument (`argv[1]` pointing to `"pwn"`) byte-by-byte using indexed pointer offsets (`[rax]`, `[rax+1]`, `[rax+2]`) and shared conditional jump failure handling
* **execution format:** custom assembly compilation (`as`, `ld`), command-line argument testing (`./solve pwn` vs `./solve pan`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Contiguous String Layout in Memory:** Strings in memory are stored as a sequence of adjacent bytes. The base pointer (`rax`) holds the address of the first character (`offset 0`), while `rax+1` and `rax+2` address the subsequent characters.
* **Chained Conditional Validation:** By performing multiple sequential `cmp` instructions followed immediately by `jne fail`, execution is short-circuited. The moment a single byte mismatch occurs, the CPU abandons further checks and instantly branches to the failure block.
* **Shared Error Routing:** Directing all mismatch checks to the same `fail` label keeps code compact and prevents redundant error handling blocks.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Load pointer to argv[1]
    mov rax, [rsp+16]
    
    # 2. Check first character ('p')
    cmp byte ptr [rax], 'p'
    jne fail

    # 3. Check second character ('w')
    cmp byte ptr [rax+1], 'w'
    jne fail

    # 4. Check third character ('n')
    cmp byte ptr [rax+2], 'n'
    jne fail

    # 5. Success Path: All characters matched (exit code 0)
    xor rdi, rdi        # Clear rdi (rdi = 0)
    mov rax, 60         # sys_exit syscall number
    syscall

fail:
    # 6. Failure Path: Mismatch detected at any point (exit code 1)
    mov rdi, 1          # Set exit status code to 1
    mov rax, 60         # sys_exit syscall number
    syscall

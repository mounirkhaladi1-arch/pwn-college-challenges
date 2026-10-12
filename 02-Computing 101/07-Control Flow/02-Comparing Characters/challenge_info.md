# challenge: comparing-characters (pointer dereferencing and byte-level condition checks)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** fetching a command-line argument pointer (`argv[1]` at `[rsp+16]`), dereferencing it to access its leading character, comparing it against an immediate ASCII byte (`'p'`), and returning the conditional result
* **execution format:** custom assembly compilation (`as`, `ld`), command-line string argument passing (`./solve pwn`), and automated validation (`/challenge/check`)

---

## 🧠 core rules & mechanisms

* **Pointer Retrieval (`[rsp+16]`):** As explored in file I/O, `[rsp+16]` contains the memory address pointing to the start of the first command-line argument string (`argv[1]`). Moving this into a general-purpose register like `rax` provides a working base pointer.
* **Byte Dereferencing (`byte ptr [rax]`):** Since strings are arrays of bytes in memory, wrapping the pointer register in brackets with `byte ptr` allows the CPU to fetch just the single first character (`1 byte`) rather than an entire 8-byte word.
* **ASCII Character Literals:** Using `'p'` directly in instructions allows the assembler to automatically translate the character into its underlying hexadecimal ASCII value (`0x70`), keeping code readable without manual hex conversion.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global _start

_start:
    # 1. Load the pointer to argv[1] into rax
    mov rax, [rsp+16]
    
    # 2. Compare the first byte of the string against the character 'p'
    cmp byte ptr [rax], 'p'
    
    # 3. Set dil to 1 if equal (zero flag set), 0 otherwise
    setz dil
    
    # 4. Exit with the comparison result as the exit code
    mov rax, 60         # sys_exit syscall number
    syscall

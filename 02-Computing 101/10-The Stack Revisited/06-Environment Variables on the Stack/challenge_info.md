# Challenge Documentation: `environment-variables-on-the-stack`

## 🛠️ Challenge Overview & Target Track
- **Module:** `the-stack-revisited` (`computing-101`)
- **Challenge Name:** `environment-variables-on-the-stack`
- **Objective:** Analyze and parse the initial stack layout of a standalone ELF executable to locate, extract, and write out the `FLAG` environment variable from `envp[0]`.

---

## 🔬 Low-Level Mechanics & Stack Anatomy

When the Linux kernel executes a program, it constructs an initial stack layout above the stack pointer (`rsp`) before handing control to the entry point (`_start`). In a scenario where the program is invoked with no arguments (`argc = 1`, `argv[0] = program_name`) and a single environment variable (`FLAG`), the stack layout is strictly structured as follows:

```text
     Address    │ Contents
   +────────────────────────+
   │ rsp + 0    │ 1         │ ◀─── argc
   +────────────────────────+
   │ rsp + 8    │ Pointer   │ ◀─── argv[0] (Path to executable)
   +────────────────────────+
   │ rsp + 16   │ 0 (NULL)  │ ◀─── End of argv array
   +────────────────────────+
   │ rsp + 24   │ Pointer   │ ◀─── envp[0] (Points to "FLAG=...")
   +────────────────────────+
   │ rsp + 32   │ 0 (NULL)  │ ◀─── End of envp array
   +────────────────────────+
```

### Key Technical Takeaways:
1. **Null-Terminated Pointer Arrays:** Both `argv` and `envp` are arrays of 64-bit pointers terminated by a `NULL` (`0`) pointer.
2. **Environment Variable Format:** Entries in `envp` point to null-terminated strings formatted as `NAME=VALUE` (e.g., `FLAG=pwn.college{...}`).
3. **Direct Memory Access:** Because `envp[0]` pointer is deterministically located at `[rsp + 24]` under this execution context, dereferencing `[rsp + 24]` yields the exact memory address of the `FLAG` string without needing iterative pointer walking.

---

## 💻 Complete Source Implementation (`solve.s`)

```assembly
.intel_syntax noprefix
.global _start

_start:
    # 1. Write the environment variable string (pointed to by envp[0] at [rsp + 24]) to stdout
    mov rdi, 1             # File descriptor: stdout (1)
    mov rsi, [rsp + 24]    # Pointer to envp[0] ("FLAG=...")
    mov rdx, 140           # Length of bytes to write (padded buffer size)
    mov rax, 1             # System call: sys_write
    syscall

    # 2. Clean process exit
    xor rdi, rdi           # Exit code: 0 (Success)
    mov rax, 60            # System call: sys_exit
    syscall
```

---

## 🚀 Build, Link & Validation Workflow

```bash
# 1. Assemble source into object file
as -o solve.o solve.s

# 2. Link object file into standalone executable
ld -o solve solve.o

# 3. Run official challenge checker against the binary
/challenge/check solve
```

# challenge: using-your-own-frame (processing buffers and counting distinct bytes in a custom stack frame)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/the-stack-revisited/)**

---

## 🔗 environment details

- **dojo track / module:** the-stack-revisited / using-your-own-frame
- **challenge level:** implementing a shared library function `solve(char *buffer, size_t length)` in x86-64 assembly that allocates a 256-byte scratch table on the stack, clears it to zero, uses each buffer byte as an index to mark presence (`1`), and scans the table to return the exact count of distinct byte values in `rax`.
- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)

---

## 🧠 core rules & mechanisms

- **Three-Phase Loop Architecture:**
  1. **Clear Loop:** Iterates from `0` to `255`, clearing all 256 stack scratch slots to `0`.
  2. **Mark Loop:** Iterates through the input buffer (`rdi` with length `rsi`), loads each byte value, and writes `1` to `[rsp + byte_value]` to collapse duplicates automatically.
  3. **Count Loop:** Scans all 256 table slots, accumulates marked slots (`1`), and returns the final distinct count in `rax`.
- **Register Preservation:** Preserving argument pointers (`rdi`, `rsi`) into callee-safe or temporary registers (`r8`, `r9`) prevents clobbering during execution.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix
.global solve

solve:
    # 1. Save input arguments and allocate 256-byte stack frame
    mov r8, rdi         # r8 = buffer pointer
    mov r9, rsi         # r9 = buffer length
    sub rsp, 256        # reserve scratch table

    # ==========================================
    # LOOP 1: Clear scratch table to 0
    # ==========================================
    xor rcx, rcx
clear_loop:
    mov byte ptr [rsp + rcx], 0
    cmp rcx, 255
    je clear_done
    inc rcx
    jmp clear_loop
clear_done:

    # ==========================================
    # LOOP 2: Scan buffer and mark slots
    # ==========================================
    xor rcx, rcx        # rcx = buffer index counter

mark_loop:
    cmp rcx, r9
    jge mark_done

    # Load current byte from input buffer into rax (value from 0 to 255)
    movzx rax, byte ptr [r8 + rcx]

    # Mark presence in our stack table at [rsp + byte_value]
    mov byte ptr [rsp + rax], 1

    inc rcx
    jmp mark_loop
mark_done:

    # ==========================================
    # LOOP 3: Count marked slots
    # ==========================================
    xor rcx, rcx        # rcx = table index (0 to 255)
    xor rax, rax        # rax = distinct byte counter

count_loop:
    cmp rcx, 256
    jge done_count

    # Check if this table slot is marked (1)
    cmp byte ptr [rsp + rcx], 1
    jne skip_inc
    inc rax             # found a distinct byte, increment counter

skip_inc:
    inc rcx
    jmp count_loop

done_count:
    # 2. Restore stack frame and return distinct count in rax
    add rsp, 256
    ret

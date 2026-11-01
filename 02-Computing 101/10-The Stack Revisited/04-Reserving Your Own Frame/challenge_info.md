# challenge: reserving-your-own-frame (allocating, clearing, and restoring custom stack frames)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/the-stack-revisited/)**

---

## 🔗 environment details

- **dojo track / module:** the-stack-revisited / reserving-your-own-frame
- **challenge level:** implementing a custom shared library function in x86-64 assembly (`solve`) that allocates a 256-byte stack frame (`sub rsp, 256`), zeroes out all bytes from index `0` to `255` using a loop checking against `255`, restores the stack pointer (`add rsp, 256`), and returns successfully.
- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)

---

## 🧠 core rules & mechanisms

- **Frame Allocation (`sub rsp, 256`):** Reserves 256 bytes of scratch space on the stack.
- **Loop Boundary (`cmp rcx, 255` with `je done`):** Iterates precisely from `0` to `255`, ensuring every byte in the 256-byte frame is zeroed out without overflowing or triggering a segmentation fault.
- **Stack Restoration (`add rsp, 256`):** Balances the stack adjustment so `rsp` points directly back at the saved return address prior to `ret`.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Allocate 256 bytes on the stack
    sub rsp, 256
    
    # 2. Initialize loop counter to 0
    xor rcx, rcx
    
loop:
    # 3. Zero out the byte at the current stack offset
    mov byte ptr [rsp + rcx], 0
    
    # 4. Check if we have reached the last byte offset (255)
    cmp rcx, 255
    je done
    
    # 5. Increment counter and repeat loop
    inc rcx
    jmp loop

done:
    # 6. Restore rsp back to the saved return address position
    add rsp, 256
    
    # 7. Return to the caller
    ret

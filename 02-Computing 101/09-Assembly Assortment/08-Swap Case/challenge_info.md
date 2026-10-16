# challenge: swap-case (swapping letter cases in place using bitwise xor)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / swap-case

- **challenge level:** implementing a custom shared library function in x86-64 assembly (`str_swapcase`) to traverse a null-terminated string in place, flipping the case of each alphabetic character using a bitwise `xor` mask (`0x20`)

- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)


---

## 🧠 core rules & mechanisms

- **Pre-Check Termination Strategy:** Checking for the null terminator (`cmp byte ptr [rdi], 0`) before modifying the byte is vital. Performing an operation like `xor` on the null terminator (`0x00 ^ 0x20`) would corrupt it into `0x20`, preventing the loop from ever recognizing the end of the string and resulting in an infinite loop or segmentation fault.

- **Case Flipping via Bitwise XOR:** Uppercase and lowercase ASCII letters differ precisely by the 6th bit (`0x20`). Applying a bitwise `xor` operation with `0x20` (`xor byte ptr [rdi], 0x20`) toggles this bit—converting uppercase letters to lowercase and lowercase letters to uppercase simultaneously.

- **Pointer Increment:** Advancing the pointer (`inc rdi`) moves the execution to the next byte in the string before jumping back to the loop start.


---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global str_swapcase

str_swapcase:
loop:
    # 1. Check for the null terminator first to prevent corrupting 0x00 and causing an infinite loop
    cmp byte ptr [rdi], 0
    je done
    
    # 2. Toggle the 6th bit to swap character case in place
    xor byte ptr [rdi], 0x20
    
    # 3. Advance the string pointer to the next character
    inc rdi
    
    # 4. Repeat loop for the next byte
    jmp loop

done:
    ret

# challenge: uppercase-a-string (walking and converting strings in place in assembly)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / uppercase-a-string

- **challenge level:** implementing a custom shared library function in x86-64 assembly (`str_upper`) to traverse a null-terminated string in place, applying a bitwise mask (`0xdf`) to convert lowercase ASCII characters to uppercase

- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)


---

## 🧠 core rules & mechanisms

- **In-Place String Traversal:** The function receives a pointer to the string in `rdi`. By operating on `byte ptr [rdi]`, the code reads and modifies characters directly in memory without causing segmentation faults.

- **Uppercase Conversion via Bitwise AND:** Lowercase letters (`a`-`z`, `0x61`-`0x7a`) and uppercase letters (`A`-`Z`, `0x41`-`0x5a`) differ by the 6th bit (`0x20`). Applying a bitwise `and` operation with `0xdf` (`and byte ptr [rdi], 0xdf`) clears the 6th bit, forcing any lowercase character to uppercase.

- **Null Terminator Termination:** The loop checks the current byte value (`cmp byte ptr [rdi], 0`) to detect the end of the string (`\0`), exiting the loop cleanly via `je done`. Advancing the pointer (`inc rdi`) moves to the next character.


---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global str_upper

str_upper:
loop:
    # 1. Clear the 6th bit to convert lowercase to uppercase in place
    and byte ptr [rdi], 0xdf
    
    # 2. Check if we have reached the null terminator (0x0)
    cmp byte ptr [rdi], 0
    je done
    
    # 3. Advance the string pointer to the next character
    inc rdi
    
    # 4. Repeat loop for the next byte
    jmp loop

done:
    ret

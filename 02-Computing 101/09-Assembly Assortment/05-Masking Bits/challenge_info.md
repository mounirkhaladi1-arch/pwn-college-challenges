# challenge: masking-bits (extracting the low byte using bitwise and)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / masking-bits

- **challenge level:** implementing a custom shared library function in x86-64 assembly (`LOBYTE`) to isolate the lowest 8 bits of a 64-bit integer using a bitwise mask (`0xff`)

- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)


---

## 🧠 core rules & mechanisms

- **Low Byte Masking via `and`:** Using a bitwise `and` operation with a mask of `0xff` (`and rdi, 0xff`) clears all upper bits while preserving only the lowest 8 bits (one byte) of the input value.

- **Return Value Routing:** Moving the masked value into `rax` (`mov rax, rdi`) ensures the correct isolated byte is returned to the testing harness.


---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global LOBYTE

LOBYTE:
    # 1. Mask the input value to keep only the lowest 8 bits (0xff)
    and rdi, 0xff
    
    # 2. Move the masked result into rax as the return value
    mov rax, rdi
    
    # 3. Return from the function
    ret

# challenge: lowercase-a-string (converting uppercase characters using bitwise or)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / lowercase-a-string

- **challenge level:** implementing a custom shared library function in x86-64 assembly (`chr_lower`) to convert uppercase ASCII characters to lowercase by setting the 6th bit using a bitwise `or` mask (`0x20`)

- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)


---

## 🧠 core rules & mechanisms

- **ASCII Case Conversion via Bitwise OR:** In the ASCII character table, uppercase letters (`A`-`Z`, `0x41`-`0x5a`) and lowercase letters (`a`-`z`, `0x61`-`0x7a`) differ precisely by the 6th bit (`0x20`). Applying a bitwise `or` operation with `0x20` (`or rdi, 0x20`) forces this bit on, converting any uppercase character to its lowercase equivalent without altering already lowercase or non-alphabetic inputs.

- **Return Value Routing:** Moving the modified character into `rax` (`mov rax, rdi`) ensures the lowercased character is returned correctly to the test harness.


---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global chr_lower

chr_lower:
    # 1. Set the 6th bit (0x20) to convert uppercase to lowercase
    or rdi, 0x20
    
    # 2. Move the converted character into rax as the return value
    mov rax, rdi
    
    # 3. Return from the function
    ret

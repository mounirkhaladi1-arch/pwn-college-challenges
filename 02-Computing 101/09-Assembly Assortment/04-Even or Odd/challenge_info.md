# challenge: even-or-odd (evaluating integer parity using bitwise and)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/assembly-assortment/)**

---

## 🔗 environment details

- **dojo track / module:** assembly-assortment / even-or-odd

- **challenge level:** implementing a custom shared library function in x86-64 assembly (`solve`) to determine integer parity, masking the input value to extract the lowest bit and returning `1` for even numbers and `0` for odd numbers

- **execution format:** assembling source code (`as`), linking shared library objects (`ld -shared`), and running validation test harnesses (`/challenge/check`)


---

## 🧠 core rules & mechanisms

- **Bitwise Masking via `and`:** Using a bitwise `and` operation with a mask of `1` (`and rdi, 1`) wipes out every bit except the lowest bit, isolating whether the 64-bit input integer is odd or even.

- **Parity Inversion Logic:** Because isolating the lowest bit results in `1` for odd values and `0` for even values, you must invert the resulting parity bit using `xor rax, 1` to satisfy the requirement of returning `1` for even numbers and `0` for odd numbers.


---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Isolate the lowest bit of the input value in rdi
    and rdi, 1
    
    # 2. Move the isolated bit into rax for the return value
    mov rax, rdi
    
    # 3. Invert the parity bit (0 becomes 1 for even, 1 becomes 0 for odd)
    xor rax, 1
    
    # 4. Return the result
    ret

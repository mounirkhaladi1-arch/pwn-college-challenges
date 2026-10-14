# challenge: calling-through-a-pointer-with-an-argument (register preservation and indirect argument passing)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** implementing a shared library function (`solve`) that receives a function pointer in `rdi`, saves it before `rdi` is overwritten, loads the required argument (`1337`) into `rdi`, executes an indirect call, and returns cleanly
* **execution format:** shared object compilation (`as`, `ld -shared`), harness testing (`/challenge/harness /tmp/your-program.so`), and automated validation

---

## 🧠 core rules & mechanisms

* **Register Collision / Argument Overwrite:** The harness provides the callback function pointer in `rdi`. However, under standard calling conventions, the callback expects its first argument *also* to be passed in `rdi`. 
* **Safe Register Preservation (`mov rax, rdi`):** To prevent losing the function pointer address when `rdi` is loaded with `1337`, the pointer must first be copied into a temporary scratch register (such as `rax`).
* **Indirect Execution with Arguments:** Setting `rdi` to the target value (`1337`) and issuing `call rax` executes the callback with the correct arguments in place.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Save the callback function pointer (currently in rdi) into rax before rdi is overwritten
    mov rax, rdi
    
    # 2. Load the required argument (1337) into rdi as expected by the callback ABI
    mov rdi, 1337
    
    # 3. Call the function pointer via the scratch register
    call rax
    
    # 4. Return cleanly back to the harness runner
    ret

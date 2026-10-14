# challenge: calling-through-a-pointer (executing function callbacks via register indirect calls)

## 🛠️ quick access

👉 **[direct link to module](https://pwn.college/computing-101/control-flow/)**

---

## 🔗 environment details

* **dojo track / module:** computing-101 / control-flow
* **challenge level:** implementing a shared library function (`solve`) that receives a function pointer (callback) as its first argument in `rdi`, invoking it indirectly via an assembly `call` instruction, and returning cleanly to the harness
* **execution format:** shared object compilation (`as`, `ld -shared`), harness testing (`/challenge/harness /tmp/your-program.so`), and automated validation

---

## 🧠 core rules & mechanisms

* **Function Pointers in Registers (`rdi`):** Under standard System V AMD64 ABI conventions, the first argument passed to `solve` is a 64-bit memory address pointing directly to a function (the callback).
* **Indirect Register Calls (`call rdi`):** Unlike direct calls that target a static label (`call target_func`), an indirect call passes a register containing an address. The CPU updates `rip` to point to the address stored in `rdi` and pushes the return address onto the stack.
* **The `ret` Instruction:** After the callback executes its logic (which prints the flag) and returns, execution flows back to `solve`, which hits `ret` to cleanly exit back to the test harness.

---

## 📄 source implementation: `solve.s`

```assembly
.intel_syntax noprefix  
.global solve

solve:
    # 1. Call the function pointer passed as the first argument in rdi
    call rdi
    
    # 2. Return cleanly back to the harness runner
    ret

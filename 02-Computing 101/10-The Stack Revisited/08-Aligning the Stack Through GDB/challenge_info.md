# Challenge Documentation: `aligning-the-stack-through-gdb`

## 🛠️ Challenge Overview & Target Track
- **Module:** `the-stack-revisited` (`computing-101`)[cite: 1]
- **Challenge Name:** `aligning-the-stack-through-gdb`[cite: 2]
- **Objective:** Use GDB to identify the exact stack address where `argv[0]` lands during debugging, then match that exact stack offset in the normal shell environment by dynamically padding an environment variable.

---

## 🔬 Low-Level Mechanics & GDB Stack Environment

When a program runs under GDB, the extra debugger overhead shifts the initial stack pointer layout relative to running it directly in a clean shell. 
1. **Target Identification:** Running the challenge binary inside GDB (`/challenge/program`) reports the target `argv[0]` address (e.g., `0x7fffffffed1d`).
2. **Shell Drift:** Running the program raw in the shell places `argv[0]` at a different address (e.g., `0x7fffffffefd0`), requiring a calculated byte difference.
3. **Environment Padding Calculation:** Subtracting the target address from the shell address yields the exact byte difference. Generating a string of characters of that exact length via `printf` and `seq` inside an environment variable (`fou=...`) shifts the shell stack alignment precisely to the target address.

---

## 💻 Execution & Exploitation Command

```bash
# Calculate the exact difference between shell stack address and GDB target address, pad environment, and run program
env -i fou=$(printf 'x%.0s' $(seq 1$((0x7fffffffefd0 - 0x7fffffffed1d)))) /challenge/program

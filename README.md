# pwn.college Cybersecurity & Advanced Technical Solutions

This repository serves as my comprehensive, continuous engineering archive documenting my solutions, customized scripts, and technical progression across various specialized dojos on the **pwn.college** educational platform.

The workspace is designed to scale dynamically; it acts as a central repository for structural computer infrastructure solutions, Linux environment controls, low-level architecture modules, and future advanced exploitation/defensive domains as I continuously progress.

---

## 📂 Repository Architecture & Track Management

The repository is organized by specific dojo topics, scaling from foundational system interaction to deep operating system mechanics and assembly-level logic:

* 📁 `Linux Luminarium/` – Challenges focusing on core Linux file structures, shell automation, environment variable management, and privilege routing.
* 📁 `Computing 101/` – Challenges covering infrastructure logic, assembly-level computation architectures, stack memory execution, and customized manual control algorithms.
* 📁 *(Future Dojos)* – Upcoming security tracks, sandboxing, and advanced computer engineering frameworks will be added systematically as independent directories.

---

## 🛠️ General Verification & Execution Guidelines

To correctly verify, execute, and audit any solution, script, or binary hosted within this repository, **all operations must be performed using the verified pwn.college platform environment**. 

The challenges rely on the specific architecture layouts, system permissions, and testing binaries provided inside the platform's workspace.

### Standard Verification Workflow via pwn.college:

1. **Environment Setup:** Launch the dedicated challenge instance on the pwn.college platform for the respective dojo topic.
2. **Code Implementation:** Deploy the script or module from the corresponding directory in this repository (e.g., executing Python utilities or writing Assembly source files).
3. **Compilation & Assembly (For Low-Level Source Code):**
   When testing raw x86-64 assembly binaries inside the dojo terminal, execute standard compilation commands from your designated workspace:
   ```bash
   # Assemble the source logic into an object file
   as -o solution.o path/to/source_file.s
   
   # Link the object file to generate the executable binary
   ld -o solution_bin solution.o
   ```
4. **Execution & Platform Verification Patterns:** 
   The validation pipeline varies dramatically depending on the specific track. Reviewers should not expect a simple compile-and-run workflow for every solution. The platform utilizes multiple diverse execution patterns:
   * **Parameter-Driven Checkers:** Standalone solution binaries are rarely executed in isolation; they are typically passed directly as arguments or input pointers to the platform's automated testing suite (e.g., `/challenge/check solve.s` or `/challenge/check ./solution_bin`).
   * **Multi-Checker Pipelines:** Advanced verification can involve interacting with multiple interconnected background checkers, handlers, and validation layers executing concurrently to audit specific register environments and stack layouts.
   * **Diverse Challenge Mechanics:** Many challenges do not involve source code compilation or scripting at all. Tasks routinely require reverse engineering compiled binary executables to manually extract underlying code, navigating specific text-based puzzle environments, or playing interactive architectural games designed to benchmark hex-based math and logical constraints.
---

## ⚖️ Open Source License

This repository and all custom solutions are released under the **MIT License**. Reviewers, academic auditors, and peers are free to audit, test, and benchmark the logic models inside the official platform environment for evaluation and academic purposes.

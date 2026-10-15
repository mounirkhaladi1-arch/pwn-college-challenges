.intel_syntax noprefix  
.global solve

solve:
    # 1. Load the signed byte from the pointer in rdi and sign-extend it into 64-bit rax
    movsx rax, byte ptr [rdi]
    
    # 2. Return the sign-extended 64-bit value back to the harness
    ret

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

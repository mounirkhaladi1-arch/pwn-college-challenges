.intel_syntax noprefix  
.global solve

solve:
    # 1. Call the function pointer passed as the first argument in rdi
    call rdi
    
    # 2. Return cleanly back to the harness runner
    ret

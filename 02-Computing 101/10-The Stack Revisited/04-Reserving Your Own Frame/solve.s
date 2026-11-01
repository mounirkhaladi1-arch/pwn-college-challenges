.intel_syntax noprefix  
.global solve

solve:
    # 1. Allocate 256 bytes on the stack
    sub rsp, 256
    
    # 2. Initialize loop counter to 0
    xor rcx, rcx
    
loop:
    # 3. Zero out the byte at the current stack offset
    mov byte ptr [rsp + rcx], 0
    
    # 4. Check if we have reached the last byte offset (255)
    cmp rcx, 255
    je done
    
    # 5. Increment counter and repeat loop
    inc rcx
    jmp loop

done:
    # 6. Restore rsp back to the saved return address position
    add rsp, 256
    
    # 7. Return to the caller
    ret

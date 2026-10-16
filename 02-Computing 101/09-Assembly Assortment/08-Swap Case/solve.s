.intel_syntax noprefix  
.global str_swapcase

str_swapcase:
loop:
    # 1. Check for the null terminator first to prevent corrupting 0x00 and causing an infinite loop
    cmp byte ptr [rdi], 0
    je done
    
    # 2. Toggle the 6th bit to swap character case in place
    xor byte ptr [rdi], 0x20
    
    # 3. Advance the string pointer to the next character
    inc rdi
    
    # 4. Repeat loop for the next byte
    jmp loop

done:
    ret

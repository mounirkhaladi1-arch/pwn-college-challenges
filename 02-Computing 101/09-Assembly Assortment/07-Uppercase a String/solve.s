.intel_syntax noprefix  
.global str_upper

str_upper:
loop:
    # 1. Clear the 6th bit to convert lowercase to uppercase in place
    and byte ptr [rdi], 0xdf
    
    # 2. Check if we have reached the null terminator (0x0)
    cmp byte ptr [rdi], 0
    je done
    
    # 3. Advance the string pointer to the next character
    inc rdi
    
    # 4. Repeat loop for the next byte
    jmp loop

done:
    ret

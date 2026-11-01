.intel_syntax noprefix
.global solve

solve:
    # 1. Save input arguments and allocate 256-byte stack frame
    mov r8, rdi         # r8 = buffer pointer
    mov r9, rsi         # r9 = buffer length
    sub rsp, 256        # reserve scratch table

    # ==========================================
    # LOOP 1: Clear scratch table to 0
    # ==========================================
    xor rcx, rcx
clear_loop:
    mov byte ptr [rsp + rcx], 0
    cmp rcx, 255
    je clear_done
    inc rcx
    jmp clear_loop
clear_done:

    # ==========================================
    # LOOP 2: Scan buffer and mark slots
    # ==========================================
    xor rcx, rcx        # rcx = buffer index counter

mark_loop:
    cmp rcx, r9
    jge mark_done

    # Load current byte from input buffer into rax (value from 0 to 255)
    movzx rax, byte ptr [r8 + rcx]

    # Mark presence in our stack table at [rsp + byte_value]
    mov byte ptr [rsp + rax], 1

    inc rcx
    jmp mark_loop
mark_done:

    # ==========================================
    # LOOP 3: Count marked slots
    # ==========================================
    xor rcx, rcx        # rcx = table index (0 to 255)
    xor rax, rax        # rax = distinct byte counter

count_loop:
    cmp rcx, 256
    jge done_count

    # Check if this table slot is marked (1)
    cmp byte ptr [rsp + rcx], 1
    jne skip_inc
    inc rax             # found a distinct byte, increment counter

skip_inc:
    inc rcx
    jmp count_loop

done_count:
    # 2. Restore stack frame and return distinct count in rax
    add rsp, 256
    ret

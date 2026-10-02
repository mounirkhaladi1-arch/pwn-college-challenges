.intel_syntax noprefix
.global atoi_digit
.global atoi
.global _start

atoi_digit:
    movzx rax, byte ptr [rdi]  
    sub rax, 0x30        
    ret        

_start:

mov rsi, [rsp +16]

atoi:
xor rax,rax
mov r8,1


movzx rbx, byte ptr [rsi]
cmp rbx, 0x2d

jne loop

mov r8, -1
inc rsi

loop:
movzx rbx, byte ptr [rsi]
sub rbx, 0x30
cmp rbx, 9
ja done


imul rax, 10
add rax,rbx

inc rsi
jmp loop

done:


imul rax, r8
mov rdi, rax
mov rax, 60
syscall

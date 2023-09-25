GLOBAL seven

section .rodata
number equ 7

seven:
    push ebp
    mov ebp, esp

    mov eax, number

    leave
    ret


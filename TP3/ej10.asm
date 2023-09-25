
section .text
GLOBAL main
EXTERN printf


main:
    ; stackframe
    enter 0, 0
    
    mov eax, 0
    cpuid

    push ecx
    push edx
    push ebx
    push esp
    push fmt
    call printf

    add esp, 5 * 4

    mov eax, 1
    leave
    ret
    
section .data
fmt db "CPU: %s", 10, 0



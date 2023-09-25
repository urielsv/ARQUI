section .text
GLOBAL main
EXTERN printf

main:
    enter 0, 0

    push 3
    call fibonacci

    add esp, 4

    push eax
    call printf

    mov eax, 0
    leave
    ret

fibonacci:
    enter 0, 0
    mov ebx [ebp + 8] ; num
    mov eax, 0
    mov ecx, 0
    mov edx, 1
    
    .loop:
        cmp ebx, 0
        jz .is_zero
        
        cmp ebx, 1
        je .is_one

        dec ebx
        
        ; recursive
        push ebx
        call fibonacci

        add esp, 4

        mov eax, ecx ; ?
        add eax, edx
        mov ecx, edx ; ?
        mov edx, eax ; ?
        leave
        ret

    .is_zero:
        ;add eax, 0
        leave
        ret
    .is_one:
        add eax, 1
        leave
        ret



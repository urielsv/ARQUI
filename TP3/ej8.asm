GLOBAL _start

_start:
    push esp+4 ; argv[0]
    push esp

    call main
    mov ebx, eax
    mov eax, 1
    int 0x80

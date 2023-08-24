section .text
global _start

_start:

    push dword [n] ; Count de suma de numeros
    ;call _add_numbers
    mov ecx, string
    mov edx, 2
    ; Write to stdout
    mov eax, 4
    mov ebx, 1
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

_add_numbers:
    push ebp
    mov ebp, esp
    mov ecx, [esp+16]     ; saveo count

    xor edx, edx ; seteo la suma en 0
    mov eax, edx     ; guardo el numero actual ?
    sum_loop:
        inc eax
        add edx, eax
        dec ecx
        jnz sum_loop    ; si ecx > 0

    ; Retorno mi suma en ebx ???? 
    ;mov ebx, edx
    mov ecx, 'A'
    mov esp, ebp
    pop ebp
    ret 

section .data
string db 'A', 10
n dd 3


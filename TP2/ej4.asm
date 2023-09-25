extern num_to_str

section .text
global _start

_start:

    push n ; Count de suma de numeros

    ; Sum n natural numbers
    call _add_numbers

    ; Parse my number into string
    push string     ; dir of string where the parsed num will be saved.
    push edx        ; my number
    call num_to_str

    ; Write to stdout
    mov ecx, string
    mov edx, size
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
    mov ecx, [esp+8]     ; saveo count

    ; Saveo count moviendo el stack pointer "1 vez"
    ;add esp, 8
    ;pop ecx

    xor edx, edx     ; seteo la suma en 0
    mov eax, edx     ; guardo el numero actual ?
    sum_loop:
        inc eax
        add edx, eax
        dec ecx
        jnz sum_loop    ; si ecx > 0

    ; Retorno mi suma en edx ???? 
    ; El num queda en edx
    mov esp, ebp
    pop ebp
    ret 


section .data
n equ 3
size equ 20

section .bss
num resd 20
string resd 20



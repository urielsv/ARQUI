; Escribir un programa que ordene un array de números enteros, 
; de 4 bytes, e imprima el resultado ordenado por pantalla.
EXTERN num_to_str

SECTION .text
GLOBAL _start

_start:
    push array
    push size
    call _sort

    ; Parse sorted array to string
    push string
    push array
    push size
    call _arr_to_str

    ; Write to stdout
    mov ecx, string
    mov edx, strlen

    ; Write
    mov eax, 4
    mov ebx, 1
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80


_arr_to_str:
    push ebp
    mov ebp, esp

    xor eax, eax      ; Clear eax (string index)
    mov ebx, [ebp+16] ; string

    mov ecx, [ebp+12] ; array
    mov edx, [ebp+8]  ; size

    xor esi, esi      ; Clear esi (array index)

loop:
    push eax          ; Backup string index

    ; Push parameters for num_to_str
    mov eax, esi      ; Load array index into eax
    imul eax, 4       ; Scale the index by 4 (since each element is 4 bytes)
    add eax, ecx      ; Add the scaled index to the base address of the array
    push ebx          ; String
    push eax        ; Number (load from memory at the calculated address)
    call num_to_str

    pop eax           ; Restore string index

    add eax, 4        ; Move to the next element in the string buffer
    add esi, 1        ; Move to the next element in the array
    dec edx           ; Decrease size
    jnz loop          ; Repeat until size becomes 0

    pop ebp
    ret

_sort:
    ; Create stackframe
    push ebp
    mov ebp, esp

    mov eax, [ebp+12] ; array
    mov edx, [ebp+8]  ; size

outer_loop:
    mov ecx, edx
    dec ecx

inner_loop:
    mov ebx, eax
    add ebx, 4
    mov esi, [eax]
    mov edi, [ebx]

    cmp esi, edi
    jle not_swap

    ; Swap elements
    mov [eax], edi
    mov [ebx], esi

not_swap:
    add eax, 4
    dec ecx
    jnz inner_loop

    dec edx
    jnz outer_loop

    ; Destroy stackframe
    mov esp, ebp
    pop ebp
    ret

SECTION .data
array dd 4, 3, 2, 1
size equ 4
strlen equ 20

SECTION .bss
string resb 20

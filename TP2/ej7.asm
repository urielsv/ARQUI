; Escribir un programa que dado un array de números enteros, de 4 bytes, 
; encuentre el menor, y lo imprima por salida estándar.
EXTERN num_to_str

SECTION .text
global _start

_start:
        push array
        push size
        call _find_lowest

        ; Parse number to string
        push string
        push eax        ; number
        call num_to_str

        ; Write to stdout
        mov ecx, string
        mov edx, strlen
        mov eax, 4
        mov ebx, 1
        int 0x80

        ; Exit
        mov eax, 1
        xor ebx, ebx
        int 0x80


_find_lowest:
        ; Create stackframe
        push ebp
        mov ebp, esp
        
        mov ebx, [ebp+12]   ; save pointer to array
        mov eax, [ebx]      ; init lowest with the first one

        mov ecx, [ebp+8]    ; save array size
        dec ecx
        add ebx, 4          ; point ebx to the next number
        
        loop:
            cmp eax, [ebx]
            jg set_lowest
            
            next: 
            add ebx, 4  ; next number in array
            dec ecx
            jnz loop
        

        ; Destroy stackframe
        mov esp, ebp
        pop ebp
        ret

        set_lowest:
            mov eax, [ebx]
            jmp next

SECTION .data
array dd 4, 2, 3, 8
size equ 4
strlen equ 20

SECTION .bss
string resb 20

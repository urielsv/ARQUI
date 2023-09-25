; dado un n, k multiplos desde 1 hasta k
EXTERN num_to_str

SECTION .text
GLOBAL _start

_start:
        call _multip_num
        
        ; Write
        mov ecx, string
        mov edx, size
        mov eax, 4
        mov ebx, 1
        int 0x80

        ; Exit
        mov eax, 1
        mov ebx, 0
        int 0x80

_multip_num:
        push ebp
        mov ebp, esp

        xor ecx, ecx ; Set zero
        mov eax, string
        multip_loop:
            add ecx, n
            
            cmp ecx, k
            ; Check if ecx is greater than k
            jge end
            ; If in range then save to string
          
            ; Las funciones (excepto en guia de C) todos los registros antes del llamado de una funcion no necesariamente vna a tener el mismo
            ; valor despues del llamado del la funcion. Entonces tengo que tener backupeado los valores de los registros antes de callear.

            ; Creo un backup en el stackfrme
            push eax 
            push ecx

            ; Pusheo parametros de funcion
            push eax            ; String
            push ecx            ; Number
            call num_to_str

            ; Recupero los valores iniciales (backup)
            pop ecx
            pop eax

            ;24
            inc eax
            ;mov byte [eax], ','
            ;inc eax
            ;add dword string, 1
            ;mov dword [string], ","
            ;add dword string, 1
            jmp multip_loop 

            end:
            ; End
            mov ebp, esp
            pop ebp
            ret


SECTION .data
k equ 10
n equ 2
size equ 30
comaxd equ ','

SECTION .bss
string resd 30



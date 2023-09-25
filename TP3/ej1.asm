GLOBAL main
EXTERN printf

section .rodata
fmtA db "argc: %d", 10, 0
fmtB db "argv[%d] = %s", 10, 0

section .text
main:
    push ebp
    mov ebp, esp

    push dword [ebp+8] ; %d (argc)
    push fmtA
    call printf
    add esp, 2*4

    ;mov eax, 0

    mov ecx, dword [ebp+8] ; argc
    mov ebx, 0              ; index
    mov esi, [ebp+12]       ; argv[0]
    
    .loop:
        mov eax, [esi]

        push ecx ; backup ->
        
        push eax; *argv
        push ebx; index
        push fmtB
        call printf
        add esp, 3*4    ; move pointer to where it was before "pseudo-clean the stack"

        pop ecx ; backup <-

        inc ebx ; index++
        add esi, 4 ; next argv

        loop .loop ; loop: ecx-- and compare if not zero
        
    
    mov esp, ebp
    pop ebp

    mov eax, 0 ; return 0
    ret

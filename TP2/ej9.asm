extern num_to_str

section     .text
global      _start

_start:     push    ebp
            mov     ebp, esp
            mov     eax, [ebp+4] ; save argc
            dec     eax          ; remove exec path
            
            push    string
            push    eax
            call    num_to_str

            mov     ecx, string
            mov     edx, size
            
            mov     eax, 4
            mov     ebx, 1
            int     0x80

            mov     eax, 1
            xor     ebx, ebx
            int     0x80

            mov     esp, ebp
            pop     ebp

section     .data
size        equ 20
section     .bss
string      resb 20

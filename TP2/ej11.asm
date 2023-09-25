
section .text
global _start

_start:
        mov      ecx, [esp + (n+2)*4]
        mov      edx, size

        mov      eax, 4
        mov      ebx, 1
        int      0x80

        mov     eax, 1
        xor     ebx, ebx
        int     0x80
        
section .data
        n       equ 6
        size    equ 5 + 5

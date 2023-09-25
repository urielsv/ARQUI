SECTION .text
global _start

_start:
        ; sleep (nanosleep syscall)
        mov     eax, 0xa2
        mov     ebx, dword 1000000000 ; nanoseconds
        int     0x80

        mov     eax, 1
        xor     ebx, ebx
        int     0x80


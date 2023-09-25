SECTION .text
EXTERN num_to_str
global _start

_start:
        ; get pid
        mov     eax, 0x14 ; dec() -> 20
        int     0x80

        ; parse number to string
        push    string
        push    eax
        call    num_to_str

        ; print
        mov     ecx, string
        mov     edx, 20 ; size
        mov     ebx, 1
        mov     eax, 4
        int     0x80
      
        ; exit
        mov     eax, 1
        xor     ebx, ebx
        int     0x80

SECTION .bss
string resb 20
        

section     .text
global      _start
extern      num_to_string

_start:
        push ebp
        mov esp, ebp
        loop:
                add      esp, 4

                mov      ecx, byte_str
                mov      edx, 1

                mov      eax, 4
                mov      ebx, 1
                int      0x80

                jmp     loop

        mov ebp, esp
        pop ebp

        mov     eax, 1
        xor     ebx, ebx
        int     0x80


section         .data
        byte_str    db "4"

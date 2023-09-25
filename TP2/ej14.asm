SECTION .text
global _start
_start:

        .print_parrent:
            mov     ecx, parent_str
            mov     edx, parent_len
            mov     eax, 4
            mov     ebx, 1
            int     0x80

        ; fork sys_call
        mov     eax, 0x2
        int     0x80

        ; eax will be 0 if child (zero flag)
        ; pidof child is '0'.
        cmp eax, 0
        jz .print_child
      
        ; hardcodeado
        .end:
            mov     eax, 1
            xor     ebx, ebx
            int     0x80


        .print_child:
            mov     ecx, child_str
            mov     edx, child_len
            mov     eax, 4
            mov     ebx, 1
            int     0x80
            jmp     .end

 
SECTION .data
parent_str  db "Soy el padre", 10
parent_len  equ $ - parent_str
child_str   db "Soy le hijo", 10
child_len   equ $ - child_str

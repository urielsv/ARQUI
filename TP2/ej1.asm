section         .text
global          _start

_start:         mov         ecx, string
                mov         edx, length
                mov         ebx, 1          ; stdout
                mov         eax, 4          ; sys_write
                int         80h             ; call kernel

                ; Exit code
                mov         eax, 1          ; sys_exit
                mov         ebx, 0          
                int         80h             


section         .data
string          db          "Hola Mundo!!", 10
length          equ         $-string

section         .bss
placeholder     resb        10


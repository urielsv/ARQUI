section         .text
global          _start

_start: 
                call    _toUpper

                ; printeamos el string
                mov     ecx, string
                mov     edx, length
                mov     ebx, 1      ; stdout
                mov     eax, 4      ; sys_write
                int     80h         ; call kernel

                mov     eax, 1      ; sys_exit
                mov     ebx, 0
                int     80h

; por que se pone "_"
_toUpper:       
                mov     ebx, string

                ; valido que sea minuscula y alpha.
                convert:
                        cmp     byte [ebx], 0           ; me fijo que no sea null
                        je      end                     

                        cmp     byte [ebx], 'a'         ; me fijo que sea mayor que 'a' 
                        jl      next                   

                        cmp     byte [ebx], 'z'         ; me fijo que sea menor que 'z'
                        jg      next                    

                        sub     byte [ebx], 'A' - 'a'   ; paso a mayuscula
                next:
                        inc     ebx                     ; habria que modificar esp ???
                        jnz     convert

                end:
                        ret

section         .data
string          db      "h4ppy c0ding", 10
length          equ     $ - string

section         .bss
placeholder     resb    10

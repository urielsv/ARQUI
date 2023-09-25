SECTION .text
global _start

_start:
        ; read from stdin
        mov     eax, 0x03
        mov     ebx, 0
        mov     ecx, string
        mov     edx, 69
        int     0x80

        push    string
        call    _to_upper
       
        ; print
        mov     ecx, string
        mov     edx, eax ;size ; size random esta medio mal
        mov     eax, 4
        mov     ebx, 1
        int     0x80

_to_upper:
        push ebp
        mov ebp, esp

        mov ecx, [ebp+8] ; text

        .convert:
                cmp     byte [ecx], 0           ; me fijo que no sea null
                je      .end                     

                cmp     byte [ecx], 'a'         ; me fijo que sea mayor que 'a' 
                jl      .next                   

                cmp     byte [ecx], 'z'         ; me fijo que sea menor que 'z'
                jg      .next                    

                sub     byte [ecx], 'a' - 'A'   ; paso a mayuscula
                
        .next:
                inc     ecx                     ; habria que modificar esp ???
                jnz     .convert

        .end:
        mov ebp, esp
        pop ebp
        ret

SECTION .bss
string  resb    20

SECTION .data
size    db 0

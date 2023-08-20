section .text                       ; "code" section
global _start                       ; rotulo _start es global y es como mi "main"

_start:

mov             dx, 0FFh
mov             bx, 20h
add             dx, bx
push            dx
push            4
pop             cx                  ; se guarda 4 en cx (es FIFO)

Ciclo:
inc             bx
dec             cx
jnz             Ciclo               ; jump not zero (flag, se modifica en dec en tal caso)

mov             eax, parametros
mov             AH, [parametros]
mov             BL, [parametros+1]

add             ah, bl              ; en hexa puedo sumar digito a digito? (checkear)
mov             [salida], ah        ; se pisa con el nuevo contenido de ah

ret 0                               ; call (empieza), ret (termina). (en stack)

section .data
parametros      db 11h, 12h, 13h    ; define byte, "vector" de bytes
salida          db 0



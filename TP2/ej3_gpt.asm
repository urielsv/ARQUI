section .text
global _start

_start:
    ; Push the integer parameter onto the stack
    push num

    call int_to_str
    
    mov eax, 4          ; sys_write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, str_buf   ; pointer to the string
    mov edx, str_len   ; length of the string
    int 0x80            ; invoke the system call

    ; Exit
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; return code 0
    int 0x80            ; invoke the system call

int_to_str:
    pusha               ; Save registers (EAX, ECX, EDX, EBX, ESP, EBP, ESI, and EDI)

    mov eax, [esp + 4]  ; Load the integer (32 bits) parameter
    mov edi, str_buf    ; Destination buffer for the string
    add edi, str_len    ; Move edi to the end of the buffer
    mov byte [edi], 0   ; Null-terminate the string

convert_loop:
    dec edi             ; Move back in the buffer
    xor edx, edx        ; Clear edx for division
    mov ecx, 10         ; Divide by 10
    div ecx             ; Divide eax by 10
    add dl, '0'         ; Convert remainder to ASCII

    mov [edi], dl       ; Store ASCII character in buffer

    test eax, eax       ; Check if quotient is zero
    jnz convert_loop    ; If not, repeat the loop

    popa                ; Restore registers
    ret

section .data
num dd 12345           ; Integer to be converted to string
; Sus? Onda habrian null terminated values antes de mi string.
str_buf db 20    ; Buffer to store the string (with '0's)
str_len equ $ - str_buf; Length of the string


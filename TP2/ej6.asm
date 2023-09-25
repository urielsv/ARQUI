extern num_to_str

SECTION .text
global _start

_start:
        push num
        call _fact_num
          
        push string     ; dir of string where the parsed num will be saved.
        push eax        ; my number
        call num_to_str

        ; Write to stdout
        mov ecx, string
        mov edx, size
        mov eax, 4
        mov ebx, 1
        int 0x80

        ; Exit
        mov eax, 1
        xor ebx, ebx
        int 0x80

_fact_num:
            ; Create stackframe
            push ebp
            mov ebp, esp

            mov ebx, [ebp+8]    ; save num (counter)
          
            mov eax, 1          ; start mult
            xor ecx, ecx        ; set ecx to 0 in case number is 128 bit
            loop:
                    mul ebx
                    
                    dec ebx
                    cmp ebx, 0
                    jg loop

            ; Destroy stackframe
            mov esp, ebp
            pop ebp
            ret


SECTION .data
num equ 3
size equ 20
SECTION .bss
string resd 20

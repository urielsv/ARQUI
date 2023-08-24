section         .text
global          _start

_start:         
                ; Push params (to stack)
                push string
                push num

                call _numToString
                

                ; Write to terminal
                mov ecx, string
                mov edx, size

                mov ebx, 1          ; stdout
                mov eax, 4          ; std_write
                int 80h

                ; Exit
                mov eax, 1
                mov ebx, 0
                int 80h

_numToString:
                mov ecx, 10     ; Divide by 10
                pop ebp         ; why? stack frame? preguntar!!
                pop eax         ; Number
                pop ebx         ; String (dir)
                push ebp        ; Save base pointer
                push ebx        ; Save return value (dir of string)

                loop:
                ; Setear en 0 edx (donde guardo el reminder), luego divido (eax) por ecx (10) y agrego '0' (pasar ascii) mi resto
                xor edx, edx                        ; clear edx (set 0) reminder 
                div ecx                             ; Div eax by ecx (10) 
                add dl, '0'                        ; reminder to ascii
                ; cociente se guarda en eax

                mov byte [ebx], dl                  ; save 1 byte (dl, reminder) to ebx (string).
                cmp eax, 0                          ; check if quotient is 0.
                jz  flip                            ; if quo is 0 then flip
                
                ; else
                inc ebx                             ; next pos of the string (reminder)
                jmp loop
                
                flip:
                pop edx                             ; dir de string guardado en edx
                mov ecx, ebx                        ; 
                xor ax, ax                          ; clear ax

                ; invert char
                invert:
                cmp edx, ecx                        ; cmp edx (curr pos) w/ ecx (size)
                jge end                             ; if edx >= ecx, jump to end

                ; Load byte from edx and ecx
                mov al, [edx]                       
                mov ah, [ecx]
                mov [edx], ah                       ; Store ah in pos pointed by edx
                mov [ecx], al                       ; idem

                inc edx                             ; Move to next char from the start
                dec ecx                             ; Move to prev char from the end

                jmp invert

                end:
                inc edx                             ; Move to the end of the string
                mov byte [edx], 0                   ; load null terminated.
                ret

section         .data
num             equ             10
size            equ             20

section         .bss
string          resd            20              ; space for 1 dword (4 bytes)
                

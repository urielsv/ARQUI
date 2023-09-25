section .text
global num_to_str

num_to_str:
                ; Armado stackframe
                push ebp
                mov ebp, esp

                mov ecx, 10     ; Divide by 10
                ;pop ebp         ; dir de retorno
                ;pop eax         ; Number
                mov eax, [esp + 8]
                mov ebx, [esp + 12]
                ;pop ebx         ; String (dir)
                ;push ebp        ; Save base pointer
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
                mov esp, ebp
                pop ebp
                ret


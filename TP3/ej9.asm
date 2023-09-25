; Syscalls
SYS_READ    equ 3
SYS_WRITE   equ 4
SYS_OPEN    equ 5
SYS_CLOSE   equ 6
SYS_GETPID  equ 20
SYS_KILL    equ 37


GLOBAL pid
GLOBAL sys_writefd
GLOBAL sys_readfd
GLOBAL sys_kill
GLOBAL sys_close
GLOBAL sys_open

section .text

pid:
    ; Stackframe
    push ebp
    mov ebp, esp

    mov eax, SYS_GETPID
    int 0x80

    leave
    ret

; Read from file descriptor
; args: fd, buff, size
; ret: eax #bytes read
sys_readfd:
    push ebp
    mov ebp, esp

    push ebx ; backup ->

    mov eax, SYS_READ ; returns #bytes read into eax
    mov ebx, [ebp+8] ; fd
    mov ecx, [ebp+12] ; buff
    mov edx, [ebp+16] ; size
    int 0x80

    pop ebx ; backup <-
    leave
    ret

; Write to file descriptor
; args: fd, buff, size
; ret: eax #bytes written
sys_writefd:
    push ebp
    mov ebp, esp
    push ebx ; backup ->

    mov eax, SYS_WRITE
    mov ebx, [ebp+8] ; fd
    mov ecx, [ebp+12]; buff
    mov edx, [ebp+16]; size
    int 0x80

    pop ebx; backup <-
    leave
    ret

; Kills (closes) the program
; args: pid
sys_kill:
    push ebp
    mov ebp, esp

    push ebx ; backup ->

    mov eax, SYS_KILL
    mov ebx, [ebp+8] ; pid
    int 0x80

    pop ebx ; backup <-
    leave
    ret

; Closes a file (descriptor)
; args: fd
; ret: error (if)
sys_close:
    push ebp
    mov ebp, esp

    push ebx ; backup ->

    mov eax, SYS_CLOSE
    mov ebx, [ebp+8] ; fd
    int 0x80

    pop ebx ; backup <-
    leave
    ret

; Opens a file
; args: filename, flags (permissions)
; ret: error (if)
sys_open:
    push ebp
    mov ebp, esp
    push ebx ; backup ->

    mov eax, SYS_OPEN
    mov ebx, [ebp+8] ; file
    mov ecx, [ebp+12] ; flags
    int 0x80

    pop ebx ; backup ->
    leave
    ret







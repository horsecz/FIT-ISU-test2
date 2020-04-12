%include "rw32-2018.inc"

;cv7.3 priklad 1

section .data
    ; zde budou vase data
string dw "druha mocnina = ",0

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov edx, 69
    call ReadInt16 ; v AX
    call mypow
    
    mov esi, string
    call WriteNewLine
    call WriteString
    call WriteInt32

    pop ebp
    ret
    
;short mypow ( short:ax cislo );
;muze menit pouze EAX
mypow:
    push ebp
    mov ebp, esp
    push edx
    push ebx
    
    ;osetreni preteceni pri nasobeni
    cwde ; AX -> EAX
    imul ax ;v vysledek v DX:AX
    
    shl edx, 16
    mov dx, ax
    mov eax, edx
    
    pop ebx
    pop edx
    pop ebp
    ret
%include "rw32-2018.inc"

; cv9_2 .bss, priklad 2
; neinicializovane hodnoty = alokovane = .bss
; loop

section .data

section .bss
    pole resd 10

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov ecx, 10
    
    for:
        mov [pole + 4*ecx - 4], ecx
        mov eax, [pole + 4*ecx - 4]
        call WriteInt32
        call WriteNewLine
        loop for

    pop ebp
    ret
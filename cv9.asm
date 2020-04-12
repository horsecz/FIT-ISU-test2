%include "rw32-2018.inc"

; cv9 - ukol 1 (faktorial)

section .data
    ; zde budou vase data

section .text
_main:
    push ebp
    mov ebp, esp
    
    push dword 0
    xor eax, eax
    xor edx, edx
    
    call factorial
    add esp, 4
    
    ; vystup
    call WriteNewLine
    call WriteUInt32

    pop ebp
    ret
    
; unsigned int:eax factorial ( unsigned int:[ebp + 8] );
factorial:
    push ebp
    mov ebp, esp
    push ebx
    push edx
    
    mov ebx, [ebp + 8]
    
    mov eax, 1
    cmp ebx, 1
    je end
    cmp ebx, 0
    je end
    
    dec ebx
    push ebx
    call factorial
    add esp, 4
    
    mul dword [ebp + 8]
    
    end:
    pop edx
    pop ebx
    pop ebp
    ret
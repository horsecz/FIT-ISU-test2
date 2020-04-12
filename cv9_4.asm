%include "rw32-2018.inc"

; porovnavani retezcu, equality retezcu
; rep -> repe / repne

section .data
    login db "xhorky32",0
    string2 db "Shoda!",0
    string3 db "Neshoda!",0
    
section .bss
    string resb 9

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov ebx, 8
    mov edi, string
    call ReadString ; retezec se nacte do EDI
    mov esi, login
    
    mov ecx, 8
    repe cmpsb
    je equal
    jmp nequal
    
    equal:
        mov esi, string2
        call WriteString
        jmp end
    
    nequal
        mov esi, string3
        call WriteString
        jmp end

    end:
    pop ebp
    ret
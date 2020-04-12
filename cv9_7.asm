%include "rw32-2018.inc"

; cv9_6 - lods, stos -> delete_spaces

section .data
    pX db "1 000 000  ->  uh oh",0

section .text
_main:
    push ebp
    mov ebp, esp
    
    xor eax, eax
    
    mov esi, pX
    call WriteString
    call WriteNewLine
    xor esi, esi
    
    push pX
    call delete_spaces
    add esp, 4
    
    call WriteInt32 ; return hodnota (EAX) => succ 0 / err -1
    call WriteNewLine
    mov esi, pX
    call WriteString
    call WriteNewLine

    pop ebp
    ret
    
; int:eax delete_spaces ( char:[ebp+8]* string );
delete_spaces:
    push ebp
    mov ebp, esp
    push edi
    push esi
    xor eax, eax
    
    mov esi, [ebp+8]
    mov edi, [ebp+8]
    
    cmp esi, 0
    je .err
    
    .for:
    lodsb ; ESI -> al
    cmp al, ' '
    je .skip
    
    stosb ; al -> EDI
    jmp .skip
    
        .skip:
            cmp al, 0
            jne .for
            jmp end
        
        .err:
        mov eax, -1
        jmp end
        
    end:
    pop esi
    pop edi
    pop ebp
    ret
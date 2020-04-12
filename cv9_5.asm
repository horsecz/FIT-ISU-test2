%include "rw32-2018.inc"

; cv9_5 -> movsb, cld, std - kopirovani obsahu z pole do pole

section .data
    source db "__Ahoj__",0
    dest db "xxxxxxxx",0
section .bss

section .text
_main:
    push ebp
    mov ebp, esp
    
    xor eax, eax
    mov esi, source
    add esi, 2
    mov edi, source
    add edi, 4
    
    push dword 4
    call _copy_text
    add esp, 4
    
    call WriteInt32
        
    .end:   
    ; vypise pole
    mov esi, source
    call WriteNewLine
    call WriteString
    mov esi, dest
    call WriteNewLine
    call WriteString
    
    pop ebp
    ret
    
; int:eax copy_text ( char:esi* source, char:edi* dest, int:[ebp+8] n );
_copy_text:
    push ebp
    mov ebp, esp
    push ecx
    push esi
    push edi
    
    ;osetreni NULL adres (pointeru)
    cmp esi, 0
    je .error
    cmp edi, 0
    je .error
    
    mov ecx, [ebp + 8]
    cmp ecx, 0
    je .end
    
    ;osetreni prekryvajicich se poli
    cmp esi, edi
    ja .notOverlay
    dec ecx ; aby se neodstranila '\0'
    add esi, ecx
    add edi, ecx
    inc ecx ; vrati se ecx
    std ; DF=1
    
        .notOverlay:
         rep movsb
         jmp .end
    
        .error:
            mov eax, -1
            jmp .end

    .end:
    pop edi
    pop esi
    pop ecx
    pop ebp
    cld ; nastavi DF=0
    ret
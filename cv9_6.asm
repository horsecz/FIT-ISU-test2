%include "rw32-2018.inc"

; cv9_6 - scasXX - count_spaces - pocitani mezer ve stringu

section .data
    string dd "petmezer     uh oh(nebone?)",0

section .text
_main:
    push ebp
    mov ebp, esp
    
    xor eax, eax
    mov edi, string
    call count_spaces
    
    call WriteInt32 ; return hodnota (EAX) => pocet mezer nebo -1

    pop ebp
    ret
    
; int:eax count_spaces ( char:edi* string );
count_spaces:
    push ebp
    mov ebp, esp
    push ebx
    push edi
    xor ebx, ebx
    
    ;osetreni NULL adres (pointeru)
    cmp edi, 0
    je counting.error
    
    counting:
    mov al, 0
    scasb
    jne .notend
    mov eax, ebx
    jmp end
    
        counting.notend:
            mov al, ' '
            dec edi ; potreba protoze prvni scasb to inkrementoval
            ; a ja potrebuju porovnat porad stejny znak
            scasb
            je counting.space
            jmp counting
            
            
        counting.space:
            inc ebx
            jmp counting
    
        counting.error:
            mov eax, -1
            jmp end
        
    end:
    pop edi
    pop ebx
    pop ebp
    ret
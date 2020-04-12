%include "rw32-2018.inc"

;cv_7.4 priklad 3


section .data
string db "Vystup: ",0

section .text
_main:
    push ebp
    mov ebp, esp
    
    call ReadUInt8 ; ulozi do AL
    mov bl, al
    
    mov esi, string
    call WriteNewLine
    call WriteString
    
    call recprint

    pop ebp
    ret
    
; void recprint ( unsigned char:al number );
    ; if ( number:al > 0 ) {
    ;   printf("%d", number:al);
    ;   number:al--;
    ;   recprint(number:al);
    ; }
    ; printf("%d", number:al);
recprint:  
    push eax
    
    call WriteUInt8
    dec al
    
    js .end
    call recprint
    
    .end:
    pop eax
    call WriteUInt8

    ret

%include "rw32-2018.inc"

; cv9_3 - retezove instrukce -> prace s polem
;
; SOURCE     <=>    ESI
; DEST         <=>    EDI
;
; prace s indexovymi registry (ESI,EDI) - instrukce:
; movsXX, cmpsXX, scasXX, lodsXX, stosXX
;
; movs -> zkopiruje data z ESI do EDI
; cmps -> porovna data ESI a EDI
; scas  -> porovnat data EDI s AL/AX/EAX
; lods  -> ulozi data z ESI do AL/AX/EAX
; stos  -> ulozi data z AL/AX/EAX do EDI
;
; velikost dat dat se urci poslednim znakem XX, tzn.
; movsb -> 8b, movsw -> 16b, movsd -> 32b
;
; DF = direction flag
; DF=0 -> posuv doprava, dopredu (CLD -> nastavi DF na 0)
; DF=1 -> posuv dozadu (STD -> nastavi DF na 1)
;
; PR:. movsXX -> esi, edi se inkrementuje -> dopredu -> DF=0
;        cmpsXX -> esi, edi se snizi -> dozadu -> DF=1
;
; Prefix REP:
; REP 'instrukce'   -> provede 'instrukci' ecx krát
;
; priklad: (jako predchozi +) prepsani pole 

section .data
    pole2 dd 1,1,1,1,1,1,1,1,1,10
    s_1 db "Pole2: ",0
    s_2 db "Pole1 inicializovano: ",0
    s_3 db "Pole2 prepsano: ",0
section .bss
    pole resd 10

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov ecx, 10
    mov esi, s_2
    call WriteString
    call WriteNewLine
    for:
        mov [pole + ecx*4 - 4], ecx
        mov eax, [pole + ecx*4 - 4]
        call WriteInt32
        call WriteNewLine
        loop for
        
    mov esi, s_1
    call WriteString
    call WriteNewLine
    mov ecx, 10
    for3:
        mov eax, [pole2 + ecx*4-4]
        call WriteInt32
        call WriteNewLine
        loop for3
    
    mov esi, pole
    mov edi, pole2
    mov ecx, 10
    rep movsd
    
    mov esi, s_3
    call WriteString
    call WriteNewLine
    mov ecx, 10
    for2:
        mov eax, [pole2 + ecx*4-4]
        call WriteInt32
        call WriteNewLine
        loop for2

    pop ebp
    ret
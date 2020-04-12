%include "rw32-2018.inc"

; cv7.2 -> cykly, jumpy, funkce
;
; EIP -> odkazuje do pameti, kde je kod (instrukce)
; primy pristup k EIP neni, pouzivaji se instrukce:

; call (volani fce), jumpy, ret (navrat)
; call: (call neni jump!)
;   na vrchol se ulozi navratova adresa
;   registry se nemeni po ukonceni funkce


section .data
    ; zde budou vase data
string dw "Provedeno! Koncim!",0
funcstr dw "Telo funkce:",0
endfunc dw "Konec funkce",0

section .text
_main:
    push ebp
    mov ebp, esp
    
    ; zapise se do eax 69
    mov eax, 69
    call WriteInt32 
    call WriteNewLine
    
    call _funkcia ; zavola se funkce
    
    call WriteInt32
    call WriteNewLine

    mov esi, string
    call WriteString
    
    pop ebp
    ret
    
    
_funkcia:
    ;var2 - ulozim si esp (netreba pak popovat pushnute registry)
    ;nicmene -> nedelat => co pushnu, to popnu
    ;push ebp
    ;mov ebp, esp

    push eax
    mov esi, funcstr
    call WriteString
    mov eax, 42 ; prepise se eax
    
    .for:
    call WriteInt32
    call WriteNewLine
    dec eax
    cmp eax, 30
    jne .for
    ; return -> skoci zpet za call
    mov esi, endfunc
    call WriteString
    call WriteNewLine
    
    pop eax
    ;var2
    ;mov esp,ebp
    ;pop ebp 
    
    ret ; vracim se na main
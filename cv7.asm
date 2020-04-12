%include "rw32-2018.inc"

; cv 7
; do stacku jdou jen 32b hodnoty 
; ESP   => spodek, posledni adresa zasobniku (autoupdated)
; EBP   => dno zasobniku aktualni funkce

section .data
; int i = 1 <---- GLOBALNI PROMENNA!
pole dd 1,69,10,1
string dw " stackE*X: ",0
str2 dw " bad! number: ",0
smugMsg dw " nicoSmug ",0

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov eax, [pole + 4]
    mov ebx, 6
    
    push eax
    push ebx
    
    xor eax, eax
    mov eax, 100
    mov ebx, 50
    add eax, ebx
    
    call WriteInt32
    mov esi, string
    call WriteString
    mov eax, [esp + 4]
    call WriteInt32
    
    pop ebx
    pop eax
    
    ; vypise smug kdyz 69
    cmp eax, ebx
    je smug
  
    mov esi, str2
    call WriteString
    call WriteInt32
    jmp end
    
smug:
    mov esi, smugMsg
    call WriteString
    
end:
    pop ebp
    ret
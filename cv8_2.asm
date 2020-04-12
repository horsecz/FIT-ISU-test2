%include "rw32-2018.inc"

; cv8_2 priklad 2
; promenne (lokalni, ve funkcich)
; ebp + x => promenne co jdou do funkce (argumenty)
; ebp -  x => promenne ve funkci (lokalni promenne)

section .data
vec1 db 1, 1, 2, 3, 4
vec2 db 5, 6, 7, 8, 9

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov esi, vec1
    mov edi, vec2
    
    call skalsouc
    
    call WriteNewLine
    call WriteInt8
    
    ; zde bude vas kod

    pop ebp
    ret
    
; void skalsouc ( char:esi *vec1, char:edi *vec2 );
skalsouc:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    sub esp, 4*5 ; misto pro 5 promennych
    
    mov eax, [esi]
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    
        mov al, [esi + 0]
        cwde
        imul byte [edi + 0] ; vysledek v ax
        mov [ebp - 4], eax
        
        mov al, [esi + 1]
        cwde
        imul byte [edi + 1] ; vysledek v ax
        mov [ebp - 8], eax
        
        mov al, [esi + 2]
        cwde
        imul byte [edi + 2] ; vysledek v ax
        mov [ebp - 12], eax
        
        mov al, [esi + 3]
        cwde
        imul byte [edi + 3] ; vysledek v ax
        mov [ebp - 16], eax
        
        mov al, [esi + 4]
        cwde
        imul byte [edi + 4] ; vysledek v ax
        mov [ebp - 20], eax
       
    xor eax, eax
    
        add eax, [ebp - 4]
        add eax, [ebp - 8]
        add eax, [ebp - 12]
        add eax, [ebp - 16]
        add eax, [ebp - 20]
    
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
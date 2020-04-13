%include "rw32-2018.inc"

; -- Fibonacciho posloupnost ---------------
;
; Program ze vstupu (stdin) precte cislo 'n' a vrati na vystup 'n-ty prvek' Fibonacciho posloupnosti.
; Soucasti implementace je detekce preteceni, kdy n-ty prvek posloupnosti je vetsi nez je maximalni
; hodnota ulozitelna v EAX (32bits)

section .data
ovflowstr dw "Overflow detected! Maximum ECX value is '46' (32bit number)!", 0
string dw "Output: ",0
section .bss
    cisla resd 30

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov edi, cisla
    
    call ReadInt32
    mov ecx, eax
    call WriteNewLine
    call WriteNewLine
    mov esi, string
    call WriteString
    ;mov ecx, 47
    call task23
    
    mov eax, [cisla + 4*ecx]
    cmp eax, -1
    jne .write
    jmp .notwrite
    
    .write:
    call WriteInt32
    
    .notwrite:    
    mov esp, ebp

    pop ebp
    ret

; void task23 (  int*:edi pole, int:ecx pocet_prvku );
task23:
    push ebp
    mov ebp, esp
    push ebx
    push edi
    push eax
    push edx
    
    xor edx, edx
    xor eax, eax
    xor ebx, ebx
    ;pFib[0] = 0
    mov dword [edi], 0
    cmp ebx, ecx
    je .end
    
    ;pFib[1] = 1
    add edi, 4
    inc ebx
    mov dword [edi], 1
    cmp ebx, ecx
    je .end
    
    ;for cycle -> pFib[i] = pFib[i-1] + pFib[i-2]
    .for:
        mov eax, [edi] ; pFib[i-1]
        sub edi, 4
        mov edx, [edi] ; pFib[i-2]
        add edi, 8
        inc ebx
        ; pFib[i] = ...
        add eax, edx
        mov dword [edi], eax
        
        ; preteceni (prilis velke ecx?)
        cmp eax, dword [edi-4]
        jl .overflow
        cmp ebx, ecx
        jb .for
        jmp .end
        
       .overflow:
       mov esi, ovflowstr
       call WriteString
       mov dword [cisla + 4*ecx], -1
       jmp .end
    
    .end:
    pop edx
    pop eax
    pop edi
    pop ebx
    pop ebp
    ret
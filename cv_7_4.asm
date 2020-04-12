%include "rw32-2018.inc"

; cv7_4 predavani parametru funkci
; a) globalni pamet = promenna (section .data/.bss)
; b) pres stack: (lokalni promenne)
; priklad 2

section .data
output db "Vystup: ",0

section .bss
array resb 31

section .text
_main:
    push ebp
    mov ebp, esp
    
    mov ebx, 30
    mov edi, array
    mov esi, edi
    call ReadString
    call numbers
    
    ; vystupni veci
    call WriteNewLine
    mov esi, output
    call WriteString
    call WriteInt32

    pop ebp
    ret

;int:eax numbers ( int:eax stringSize, char:esi *array );
numbers:
    ; v EAX uz je pocet znaku (po ReadString)
    push edx
    push ebx
    push ecx
    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx
    
    ;for (int i:edx = 0; i:edx < stringSize:eax; i++)
    .for:
        ; !!! movovat do registru STEJNE VELIKOSTI
        ; (napr byte nedavat do eax) jinak nefunguje
        mov bl, [array + edx]
        ; if (array[i:edx] < '0')
        cmp bl, '0'
        jl .continue
        
        ; if (array[i:edx] > '9')
        cmp bl, '9'
        jg .continue
        
        inc ecx
        
        .continue:
            inc edx
            cmp edx, eax
            jl .for
        
    mov eax, ecx
    pop ecx
    pop ebx
    pop edx
    ret
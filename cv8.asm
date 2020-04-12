%include "rw32-2018.inc"

; cv8 priklad 1

section .text
_main:
    push ebp
    mov ebp, esp
    
    call ReadUInt32
    mov ecx, eax
    call ReadUInt32
    mov ebx, eax
    call ReadUInt32
    
    ; je to tak debilne protoze jsem predtim pocital s konstantami
    ; (tzn rovnou push dword 'cislo')
    push ecx
    push ebx
    push eax
    
    call maxindex
    add esp, 4*3
    
    call WriteNewLine
    call WriteInt32

    pop ebp
    ret
    
; void maxindex ( int:ebp+16 a, int:ebp+12 b, int:ebp+8 c );
maxindex:
    push ebp
    mov ebp, esp
    push ebx
    
    a:
    mov ebx, [ebp+16]
    cmp ebx, [ebp+12]
    ja greater
    
    b:
    mov ebx, [ebp+12]
    cmp ebx, [ebp+16]
    ja greater2

    c:
    mov eax, 3
    jmp end
    
    greater:
        cmp ebx, [ebp+8]
        ja final_1
        jmp b
     
    greater2:
        cmp ebx, [ebp+8]
        ja final_2
        jmp c
        
    final_1:
    mov eax, 1
    jmp end
    
    final_2:
    mov eax, 2
    jmp end
    
    end:
    pop ebx
    pop ebp
    ret
    global collatz

collatz:
    mov rax , rdi ;X
    mov rcx , 0   ;a = 0
    mov rdx , 0   ;b = 0
    mov rbx , 0   ;c = 0

    cmp rax , 10
    jl .if     ; jumps to .if if rax < 10
    je .elseif ; jumps to .else if 
    jmp .else  ; jumps to .else
    ret

.go_on:
    mov rbx , 1 ; c = 1
    mov rax , 0 ; x = 0
    add rax , rcx ; x += a
    add rax , rdx ; x += b
    add rax , rbx ; x += c
    ret

.if:
    mov rcx , 1  ; a = 1
    jmp .go_on   ; jumps to .go_on  
    ret

.elseif:
    mov rdx , 1  ; b = 1
    jmp .go_on   ; jumps to .go_on
    ret

.else:
    mov rcx , 1  ; a = 1
    mov rdx , 1  ; b = 1
    jmp .go_on   ; jumps to .go_on
    ret
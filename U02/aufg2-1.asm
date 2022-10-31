    global collatz

collatz:
    mov rax , rdi
    call .while
    ret

.while:
    cmp rax , 10
    jne .do
    ret

.do:
    add rax , 1 ; G(x)
    jmp .while 
    ret
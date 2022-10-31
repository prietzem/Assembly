    global collatz

collatz:
    mov rax , 0
    call .while
    ret

.while:
    cmp rdi , 1
    jg .do ; jumps to do if rdi > 1
    ret

.do:
    add rax , 1   ; counts rax up
    test rdi , 1  ; AND operation with rdi and 1
    jp .divideby2 ; when divisble by 2 then jump to divideby2
    jmp .add3plus1 ; else jump to add3plus1
    ret

.add3plus1:
    imul rdi , 3
    add rdi , 1
    jmp .while   ; jumps to while
    ret

.divideby2:
    shr rdi , 1  ; divides rdi by 2
    jmp .while   ; jumps to while
    ret
    global sort

sort:
    mov rcx , rdi
    mov r10 , rsi ;r10 = i
    jmp .first_loop

.first_loop:
    cmp r10 , 1 ;if i > 1
    mov r11 , 0 ;j=0
    sub r10 , 1 ;i--
    jg .secound_loop ;then
    ret

.secound_loop:
    cmp r11 , r10 ;if j < i
    jl .do ;then
    jmp .first_loop

.do:
    mov rdi , r11
    imul rdi , 8
    add rdi , rcx

    mov rsi , rdi
    add rsi , 8
    call rdx
    cmp rax , 0
    jg .swap
    add r11 , 1
    jmp .secound_loop

.swap:
    mov r8 , [rdi]
    mov r9 , [rsi]
    mov [rdi] , r9
    mov [rsi] , r8
    add r11 , 1
    jmp .secound_loop

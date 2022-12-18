    global sort

sort:
    mov rax ,0
    mov r10 , rdi ;r10 = i
    sub rdi , 1
    jmp .first_loop 

.first_loop:
    cmp r10 , 1 ;if i > 1
    mov r11 , 0 ;j=0
    sub r10 , 1 ;i--
    jg .secound_loop
    ret

.secound_loop:
    cmp r11 , r10 ;if j < i
    jl .do ;then
    jmp .first_loop

.do:
    mov rax , r11
    imul rax , 8

    mov rcx , [rsi+rax]
    cmp rcx , [rsi+rax+8] ;if A[i] > A[i+1]
    add r11 , 1 ;j++
    jg .switch ;then
    jmp .secound_loop

.switch:
    mov r8 , [rsi+rax]
    mov r9 , [rsi+rax+8]
    mov [rsi+rax] , r9
    mov [rsi+rax+8] , r8
    jmp .secound_loop


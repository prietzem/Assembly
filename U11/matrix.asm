
    global asmRowAdd

asmRowAdd:
    mov rax , 0
    imul rsi , rdx ;m=m*n
    mov r10 , 0 ;i=0
    jmp .loop

.loop:
    cmp r10 , rsi ;if i<m*n
    jl .add_to_rax ;then
    ret

.add_to_rax:
    add rax , [rdi+r10*8] 
    add r10 , 1
    jmp .loop

    
    global asmColAdd

asmColAdd:
    ret
 
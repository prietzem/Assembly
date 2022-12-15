global asm_fib_it

asm_fib_it:
    mov rax , 0 ;k=0
    mov rdx , 1 ;y=1
    mov rcx , 0 ;x=0

    jmp .while
    

.while:
    cmp rdi , 0 ;if (n > 0)
    jg .do
    ret

.do:
    mov rcx , rdx ;x=y
    mov rdx , rax ;y=k

    mov rax , 0   ;k=0
    add rax , rdx ;k= k+y
    add rax , rcx ;k= k+x
    sub rdi , 1   ;n--

    jmp .while

global asm_fib_rek

asm_fib_rek:
    cmp rdi , 3 
    jl .ret1 ;if (n < 3) {return 1;}

    push rdi ;saves rdi for recursion
    sub rdi , 1 ;n=n-1
    call asm_fib_rek ;F(n-1)
    pop rdi ;restores original n
    push rax ;saves result of F(n-1)

    sub rdi ,2 ;n=n-2
    call asm_fib_rek ;F(n-2)
    pop rdx ;restores F(n-1)
    add rax , rdx ;add F(n-2) + F(n-1)

    ret

.ret1:
    mov rax , 1
    ret
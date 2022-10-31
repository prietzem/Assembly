    global gauss

gauss :
    mov rax , rdi ;move rdi into the rax register
    mul rdi ;multiply rax by itself

    add rax,rdi ;add n to rax

    ;mov rcx , 2  
    ;div rcx  ; divide the whole thing by 2
    shr rax , 1 ;divides also by 2 by shifting everything to the right

    ret

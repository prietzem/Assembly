    global gauss

gauss :
    mov rax , rdi ;move rdi into the rax register
    add rax , 1

    mul rdi ;multiply rax by itself
    ; rdx:rax if there is an overflow

    mov rcx , 2  
    div rcx  ; divide the whole thing by 2
    ;use div because it uses rdx as overflow register
    ;shr rax , 1 ;divides also by 2 by shifting everything to the right

    ret

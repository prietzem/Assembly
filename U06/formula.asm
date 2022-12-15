    global formula_int

formula_int:
    mov rax , rdi
    add rax , rsi ;a+b
    sub rdx , rcx ;c-d
    imul rax , rdx ;(a+b)*(c-d)

    shl r8 , 3 ;e=e*8
    shl r9 , 2 ;f=f*4
    add r8 , r9

    mov r10, [rsp+8]
    shr r10 , 1    ;g=g/2
    sub r8 , r10
    
    mov r11, [rsp+16]
    shr r11 , 2
    add r8 , r11

    imul rax , r8

    imul rax , -1

    mov rdx , 0
    mov rcx , 3
    idiv rcx
    
    imul rax , -1
    ret 

   

SECTION .data
two: DQ 2.0
three: DQ 3.0


SECTION .text

    global formula_flt
formula_flt:
    
    addsd xmm0 , xmm1 ;a+b
    subsd xmm2 , xmm3 ;c-d
    mulsd xmm0 , xmm2 ;(a+b)*(c-d)
    
    mulsd xmm4 , [rel two]
    mulsd xmm4 , [rel two]
    mulsd xmm4 , [rel two] ;e*8

    mulsd xmm5 , [rel two]
    mulsd xmm5 , [rel two] ;f*4

    addsd xmm4 , xmm5

    divsd xmm6 , [rel two] ;g/2

    subsd xmm4 , xmm6 

    divsd xmm7 , [rel two]
    divsd xmm7 , [rel two] ;h/4

    addsd xmm4 , xmm7

    mulsd xmm0 , xmm4

    divsd xmm0 , [rel three] 


    ret
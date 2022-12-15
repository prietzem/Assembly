    global calc_add

    calc_add:
        mov rax , 0 ; clears rax register for bitshifts
        mov rcx , 0 ; clears rcx register for bitshifts
        mov rdx , 0 ; clears rdx register for bitshifts
        mov rbx , 0 ; clears rbx register for bitshifts

        movd eax, xmm0 ; loads float a into eax
        movd ecx, xmm1 ; loads float b into ecx

        
        mov r8d , eax
        and r8d , 0x7FFFFF ;loads significant of float a into edx
        or  r8d , 0x800000 ;add hidden bit

        mov r9d , ecx
        and r9d , 0x7FFFFF ;loads significant of float b into ebx
        or  r9d , 0x800000 ;add hidden bit
        

        shr eax , 23 ;now characteristic ist stored in al and signbit in ah
        shr ecx , 23 ;now characteristic ist stored in cl and signbit in ch

        cmp eax , ecx
        jl .shift_a  ;shifts first register by diffrence of characteristics
        jg .shift_b
        jmp .main2

    .shift_a:
        mov edx, ecx
        sub ecx , eax ;gets diffrence of characteristics

        shl r9d , cl  ;shifts significant of a so that characteristic
        mov ecx , edx
        jmp .main2

    .shift_b:
        mov edx , eax
        sub eax , ecx ;gets diffrence of characteristics

        mov ebx , ecx
        mov ecx , eax

        shl r8d , cl ;shifts significant of a so that characteristic

        mov ecx , ebx
        mov eax , edx

        jmp .main2

    .main2:
        ;characteristic of both numbers are the same
        ;so eax = ecx
        ;for now we only use eax for the result

        add r8d , r9d ;add significants
        
        
        call .while ;noramlize the significant in r8d


        and r8d , 0xFF7FFFFF ;removes hidden bit

        shl eax , 23   ;shifts characteristic and signbit back to the front
        or  eax , r8d  ;now add significant

        movd xmm0 , eax ; loads eax into xmm0 
        ret ;xmm0 will be returned as result 


.while: ;normalize significant in r8d but forgets rounding
    cmp r8d , 0x1000000
    jge .do
    ret

.do:
    shr r8d , 1
    add rax , 1
    jmp .while





    global tri_area
tri_area :
    mov rax , rdi   ; rax := rdi
    mul rsi         ; rdx : rax := rsi * rax      
        
    ; not neccessarily needed here :
    ; mov rdx , 0

    mov rcx , 4     ; rcx := 2
    div rcx         ; rax := rax /2 , rdx := rax % 2


    ret

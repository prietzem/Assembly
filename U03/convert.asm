global strToInt

strToInt:
    mov rax , 0     ;clears register
    cmp rsi , 1 ;check if base is less than 1
    jl .error
    cmp rsi , 36 ;check if base is greater than 36
    jg .error

    jmp .while

.error:
    ret

.get_char:
    mul rsi
    add al , cl    ;adding cl to al
 
    
    add rdi , 1    ;going to the next char in string

    jmp .while


.sub_letter:
    sub cl , 55   ;subtractes cl by 55
    jmp .get_char

.sub_digit:
    sub cl , 48   ;subtractes cl by 48
    jmp .get_char

.check_if_digit:
    cmp cl , 48  ;checks if ascii-value ist between 48-57 (0-9)
    jl .error

    mov rdx , rsi
    add rdx , 47
    cmp cl , dl  ;checks if character ascii-value is too high
    jg .error
    jmp .sub_digit

.check_if_letter:
    cmp cl , 65 ;checks if ascii-value is between 65-90  (A-Z)
    jl .check_if_digit ;if its below 65 it could still be a digit

    mov rdx , rsi
    add rdx , 54
    cmp cl , dl    ;checks if character ascii-value is too high
    jg .error
    jmp .sub_letter

.while:
    mov cl , [rdi] ;moves ascii-char into cl (8-bit register)
    cmp cl , 0     ;check if al == 0
    jne .check_if_letter
    ret



global intToStr

intToStr:
    mov rax , rdi
    ret
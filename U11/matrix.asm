
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
  mov rax , 0 ;erg = 0
  mov r8 , 0 ;i=0
  jmp .loop_colums
  ret

.loop_colums:
  mov r9 , 0  ;j=0

  cmp r8 , rdx
  jl .loop_rows
  ret


.loop_rows:
  cmp r9 , rsi
  jl .add_to_erg
  add r8 , 1
  jmp .loop_colums

.add_to_erg:
  mov r10 , rsi
  imul r10 , r8
  imul r10 , 8
  add r10 , rdi
  add rax , [r10+r9*8]
  add r9 , 1
  jmp .loop_rows

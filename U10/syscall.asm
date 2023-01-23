

section .bss
  buffer: resb 1024

section .text

  global _start

%define sys_read 0
%define stdin 0
%define sys_exit 60
%define sys_write 1
%define stout 1

_start:
  mov rax, sys_read
  mov rdi , stdin
  mov rsi, buffer
  mov rdx, 1024
  syscall                 ;einlesen

  cmp rax , 1             ;warum auch immer es funktioniert mit 1 (wahrscheinlich wegen ENTER)
  je .end

  mov rax , sys_write
  mov rdi , stout
  lea rsi , [rel buffer]
  syscall                 ;schreiben

  jmp _start

.end:
  mov rax , sys_exit
	syscall

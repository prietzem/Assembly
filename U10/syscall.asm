

section .bss
  buffer: resb 1024
; everything after contains the actual code
section .text

  global _start

%define sys_read 0
%define stdin 0
%define sys_exit 60
%define sys_write 1
%define stout 1

_start: ; ... global _start
  mov rax, sys_read
  mov rdi , stdin
  mov rsi, buffer
  mov rdx, 1024
  syscall
  mov rax , sys_write
  mov rdi , stout
  lea rsi , [rel buffer]
  syscall

  jmp _start

.end:
  mov rax , sys_exit
	syscall

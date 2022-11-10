section	.text
   global tri_area     ;must be declared for linker (ld)
	
tri_area:	            ;tells linker entry point
   mov rax , 1
   ret
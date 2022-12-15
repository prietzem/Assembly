	.file	"fib_wrapper.c"
	.text
	.globl	simple_benchmark
	.type	simple_benchmark, @function
simple_benchmark:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	clock@PLT
	movq	-72(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, %rdi
	call	*%rdx
	movq	-72(%rbp), %rdx
	movq	%rax, 16(%rdx)
	call	clock@PLT
	movq	-72(%rbp), %rdx
	movq	(%rdx), %rcx
	subq	%rcx, %rax
	movq	%rax, %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, (%rax)
	leaq	-48(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, %rdi
	call	*%rdx
	movq	-72(%rbp), %rdx
	movq	%rax, 16(%rdx)
	leaq	-32(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movq	-32(%rbp), %rax
	imulq	$1000000, %rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, 8(%rax)
	movq	-72(%rbp), %rax
	movq	8(%rax), %rax
	movq	-48(%rbp), %rdx
	imulq	$1000000, %rdx, %rcx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, %rcx
	subq	%rcx, %rax
	movq	%rax, %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, 8(%rax)
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L2
	call	__stack_chk_fail@PLT
.L2:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	simple_benchmark, .-simple_benchmark
	.section	.rodata
	.align 8
.LC0:
	.string	"+-------+---------------+---------------+---------------+\n"
	.align 8
.LC1:
	.string	"|%s\t|Erg:\t\t|CPU-Cycles:\t|Time (us):\t|\n"
.LC2:
	.string	"\t"
.LC3:
	.string	""
.LC4:
	.string	"|It:\t|%lu\t%s|%ld\t%s|%lu\t%s|\n"
.LC5:
	.string	"|Rek:\t|%lu\t%s|%ld\t%s|%lu\t%s|\n"
	.align 8
.LC6:
	.string	"+-------+---------------+---------------+---------------+\n\n"
	.text
	.globl	drawTable
	.type	drawTable, @function
drawTable:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	$999999, %rax
	seta	%al
	movb	%al, -6(%rbp)
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	$999999, %rax
	seta	%al
	movb	%al, -5(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	cmpq	$999999, %rax
	setg	%al
	movb	%al, -4(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	cmpq	$999999, %rax
	setg	%al
	movb	%al, -3(%rbp)
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	cmpq	$999999, %rax
	seta	%al
	movb	%al, -2(%rbp)
	movq	-40(%rbp), %rax
	movq	8(%rax), %rax
	cmpq	$999999, %rax
	seta	%al
	movb	%al, -1(%rbp)
	movq	stdout(%rip), %rax
	movq	%rax, %rcx
	movl	$58, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout(%rip), %rax
	movq	%rax, %rcx
	movl	$58, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movzbl	-2(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L4
	leaq	.LC2(%rip), %rdx
	jmp	.L5
.L4:
	leaq	.LC3(%rip), %rdx
.L5:
	movq	-32(%rbp), %rax
	movq	8(%rax), %r8
	movzbl	-4(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L6
	leaq	.LC2(%rip), %rcx
	jmp	.L7
.L6:
	leaq	.LC3(%rip), %rcx
.L7:
	movq	-32(%rbp), %rax
	movq	(%rax), %rdi
	movzbl	-6(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L8
	leaq	.LC2(%rip), %rax
	jmp	.L9
.L8:
	leaq	.LC3(%rip), %rax
.L9:
	movq	-32(%rbp), %rsi
	movq	16(%rsi), %rsi
	subq	$8, %rsp
	pushq	%rdx
	movq	%r8, %r9
	movq	%rcx, %r8
	movq	%rdi, %rcx
	movq	%rax, %rdx
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addq	$16, %rsp
	movzbl	-1(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L10
	leaq	.LC2(%rip), %rdx
	jmp	.L11
.L10:
	leaq	.LC3(%rip), %rdx
.L11:
	movq	-40(%rbp), %rax
	movq	8(%rax), %r8
	movzbl	-3(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L12
	leaq	.LC2(%rip), %rcx
	jmp	.L13
.L12:
	leaq	.LC3(%rip), %rcx
.L13:
	movq	-40(%rbp), %rax
	movq	(%rax), %rdi
	movzbl	-5(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L14
	leaq	.LC2(%rip), %rax
	jmp	.L15
.L14:
	leaq	.LC3(%rip), %rax
.L15:
	movq	-40(%rbp), %rsi
	movq	16(%rsi), %rsi
	subq	$8, %rsp
	pushq	%rdx
	movq	%r8, %r9
	movq	%rcx, %r8
	movq	%rdi, %rcx
	movq	%rax, %rdx
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addq	$16, %rsp
	movq	stdout(%rip), %rax
	movq	%rax, %rcx
	movl	$59, %edx
	movl	$1, %esi
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	drawTable, .-drawTable
	.section	.rodata
.LC7:
	.string	"A number is required!\n"
.LC8:
	.string	"Invalid argument: \"%s\"\n"
	.align 8
.LC9:
	.string	"Please enter a positive number.\n"
	.align 8
.LC10:
	.string	"\nBenchmark f\303\274r die %lu. Fibonacci Zahl:\n\n"
.LC11:
	.string	"C"
.LC12:
	.string	"ASM"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movl	%edi, -84(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$1, -84(%rbp)
	jg	.L17
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$22, %edx
	movl	$1, %esi
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	$1, %eax
	jmp	.L21
.L17:
	movq	$0, -80(%rbp)
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	-80(%rbp), %rcx
	movl	$10, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strtoull@PLT
	movq	%rax, -72(%rbp)
	movq	-80(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L19
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	jne	.L20
.L19:
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	leaq	.LC8(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movq	stdout(%rip), %rax
	movq	%rax, %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	$1, %eax
	jmp	.L21
.L20:
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-64(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	leaq	c_fib_it(%rip), %rax
	movq	%rax, %rdi
	call	simple_benchmark
	leaq	-32(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	leaq	c_fib_rek(%rip), %rax
	movq	%rax, %rdi
	call	simple_benchmark
	leaq	-32(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	call	drawTable
	leaq	-64(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	movq	asm_fib_it@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	simple_benchmark
	leaq	-32(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	movq	asm_fib_rek@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	simple_benchmark
	leaq	-32(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	call	drawTable
	movl	$0, %eax
.L21:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L22
	call	__stack_chk_fail@PLT
.L22:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.type	c_fib_it, @function
c_fib_it:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)
	movq	$0, -8(%rbp)
	movq	$1, -24(%rbp)
	movq	$0, -16(%rbp)
	jmp	.L24
.L25:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	subq	$1, -40(%rbp)
.L24:
	cmpq	$0, -40(%rbp)
	jne	.L25
	movq	-16(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	c_fib_it, .-c_fib_it
	.type	c_fib_rek, @function
c_fib_rek:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	cmpq	$2, -24(%rbp)
	ja	.L28
	movl	$1, %eax
	jmp	.L29
.L28:
	movq	-24(%rbp), %rax
	subq	$1, %rax
	movq	%rax, %rdi
	call	c_fib_rek
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	subq	$2, %rax
	movq	%rax, %rdi
	call	c_fib_rek
	addq	%rbx, %rax
.L29:
	movq	-8(Allerdings nur, wenn sie dem System zum Zeitpunkt des nächtlichen Datenabrufs bereits bekannt waren.%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	c_fib_rek, .-c_fib_rek
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

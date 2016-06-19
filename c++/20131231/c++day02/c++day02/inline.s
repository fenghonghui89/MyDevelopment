	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
Leh_func_begin0:
	.cfi_lsda 16, Lexception0
## BB#0:
	pushq	%rbp
Ltmp27:
	.cfi_def_cfa_offset 16
Ltmp28:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp29:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
Ltmp30:
	.cfi_offset %rbx, -32
Ltmp31:
	.cfi_offset %r14, -24
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	movl	$200, %esi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	movq	%rax, %rbx
	movq	(%rbx), %rax
	movq	-24(%rax), %rsi
	addq	%rbx, %rsi
	leaq	-40(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
Ltmp0:
	movq	%r14, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp1:
## BB#1:
	movq	(%rax), %rcx
	movq	56(%rcx), %rcx
Ltmp2:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*%rcx
	movb	%al, %r14b
Ltmp3:
## BB#2:                                ## %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit
	leaq	-40(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%r14b, %esi
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	movl	$99, %esi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	movq	%rax, %rbx
	leaq	-32(%rbp), %r14
	movq	(%rbx), %rax
	movq	-24(%rax), %rsi
	addq	%rbx, %rsi
	movq	%r14, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
Ltmp8:
	movq	%r14, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp9:
## BB#3:
	movq	(%rax), %rcx
	movq	56(%rcx), %rcx
Ltmp10:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*%rcx
	movb	%al, %r14b
Ltmp11:
## BB#4:                                ## %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit1
	leaq	-32(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%r14b, %esi
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	movl	$99, %esi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	movq	%rax, %rbx
	leaq	-24(%rbp), %r14
	movq	(%rbx), %rax
	movq	-24(%rax), %rsi
	addq	%rbx, %rsi
	movq	%r14, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
Ltmp16:
	movq	%r14, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp17:
## BB#5:
	movq	(%rax), %rcx
	movq	56(%rcx), %rcx
Ltmp18:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*%rcx
	movb	%al, %r14b
Ltmp19:
## BB#6:                                ## %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit2
	leaq	-24(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%r14b, %esi
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	ret
LBB0_7:
Ltmp4:
	movq	%rax, %rbx
Ltmp5:
	leaq	-40(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
Ltmp6:
	jmp	LBB0_8
LBB0_9:
Ltmp7:
	movq	%rax, %rdi
	callq	___clang_call_terminate
LBB0_10:
Ltmp12:
	movq	%rax, %rbx
Ltmp13:
	leaq	-32(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
Ltmp14:
	jmp	LBB0_8
LBB0_11:
Ltmp15:
	movq	%rax, %rdi
	callq	___clang_call_terminate
LBB0_12:
Ltmp20:
	movq	%rax, %rbx
Ltmp21:
	leaq	-24(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
Ltmp22:
LBB0_8:                                 ## %unwind_resume
	movq	%rbx, %rdi
	callq	__Unwind_Resume
LBB0_13:
Ltmp23:
	movq	%rax, %rdi
	callq	___clang_call_terminate
	.cfi_endproc
Leh_func_end0:
	.section	__TEXT,__gcc_except_tab
	.align	2
GCC_except_table0:
Lexception0:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	155                     ## @TType Encoding = indirect pcrel sdata4
	.ascii	 "\230\001"             ## @TType base offset
	.byte	3                       ## Call site Encoding = udata4
	.ascii	 "\217\001"             ## Call site table length
Lset0 = Leh_func_begin0-Leh_func_begin0 ## >> Call Site 1 <<
	.long	Lset0
Lset1 = Ltmp0-Leh_func_begin0           ##   Call between Leh_func_begin0 and Ltmp0
	.long	Lset1
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset2 = Ltmp0-Leh_func_begin0           ## >> Call Site 2 <<
	.long	Lset2
Lset3 = Ltmp3-Ltmp0                     ##   Call between Ltmp0 and Ltmp3
	.long	Lset3
Lset4 = Ltmp4-Leh_func_begin0           ##     jumps to Ltmp4
	.long	Lset4
	.byte	0                       ##   On action: cleanup
Lset5 = Ltmp3-Leh_func_begin0           ## >> Call Site 3 <<
	.long	Lset5
Lset6 = Ltmp8-Ltmp3                     ##   Call between Ltmp3 and Ltmp8
	.long	Lset6
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset7 = Ltmp8-Leh_func_begin0           ## >> Call Site 4 <<
	.long	Lset7
Lset8 = Ltmp11-Ltmp8                    ##   Call between Ltmp8 and Ltmp11
	.long	Lset8
Lset9 = Ltmp12-Leh_func_begin0          ##     jumps to Ltmp12
	.long	Lset9
	.byte	0                       ##   On action: cleanup
Lset10 = Ltmp11-Leh_func_begin0         ## >> Call Site 5 <<
	.long	Lset10
Lset11 = Ltmp16-Ltmp11                  ##   Call between Ltmp11 and Ltmp16
	.long	Lset11
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset12 = Ltmp16-Leh_func_begin0         ## >> Call Site 6 <<
	.long	Lset12
Lset13 = Ltmp19-Ltmp16                  ##   Call between Ltmp16 and Ltmp19
	.long	Lset13
Lset14 = Ltmp20-Leh_func_begin0         ##     jumps to Ltmp20
	.long	Lset14
	.byte	0                       ##   On action: cleanup
Lset15 = Ltmp19-Leh_func_begin0         ## >> Call Site 7 <<
	.long	Lset15
Lset16 = Ltmp5-Ltmp19                   ##   Call between Ltmp19 and Ltmp5
	.long	Lset16
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset17 = Ltmp5-Leh_func_begin0          ## >> Call Site 8 <<
	.long	Lset17
Lset18 = Ltmp6-Ltmp5                    ##   Call between Ltmp5 and Ltmp6
	.long	Lset18
Lset19 = Ltmp7-Leh_func_begin0          ##     jumps to Ltmp7
	.long	Lset19
	.byte	1                       ##   On action: 1
Lset20 = Ltmp13-Leh_func_begin0         ## >> Call Site 9 <<
	.long	Lset20
Lset21 = Ltmp14-Ltmp13                  ##   Call between Ltmp13 and Ltmp14
	.long	Lset21
Lset22 = Ltmp15-Leh_func_begin0         ##     jumps to Ltmp15
	.long	Lset22
	.byte	1                       ##   On action: 1
Lset23 = Ltmp21-Leh_func_begin0         ## >> Call Site 10 <<
	.long	Lset23
Lset24 = Ltmp22-Ltmp21                  ##   Call between Ltmp21 and Ltmp22
	.long	Lset24
Lset25 = Ltmp23-Leh_func_begin0         ##     jumps to Ltmp23
	.long	Lset25
	.byte	1                       ##   On action: 1
Lset26 = Ltmp22-Leh_func_begin0         ## >> Call Site 11 <<
	.long	Lset26
Lset27 = Leh_func_end0-Ltmp22           ##   Call between Ltmp22 and Leh_func_end0
	.long	Lset27
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.byte	1                       ## >> Action Record 1 <<
                                        ##   Catch TypeInfo 1
	.byte	0                       ##   No further actions
                                        ## >> Catch TypeInfos <<
	.long	0                       ## TypeInfo 1
	.align	2

	.section	__TEXT,__textcoal_nt,coalesced,pure_instructions
	.private_extern	___clang_call_terminate
	.globl	___clang_call_terminate
	.weak_definition	___clang_call_terminate
	.align	4, 0x90
___clang_call_terminate:                ## @__clang_call_terminate
## BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	callq	___cxa_begin_catch
	callq	__ZSt9terminatev

	.section	__TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support

.subsections_via_symbols

	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp2:
	.cfi_def_cfa_offset 16
Ltmp3:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp4:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	movabsq	$4, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
	leaq	-40(%rbp), %rdi
	leaq	__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_(%rip), %rsi
	movq	%rax, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	%rdi, -56(%rbp)         ## 8-byte Spill
	movq	%rax, %rdi
	callq	*-32(%rbp)
	movq	-56(%rbp), %rdi         ## 8-byte Reload
	movq	%rax, -64(%rbp)         ## 8-byte Spill
	callq	__ZN1AC1Ev
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	movabsq	$4, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm
	leaq	-40(%rbp), %rdi
	leaq	__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_(%rip), %rsi
	movq	%rax, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	%rdi, -72(%rbp)         ## 8-byte Spill
	movq	%rax, %rdi
	callq	*-16(%rbp)
	movq	-72(%rbp), %rdi         ## 8-byte Reload
	movq	%rax, -80(%rbp)         ## 8-byte Spill
	callq	__ZNK1A4showEv
	leaq	-48(%rbp), %rdi
	callq	__ZN1AC1Ev
	leaq	-48(%rbp), %rdi
	callq	__ZN1A4showEv
	movl	$0, %eax
	addq	$80, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.section	__TEXT,__textcoal_nt,coalesced,pure_instructions
	.private_extern	__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_
	.globl	__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_
	.weak_definition	__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_
	.align	4, 0x90
__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_: ## @_ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
Leh_func_begin1:
	.cfi_lsda 16, Lexception1
## BB#0:
	pushq	%rbp
Ltmp15:
	.cfi_def_cfa_offset 16
Ltmp16:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp17:
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movq	%rdi, -72(%rbp)
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	movq	%rdi, %rcx
	addq	%rax, %rcx
	movq	%rcx, -32(%rbp)
	movb	$10, -33(%rbp)
	movq	-32(%rbp), %rsi
	leaq	-48(%rbp), %rax
	movq	%rdi, -80(%rbp)         ## 8-byte Spill
	movq	%rax, %rdi
	movq	%rax, -88(%rbp)         ## 8-byte Spill
	callq	__ZNKSt3__18ios_base6getlocEv
	movq	-88(%rbp), %rax         ## 8-byte Reload
	movq	%rax, -24(%rbp)
	movq	-80(%rbp), %rcx         ## 8-byte Reload
Ltmp5:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	movq	%rcx, -96(%rbp)         ## 8-byte Spill
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp6:
	movq	%rax, -104(%rbp)        ## 8-byte Spill
	jmp	LBB1_1
LBB1_1:                                 ## %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i
	movb	-33(%rbp), %al
	movq	-104(%rbp), %rcx        ## 8-byte Reload
	movq	%rcx, -8(%rbp)
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rdx
	movq	(%rdx), %rsi
	movq	56(%rsi), %rsi
	movsbl	-9(%rbp), %edi
Ltmp7:
	movl	%edi, -108(%rbp)        ## 4-byte Spill
	movq	%rdx, %rdi
	movl	-108(%rbp), %r8d        ## 4-byte Reload
	movq	%rsi, -120(%rbp)        ## 8-byte Spill
	movl	%r8d, %esi
	movq	-120(%rbp), %rdx        ## 8-byte Reload
	callq	*%rdx
Ltmp8:
	movb	%al, -121(%rbp)         ## 1-byte Spill
	jmp	LBB1_5
LBB1_2:
Ltmp9:
	movl	%edx, %ecx
	movq	%rax, -56(%rbp)
	movl	%ecx, -60(%rbp)
Ltmp10:
	leaq	-48(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
Ltmp11:
	jmp	LBB1_3
LBB1_3:
	movq	-56(%rbp), %rdi
	callq	__Unwind_Resume
LBB1_4:
Ltmp12:
	movl	%edx, %ecx
	movq	%rax, %rdi
	movl	%ecx, -128(%rbp)        ## 4-byte Spill
	callq	___clang_call_terminate
LBB1_5:                                 ## %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit
	leaq	-48(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movq	-96(%rbp), %rdi         ## 8-byte Reload
	movb	-121(%rbp), %al         ## 1-byte Reload
	movsbl	%al, %esi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	-72(%rbp), %rdi
	movq	%rax, -136(%rbp)        ## 8-byte Spill
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	movq	-72(%rbp), %rdi
	movq	%rax, -144(%rbp)        ## 8-byte Spill
	movq	%rdi, %rax
	addq	$144, %rsp
	popq	%rbp
	ret
	.cfi_endproc
Leh_func_end1:
	.section	__TEXT,__gcc_except_tab
	.align	2
GCC_except_table1:
Lexception1:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	155                     ## @TType Encoding = indirect pcrel sdata4
	.asciz	 "\274"                 ## @TType base offset
	.byte	3                       ## Call site Encoding = udata4
	.byte	52                      ## Call site table length
Lset0 = Leh_func_begin1-Leh_func_begin1 ## >> Call Site 1 <<
	.long	Lset0
Lset1 = Ltmp5-Leh_func_begin1           ##   Call between Leh_func_begin1 and Ltmp5
	.long	Lset1
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset2 = Ltmp5-Leh_func_begin1           ## >> Call Site 2 <<
	.long	Lset2
Lset3 = Ltmp8-Ltmp5                     ##   Call between Ltmp5 and Ltmp8
	.long	Lset3
Lset4 = Ltmp9-Leh_func_begin1           ##     jumps to Ltmp9
	.long	Lset4
	.byte	0                       ##   On action: cleanup
Lset5 = Ltmp10-Leh_func_begin1          ## >> Call Site 3 <<
	.long	Lset5
Lset6 = Ltmp11-Ltmp10                   ##   Call between Ltmp10 and Ltmp11
	.long	Lset6
Lset7 = Ltmp12-Leh_func_begin1          ##     jumps to Ltmp12
	.long	Lset7
	.byte	1                       ##   On action: 1
Lset8 = Ltmp11-Leh_func_begin1          ## >> Call Site 4 <<
	.long	Lset8
Lset9 = Leh_func_end1-Ltmp11            ##   Call between Ltmp11 and Leh_func_end1
	.long	Lset9
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.byte	1                       ## >> Action Record 1 <<
                                        ##   Catch TypeInfo 1
	.byte	0                       ##   No further actions
                                        ## >> Catch TypeInfos <<
	.long	0                       ## TypeInfo 1
	.align	2

	.section	__TEXT,__textcoal_nt,coalesced,pure_instructions
	.globl	__ZN1AC1Ev
	.weak_definition	__ZN1AC1Ev
	.align	4, 0x90
__ZN1AC1Ev:                             ## @_ZN1AC1Ev
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp20:
	.cfi_def_cfa_offset 16
Ltmp21:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp22:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	callq	__ZN1AC2Ev
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	__ZNK1A4showEv
	.weak_definition	__ZNK1A4showEv
	.align	4, 0x90
__ZNK1A4showEv:                         ## @_ZNK1A4showEv
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp25:
	.cfi_def_cfa_offset 16
Ltmp26:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp27:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rax
	leaq	L_.str1(%rip), %rsi
	movq	%rdi, -24(%rbp)
	movq	%rax, %rdi
	callq	__ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	leaq	__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_(%rip), %rsi
	movq	%rax, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdi
	callq	*-16(%rbp)
	movq	%rax, -32(%rbp)         ## 8-byte Spill
	addq	$32, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	__ZN1A4showEv
	.weak_definition	__ZN1A4showEv
	.align	4, 0x90
__ZN1A4showEv:                          ## @_ZN1A4showEv
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp30:
	.cfi_def_cfa_offset 16
Ltmp31:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp32:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rax
	leaq	L_.str(%rip), %rsi
	movq	%rdi, -24(%rbp)
	movq	%rax, %rdi
	callq	__ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	leaq	__ZNSt3__14endlIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_(%rip), %rsi
	movq	%rax, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdi
	callq	*-16(%rbp)
	movq	%rax, -32(%rbp)         ## 8-byte Spill
	addq	$32, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.private_extern	___clang_call_terminate
	.globl	___clang_call_terminate
	.weak_definition	___clang_call_terminate
	.align	4, 0x90
___clang_call_terminate:                ## @__clang_call_terminate
## BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	callq	___cxa_begin_catch
	movq	%rax, -8(%rbp)          ## 8-byte Spill
	callq	__ZSt9terminatev

	.globl	__ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	.weak_definition	__ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	.align	4, 0x90
__ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc: ## @_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
Leh_func_begin6:
	.cfi_lsda 16, Lexception6
## BB#0:
	pushq	%rbp
Ltmp67:
	.cfi_def_cfa_offset 16
Ltmp68:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp69:
	.cfi_def_cfa_register %rbp
	subq	$432, %rsp              ## imm = 0x1B0
	movq	%rdi, -216(%rbp)
	movq	%rsi, -224(%rbp)
	movq	-216(%rbp), %rsi
Ltmp33:
	leaq	-240(%rbp), %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_
Ltmp34:
	jmp	LBB6_1
LBB6_1:
	leaq	-240(%rbp), %rax
	movq	%rax, -208(%rbp)
	movq	-208(%rbp), %rax
	movb	(%rax), %cl
	movb	%cl, -281(%rbp)         ## 1-byte Spill
## BB#2:
	movb	-281(%rbp), %al         ## 1-byte Reload
	testb	$1, %al
	jne	LBB6_3
	jmp	LBB6_28
LBB6_3:
	movq	-224(%rbp), %rax
	movq	%rax, -200(%rbp)
Ltmp35:
	movq	%rax, %rdi
	callq	_strlen
Ltmp36:
	movq	%rax, -296(%rbp)        ## 8-byte Spill
	jmp	LBB6_4
LBB6_4:                                 ## %_ZNSt3__111char_traitsIcE6lengthEPKc.exit
	jmp	LBB6_5
LBB6_5:
	leaq	-272(%rbp), %rax
	movq	-296(%rbp), %rcx        ## 8-byte Reload
	movq	%rcx, -264(%rbp)
	movq	-216(%rbp), %rdx
	movq	%rax, -184(%rbp)
	movq	%rdx, -192(%rbp)
	movq	-184(%rbp), %rax
	movq	-192(%rbp), %rdx
	movq	%rax, -152(%rbp)
	movq	%rdx, -160(%rbp)
	movq	-152(%rbp), %rax
	movq	-160(%rbp), %rdx
	movq	(%rdx), %rsi
	movq	-24(%rsi), %rsi
	addq	%rsi, %rdx
	movq	%rdx, -144(%rbp)
	movq	-144(%rbp), %rdx
	movq	%rdx, -136(%rbp)
	movq	-136(%rbp), %rdx
	movq	40(%rdx), %rdx
	movq	%rdx, (%rax)
	movq	-224(%rbp), %rsi
	movq	-216(%rbp), %rax
	movq	(%rax), %rdx
	movq	-24(%rdx), %rdx
	addq	%rdx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movl	8(%rax), %edi
	movq	%rsi, -304(%rbp)        ## 8-byte Spill
	movl	%edi, -308(%rbp)        ## 4-byte Spill
## BB#6:
	movl	-308(%rbp), %eax        ## 4-byte Reload
	andl	$176, %eax
	cmpl	$32, %eax
	jne	LBB6_8
## BB#7:
	movq	-224(%rbp), %rax
	addq	-264(%rbp), %rax
	movq	%rax, -320(%rbp)        ## 8-byte Spill
	jmp	LBB6_9
LBB6_8:
	movq	-224(%rbp), %rax
	movq	%rax, -320(%rbp)        ## 8-byte Spill
LBB6_9:
	movq	-320(%rbp), %rax        ## 8-byte Reload
	movq	-224(%rbp), %rcx
	addq	-264(%rbp), %rcx
	movq	-216(%rbp), %rdx
	movq	(%rdx), %rsi
	movq	-24(%rsi), %rsi
	addq	%rsi, %rdx
	movq	-216(%rbp), %rsi
	movq	(%rsi), %rdi
	movq	-24(%rdi), %rdi
	addq	%rdi, %rsi
	movq	%rsi, -80(%rbp)
	movq	-80(%rbp), %rsi
	movl	144(%rsi), %r8d
	movl	$-1, -4(%rbp)
	movl	%r8d, -8(%rbp)
	movl	-4(%rbp), %r8d
	cmpl	-8(%rbp), %r8d
	movq	%rax, -328(%rbp)        ## 8-byte Spill
	movq	%rcx, -336(%rbp)        ## 8-byte Spill
	movq	%rdx, -344(%rbp)        ## 8-byte Spill
	movq	%rsi, -352(%rbp)        ## 8-byte Spill
	jne	LBB6_18
## BB#10:
	movq	-352(%rbp), %rax        ## 8-byte Reload
	movq	%rax, -40(%rbp)
	movb	$32, -41(%rbp)
	movq	-40(%rbp), %rsi
Ltmp37:
	leaq	-56(%rbp), %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp38:
	jmp	LBB6_11
LBB6_11:                                ## %.noexc
	leaq	-56(%rbp), %rax
	movq	%rax, -32(%rbp)
Ltmp39:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp40:
	movq	%rax, -360(%rbp)        ## 8-byte Spill
	jmp	LBB6_12
LBB6_12:                                ## %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i
	movb	-41(%rbp), %al
	movq	-360(%rbp), %rcx        ## 8-byte Reload
	movq	%rcx, -16(%rbp)
	movb	%al, -17(%rbp)
	movq	-16(%rbp), %rdx
	movq	(%rdx), %rsi
	movq	56(%rsi), %rsi
	movsbl	-17(%rbp), %edi
Ltmp41:
	movl	%edi, -364(%rbp)        ## 4-byte Spill
	movq	%rdx, %rdi
	movl	-364(%rbp), %r8d        ## 4-byte Reload
	movq	%rsi, -376(%rbp)        ## 8-byte Spill
	movl	%r8d, %esi
	movq	-376(%rbp), %rdx        ## 8-byte Reload
	callq	*%rdx
Ltmp42:
	movb	%al, -377(%rbp)         ## 1-byte Spill
	jmp	LBB6_16
LBB6_13:
Ltmp43:
	movl	%edx, %ecx
	movq	%rax, -64(%rbp)
	movl	%ecx, -68(%rbp)
Ltmp44:
	leaq	-56(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
Ltmp45:
	jmp	LBB6_14
LBB6_14:
	movq	-64(%rbp), %rax
	movl	-68(%rbp), %ecx
	movq	%rax, -392(%rbp)        ## 8-byte Spill
	movl	%ecx, -396(%rbp)        ## 4-byte Spill
	jmp	LBB6_26
LBB6_15:
Ltmp46:
	movl	%edx, %ecx
	movq	%rax, %rdi
	movl	%ecx, -400(%rbp)        ## 4-byte Spill
	callq	___clang_call_terminate
LBB6_16:                                ## %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i
Ltmp47:
	leaq	-56(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
Ltmp48:
	jmp	LBB6_17
LBB6_17:                                ## %.noexc1
	movb	-377(%rbp), %al         ## 1-byte Reload
	movsbl	%al, %ecx
	movq	-352(%rbp), %rdx        ## 8-byte Reload
	movl	%ecx, 144(%rdx)
LBB6_18:                                ## %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit
	movq	-352(%rbp), %rax        ## 8-byte Reload
	movl	144(%rax), %ecx
	movb	%cl, %dl
	movb	%dl, -401(%rbp)         ## 1-byte Spill
## BB#19:
	movq	-272(%rbp), %rdi
Ltmp49:
	movb	-401(%rbp), %al         ## 1-byte Reload
	movsbl	%al, %r9d
	movq	-304(%rbp), %rsi        ## 8-byte Reload
	movq	-328(%rbp), %rdx        ## 8-byte Reload
	movq	-336(%rbp), %rcx        ## 8-byte Reload
	movq	-344(%rbp), %r8         ## 8-byte Reload
	callq	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Ltmp50:
	movq	%rax, -416(%rbp)        ## 8-byte Spill
	jmp	LBB6_20
LBB6_20:
	leaq	-280(%rbp), %rax
	movq	-416(%rbp), %rcx        ## 8-byte Reload
	movq	%rcx, -280(%rbp)
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	$0, (%rax)
	jne	LBB6_27
## BB#21:
	movq	-216(%rbp), %rax
	movq	(%rax), %rcx
	movq	-24(%rcx), %rcx
	addq	%rcx, %rax
	movq	%rax, -120(%rbp)
	movl	$5, -124(%rbp)
	movq	-120(%rbp), %rax
	movq	%rax, -104(%rbp)
	movl	$5, -108(%rbp)
	movq	-104(%rbp), %rax
	movl	32(%rax), %edx
	orl	$5, %edx
Ltmp51:
	movq	%rax, %rdi
	movl	%edx, %esi
	callq	__ZNSt3__18ios_base5clearEj
Ltmp52:
	jmp	LBB6_22
LBB6_22:                                ## %_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj.exit
	jmp	LBB6_23
LBB6_23:
	jmp	LBB6_27
LBB6_24:
Ltmp58:
	movl	%edx, %ecx
	movq	%rax, -248(%rbp)
	movl	%ecx, -252(%rbp)
	jmp	LBB6_31
LBB6_25:
Ltmp53:
	movl	%edx, %ecx
	movq	%rax, -392(%rbp)        ## 8-byte Spill
	movl	%ecx, -396(%rbp)        ## 4-byte Spill
LBB6_26:                                ## %.body
	movq	-392(%rbp), %rax        ## 8-byte Reload
	movl	-396(%rbp), %ecx        ## 4-byte Reload
	movq	%rax, -248(%rbp)
	movl	%ecx, -252(%rbp)
Ltmp54:
	leaq	-240(%rbp), %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
Ltmp55:
	jmp	LBB6_30
LBB6_27:
	jmp	LBB6_28
LBB6_28:
Ltmp56:
	leaq	-240(%rbp), %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
Ltmp57:
	jmp	LBB6_29
LBB6_29:
	jmp	LBB6_33
LBB6_30:
	jmp	LBB6_31
LBB6_31:
	movq	-248(%rbp), %rdi
	callq	___cxa_begin_catch
	movq	-216(%rbp), %rdi
	movq	(%rdi), %rcx
	movq	-24(%rcx), %rcx
	addq	%rcx, %rdi
Ltmp59:
	movq	%rax, -424(%rbp)        ## 8-byte Spill
	callq	__ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv
Ltmp60:
	jmp	LBB6_32
LBB6_32:
	callq	___cxa_end_catch
LBB6_33:
	movq	-216(%rbp), %rax
	addq	$432, %rsp              ## imm = 0x1B0
	popq	%rbp
	ret
LBB6_34:
Ltmp61:
	movl	%edx, %ecx
	movq	%rax, -248(%rbp)
	movl	%ecx, -252(%rbp)
Ltmp62:
	callq	___cxa_end_catch
Ltmp63:
	jmp	LBB6_35
LBB6_35:
	jmp	LBB6_36
LBB6_36:
	movq	-248(%rbp), %rdi
	callq	__Unwind_Resume
LBB6_37:
Ltmp64:
	movl	%edx, %ecx
	movq	%rax, %rdi
	movl	%ecx, -428(%rbp)        ## 4-byte Spill
	callq	___clang_call_terminate
	.cfi_endproc
Leh_func_end6:
	.section	__TEXT,__gcc_except_tab
	.align	2
GCC_except_table6:
Lexception6:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	155                     ## @TType Encoding = indirect pcrel sdata4
	.asciz	 "\257\201"             ## @TType base offset
	.byte	3                       ## Call site Encoding = udata4
	.ascii	 "\234\001"             ## Call site table length
Lset10 = Ltmp33-Leh_func_begin6         ## >> Call Site 1 <<
	.long	Lset10
Lset11 = Ltmp34-Ltmp33                  ##   Call between Ltmp33 and Ltmp34
	.long	Lset11
Lset12 = Ltmp58-Leh_func_begin6         ##     jumps to Ltmp58
	.long	Lset12
	.byte	7                       ##   On action: 4
Lset13 = Ltmp35-Leh_func_begin6         ## >> Call Site 2 <<
	.long	Lset13
Lset14 = Ltmp38-Ltmp35                  ##   Call between Ltmp35 and Ltmp38
	.long	Lset14
Lset15 = Ltmp53-Leh_func_begin6         ##     jumps to Ltmp53
	.long	Lset15
	.byte	7                       ##   On action: 4
Lset16 = Ltmp39-Leh_func_begin6         ## >> Call Site 3 <<
	.long	Lset16
Lset17 = Ltmp42-Ltmp39                  ##   Call between Ltmp39 and Ltmp42
	.long	Lset17
Lset18 = Ltmp43-Leh_func_begin6         ##     jumps to Ltmp43
	.long	Lset18
	.byte	5                       ##   On action: 3
Lset19 = Ltmp44-Leh_func_begin6         ## >> Call Site 4 <<
	.long	Lset19
Lset20 = Ltmp45-Ltmp44                  ##   Call between Ltmp44 and Ltmp45
	.long	Lset20
Lset21 = Ltmp46-Leh_func_begin6         ##     jumps to Ltmp46
	.long	Lset21
	.byte	11                      ##   On action: 6
Lset22 = Ltmp47-Leh_func_begin6         ## >> Call Site 5 <<
	.long	Lset22
Lset23 = Ltmp52-Ltmp47                  ##   Call between Ltmp47 and Ltmp52
	.long	Lset23
Lset24 = Ltmp53-Leh_func_begin6         ##     jumps to Ltmp53
	.long	Lset24
	.byte	7                       ##   On action: 4
Lset25 = Ltmp54-Leh_func_begin6         ## >> Call Site 6 <<
	.long	Lset25
Lset26 = Ltmp55-Ltmp54                  ##   Call between Ltmp54 and Ltmp55
	.long	Lset26
Lset27 = Ltmp64-Leh_func_begin6         ##     jumps to Ltmp64
	.long	Lset27
	.byte	7                       ##   On action: 4
Lset28 = Ltmp56-Leh_func_begin6         ## >> Call Site 7 <<
	.long	Lset28
Lset29 = Ltmp57-Ltmp56                  ##   Call between Ltmp56 and Ltmp57
	.long	Lset29
Lset30 = Ltmp58-Leh_func_begin6         ##     jumps to Ltmp58
	.long	Lset30
	.byte	7                       ##   On action: 4
Lset31 = Ltmp57-Leh_func_begin6         ## >> Call Site 8 <<
	.long	Lset31
Lset32 = Ltmp59-Ltmp57                  ##   Call between Ltmp57 and Ltmp59
	.long	Lset32
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset33 = Ltmp59-Leh_func_begin6         ## >> Call Site 9 <<
	.long	Lset33
Lset34 = Ltmp60-Ltmp59                  ##   Call between Ltmp59 and Ltmp60
	.long	Lset34
Lset35 = Ltmp61-Leh_func_begin6         ##     jumps to Ltmp61
	.long	Lset35
	.byte	0                       ##   On action: cleanup
Lset36 = Ltmp60-Leh_func_begin6         ## >> Call Site 10 <<
	.long	Lset36
Lset37 = Ltmp62-Ltmp60                  ##   Call between Ltmp60 and Ltmp62
	.long	Lset37
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset38 = Ltmp62-Leh_func_begin6         ## >> Call Site 11 <<
	.long	Lset38
Lset39 = Ltmp63-Ltmp62                  ##   Call between Ltmp62 and Ltmp63
	.long	Lset39
Lset40 = Ltmp64-Leh_func_begin6         ##     jumps to Ltmp64
	.long	Lset40
	.byte	7                       ##   On action: 4
Lset41 = Ltmp63-Leh_func_begin6         ## >> Call Site 12 <<
	.long	Lset41
Lset42 = Leh_func_end6-Ltmp63           ##   Call between Ltmp63 and Leh_func_end6
	.long	Lset42
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.byte	0                       ## >> Action Record 1 <<
                                        ##   Cleanup
	.byte	0                       ##   No further actions
	.byte	1                       ## >> Action Record 2 <<
                                        ##   Catch TypeInfo 1
	.byte	125                     ##   Continue to action 1
	.byte	1                       ## >> Action Record 3 <<
                                        ##   Catch TypeInfo 1
	.byte	125                     ##   Continue to action 2
	.byte	1                       ## >> Action Record 4 <<
                                        ##   Catch TypeInfo 1
	.byte	0                       ##   No further actions
	.byte	1                       ## >> Action Record 5 <<
                                        ##   Catch TypeInfo 1
	.byte	125                     ##   Continue to action 4
	.byte	1                       ## >> Action Record 6 <<
                                        ##   Catch TypeInfo 1
	.byte	125                     ##   Continue to action 5
                                        ## >> Catch TypeInfos <<
	.long	0                       ## TypeInfo 1
	.align	2

	.section	__TEXT,__textcoal_nt,coalesced,pure_instructions
	.private_extern	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.globl	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak_definition	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.align	4, 0x90
__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: ## @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
Leh_func_begin7:
	.cfi_lsda 16, Lexception7
## BB#0:
	pushq	%rbp
Ltmp78:
	.cfi_def_cfa_offset 16
Ltmp79:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp80:
	.cfi_def_cfa_register %rbp
	subq	$704, %rsp              ## imm = 0x2C0
	movb	%r9b, %al
	leaq	-528(%rbp), %r10
	leaq	-464(%rbp), %r11
	movq	%rdi, -480(%rbp)
	movq	%rsi, -488(%rbp)
	movq	%rdx, -496(%rbp)
	movq	%rcx, -504(%rbp)
	movq	%r8, -512(%rbp)
	movb	%al, -513(%rbp)
	movq	-480(%rbp), %rcx
	movq	%r11, -448(%rbp)
	movq	$-1, -456(%rbp)
	movq	-448(%rbp), %rdx
	movq	-456(%rbp), %rsi
	movq	%rdx, -432(%rbp)
	movq	%rsi, -440(%rbp)
	movq	-432(%rbp), %rdx
	movq	$0, (%rdx)
	movq	-464(%rbp), %rdx
	movq	%rdx, -528(%rbp)
	movq	%r10, -424(%rbp)
	cmpq	$0, %rcx
	jne	LBB7_2
## BB#1:
	movq	-480(%rbp), %rax
	movq	%rax, -472(%rbp)
	jmp	LBB7_29
LBB7_2:
	movq	-504(%rbp), %rax
	movq	-488(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, -536(%rbp)
	movq	-512(%rbp), %rax
	movq	%rax, -320(%rbp)
	movq	-320(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -544(%rbp)
	movq	-544(%rbp), %rax
	cmpq	-536(%rbp), %rax
	jle	LBB7_4
## BB#3:
	movq	-536(%rbp), %rax
	movq	-544(%rbp), %rcx
	subq	%rax, %rcx
	movq	%rcx, -544(%rbp)
	jmp	LBB7_5
LBB7_4:
	movq	$0, -544(%rbp)
LBB7_5:
	movq	-496(%rbp), %rax
	movq	-488(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, -552(%rbp)
	cmpq	$0, -552(%rbp)
	jle	LBB7_9
## BB#6:
	movq	-480(%rbp), %rax
	movq	-488(%rbp), %rcx
	movq	-552(%rbp), %rdx
	movq	%rax, -224(%rbp)
	movq	%rcx, -232(%rbp)
	movq	%rdx, -240(%rbp)
	movq	-224(%rbp), %rax
	movq	(%rax), %rcx
	movq	96(%rcx), %rcx
	movq	-232(%rbp), %rsi
	movq	-240(%rbp), %rdx
	movq	%rax, %rdi
	callq	*%rcx
	cmpq	-552(%rbp), %rax
	je	LBB7_8
## BB#7:
	leaq	-560(%rbp), %rax
	leaq	-216(%rbp), %rcx
	movq	%rcx, -200(%rbp)
	movq	$-1, -208(%rbp)
	movq	-200(%rbp), %rcx
	movq	-208(%rbp), %rdx
	movq	%rcx, -184(%rbp)
	movq	%rdx, -192(%rbp)
	movq	-184(%rbp), %rcx
	movq	$0, (%rcx)
	movq	-216(%rbp), %rcx
	movq	%rcx, -560(%rbp)
	movq	%rax, -8(%rbp)
	movq	$0, -480(%rbp)
	movq	-480(%rbp), %rax
	movq	%rax, -472(%rbp)
	jmp	LBB7_29
LBB7_8:
	jmp	LBB7_9
LBB7_9:
	cmpq	$0, -544(%rbp)
	jle	LBB7_24
## BB#10:
	leaq	-584(%rbp), %rax
	movq	-544(%rbp), %rcx
	movb	-513(%rbp), %dl
	movq	%rax, -72(%rbp)
	movq	%rcx, -80(%rbp)
	movb	%dl, -81(%rbp)
	movq	-72(%rbp), %rax
	movq	-80(%rbp), %rcx
	movb	-81(%rbp), %dl
	movq	%rax, -48(%rbp)
	movq	%rcx, -56(%rbp)
	movb	%dl, -57(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rcx
	movq	%rcx, -32(%rbp)
	movq	-32(%rbp), %rcx
	movq	%rcx, -24(%rbp)
	movq	-24(%rbp), %rcx
	movq	%rcx, -16(%rbp)
	movq	-56(%rbp), %rsi
	movq	%rax, %rdi
	movsbl	-57(%rbp), %edx
	callq	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc
	leaq	-584(%rbp), %rax
	movq	-480(%rbp), %rcx
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	movq	%rax, -160(%rbp)
	movq	-160(%rbp), %rsi
	movq	%rsi, -152(%rbp)
	movq	-152(%rbp), %rsi
	movq	%rsi, -144(%rbp)
	movq	-144(%rbp), %rsi
	movzbl	(%rsi), %edx
	andl	$1, %edx
	cmpl	$0, %edx
	movq	%rcx, -632(%rbp)        ## 8-byte Spill
	movq	%rax, -640(%rbp)        ## 8-byte Spill
	je	LBB7_12
## BB#11:
	movq	-640(%rbp), %rax        ## 8-byte Reload
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rcx
	movq	%rcx, -104(%rbp)
	movq	-104(%rbp), %rcx
	movq	%rcx, -96(%rbp)
	movq	-96(%rbp), %rcx
	movq	16(%rcx), %rcx
	movq	%rcx, -648(%rbp)        ## 8-byte Spill
	jmp	LBB7_13
LBB7_12:
	movq	-640(%rbp), %rax        ## 8-byte Reload
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rcx
	movq	%rcx, -128(%rbp)
	movq	-128(%rbp), %rcx
	movq	%rcx, -120(%rbp)
	movq	-120(%rbp), %rcx
	addq	$1, %rcx
	movq	%rcx, -648(%rbp)        ## 8-byte Spill
LBB7_13:                                ## %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit
	movq	-648(%rbp), %rax        ## 8-byte Reload
	movq	-544(%rbp), %rcx
	movq	-632(%rbp), %rdx        ## 8-byte Reload
	movq	%rdx, -248(%rbp)
	movq	%rax, -256(%rbp)
	movq	%rcx, -264(%rbp)
	movq	-248(%rbp), %rax
	movq	(%rax), %rsi
	movq	96(%rsi), %rsi
	movq	-256(%rbp), %rdi
Ltmp70:
	movq	%rdi, -656(%rbp)        ## 8-byte Spill
	movq	%rax, %rdi
	movq	-656(%rbp), %rax        ## 8-byte Reload
	movq	%rsi, -664(%rbp)        ## 8-byte Spill
	movq	%rax, %rsi
	movq	%rcx, %rdx
	movq	-664(%rbp), %rcx        ## 8-byte Reload
	callq	*%rcx
Ltmp71:
	movq	%rax, -672(%rbp)        ## 8-byte Spill
	jmp	LBB7_14
LBB7_14:                                ## %_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl.exit
	jmp	LBB7_15
LBB7_15:
	movq	-672(%rbp), %rax        ## 8-byte Reload
	cmpq	-544(%rbp), %rax
	je	LBB7_20
## BB#16:
	leaq	-304(%rbp), %rax
	movq	%rax, -288(%rbp)
	movq	$-1, -296(%rbp)
	movq	-288(%rbp), %rax
	movq	-296(%rbp), %rcx
	movq	%rax, -272(%rbp)
	movq	%rcx, -280(%rbp)
	movq	-272(%rbp), %rax
	movq	$0, (%rax)
	movq	-304(%rbp), %rax
	movq	%rax, -680(%rbp)        ## 8-byte Spill
## BB#17:
	leaq	-608(%rbp), %rax
	movq	-680(%rbp), %rcx        ## 8-byte Reload
	movq	%rcx, -608(%rbp)
	movq	%rax, -312(%rbp)
## BB#18:
	movq	$0, -480(%rbp)
	movq	-480(%rbp), %rax
	movq	%rax, -472(%rbp)
	movl	$1, -612(%rbp)
	jmp	LBB7_21
LBB7_19:
Ltmp72:
	movl	%edx, %ecx
	movq	%rax, -592(%rbp)
	movl	%ecx, -596(%rbp)
Ltmp73:
	leaq	-584(%rbp), %rdi
	callq	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev
Ltmp74:
	jmp	LBB7_23
LBB7_20:
	movl	$0, -612(%rbp)
LBB7_21:
	leaq	-584(%rbp), %rdi
	callq	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev
	movl	-612(%rbp), %eax
	movl	%eax, %ecx
	subl	$1, %ecx
	movl	%eax, -684(%rbp)        ## 4-byte Spill
	movl	%ecx, -688(%rbp)        ## 4-byte Spill
	je	LBB7_29
	jmp	LBB7_33
LBB7_33:
	movl	-684(%rbp), %eax        ## 4-byte Reload
	testl	%eax, %eax
	jne	LBB7_32
	jmp	LBB7_22
LBB7_22:
	jmp	LBB7_24
LBB7_23:
	jmp	LBB7_30
LBB7_24:
	movq	-504(%rbp), %rax
	movq	-496(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, -552(%rbp)
	cmpq	$0, -552(%rbp)
	jle	LBB7_28
## BB#25:
	movq	-480(%rbp), %rax
	movq	-496(%rbp), %rcx
	movq	-552(%rbp), %rdx
	movq	%rax, -328(%rbp)
	movq	%rcx, -336(%rbp)
	movq	%rdx, -344(%rbp)
	movq	-328(%rbp), %rax
	movq	(%rax), %rcx
	movq	96(%rcx), %rcx
	movq	-336(%rbp), %rsi
	movq	-344(%rbp), %rdx
	movq	%rax, %rdi
	callq	*%rcx
	cmpq	-552(%rbp), %rax
	je	LBB7_27
## BB#26:
	leaq	-624(%rbp), %rax
	leaq	-384(%rbp), %rcx
	movq	%rcx, -368(%rbp)
	movq	$-1, -376(%rbp)
	movq	-368(%rbp), %rcx
	movq	-376(%rbp), %rdx
	movq	%rcx, -352(%rbp)
	movq	%rdx, -360(%rbp)
	movq	-352(%rbp), %rcx
	movq	$0, (%rcx)
	movq	-384(%rbp), %rcx
	movq	%rcx, -624(%rbp)
	movq	%rax, -392(%rbp)
	movq	$0, -480(%rbp)
	movq	-480(%rbp), %rax
	movq	%rax, -472(%rbp)
	jmp	LBB7_29
LBB7_27:
	jmp	LBB7_28
LBB7_28:
	movq	-512(%rbp), %rax
	movq	%rax, -400(%rbp)
	movq	$0, -408(%rbp)
	movq	-400(%rbp), %rax
	movq	24(%rax), %rcx
	movq	%rcx, -416(%rbp)
	movq	-408(%rbp), %rcx
	movq	%rcx, 24(%rax)
	movq	-480(%rbp), %rax
	movq	%rax, -472(%rbp)
LBB7_29:
	movq	-472(%rbp), %rax
	addq	$704, %rsp              ## imm = 0x2C0
	popq	%rbp
	ret
LBB7_30:
	movq	-592(%rbp), %rdi
	callq	__Unwind_Resume
LBB7_31:
Ltmp75:
	movl	%edx, %ecx
	movq	%rax, %rdi
	movl	%ecx, -692(%rbp)        ## 4-byte Spill
	callq	___clang_call_terminate
LBB7_32:
	.cfi_endproc
Leh_func_end7:
	.section	__TEXT,__gcc_except_tab
	.align	2
GCC_except_table7:
Lexception7:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	155                     ## @TType Encoding = indirect pcrel sdata4
	.asciz	 "\274"                 ## @TType base offset
	.byte	3                       ## Call site Encoding = udata4
	.byte	52                      ## Call site table length
Lset43 = Leh_func_begin7-Leh_func_begin7 ## >> Call Site 1 <<
	.long	Lset43
Lset44 = Ltmp70-Leh_func_begin7         ##   Call between Leh_func_begin7 and Ltmp70
	.long	Lset44
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset45 = Ltmp70-Leh_func_begin7         ## >> Call Site 2 <<
	.long	Lset45
Lset46 = Ltmp71-Ltmp70                  ##   Call between Ltmp70 and Ltmp71
	.long	Lset46
Lset47 = Ltmp72-Leh_func_begin7         ##     jumps to Ltmp72
	.long	Lset47
	.byte	0                       ##   On action: cleanup
Lset48 = Ltmp73-Leh_func_begin7         ## >> Call Site 3 <<
	.long	Lset48
Lset49 = Ltmp74-Ltmp73                  ##   Call between Ltmp73 and Ltmp74
	.long	Lset49
Lset50 = Ltmp75-Leh_func_begin7         ##     jumps to Ltmp75
	.long	Lset50
	.byte	1                       ##   On action: 1
Lset51 = Ltmp74-Leh_func_begin7         ## >> Call Site 4 <<
	.long	Lset51
Lset52 = Leh_func_end7-Ltmp74           ##   Call between Ltmp74 and Leh_func_end7
	.long	Lset52
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.byte	1                       ## >> Action Record 1 <<
                                        ##   Catch TypeInfo 1
	.byte	0                       ##   No further actions
                                        ## >> Catch TypeInfos <<
	.long	0                       ## TypeInfo 1
	.align	2

	.section	__TEXT,__textcoal_nt,coalesced,pure_instructions
	.globl	__ZN1AC2Ev
	.weak_definition	__ZN1AC2Ev
	.align	4, 0x90
__ZN1AC2Ev:                             ## @_ZN1AC2Ev
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp83:
	.cfi_def_cfa_offset 16
Ltmp84:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp85:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	popq	%rbp
	ret
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	 "show()"

L_.str1:                                ## @.str1
	.asciz	 "const show()"

	.section	__TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support

.subsections_via_symbols

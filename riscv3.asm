main:
	addi a6,zero,1
main_input_n:
	li a7,5
	ecall
	bge zero,a0,main_input_n #testa se N>=1
	add a1,zero,a0 #passa o valor de N para a1
main_input_k:
	ecall
	bge zero,a0,main_input_k #testa se K>=1
	blt a1,a0,main_input_k #testa se K<=N
	add a2,zero,a0 #passa o valor de K para a2
	jal ST_2
	add a0,a3,zero
	li a7,1
	ecall
	nop
	ebreak
ST_2:
	beq a6,a1,return
	addi sp,sp,-16
	sw ra,0(sp)
	sw a1,4(sp)
	sw a2,8(sp)
	addi a1,a1,-1
	jal ST_2 #loopando (N-1,K)
	lw a1,4(sp)
	lw a2,8(sp)
	lw ra,0(sp)
	mul a3,a2,a3
	sw a3,12(sp)
	addi a1,a1,-1
	addi a2,a2,-1
	jal ST_2 #loopando (N-1,K-1)
	lw a1,4(sp)
	lw a2,8(sp)
	lw ra,0(sp)
	lw a4,12(sp)
	add a3,a4,a3
	addi sp,sp,16
	ret
return:
	beq a2,a6,ret_1
	add a3,zero,zero
	ret
ret_1:
	add a3,zero,a6
	ret
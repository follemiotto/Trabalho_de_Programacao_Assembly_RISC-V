main:
	addi a6,zero,1           #salvo valor 1 para uso posterior no codigo
main_input_n:                    #loop ate input de numero valido para N
	li a7,5                  #seta instrucao de li para input de inteiro
	ecall                    #realiza o input do teclado
	bge zero,a0,main_input_n #testa se N>=1
	add a1,zero,a0           #passa o valor de N para a1
main_input_k:                    #loop ate input de numero valido para K
	ecall                    #realiza o input do teclado
	bge zero,a0,main_input_k #testa se K>=1
	blt a1,a0,main_input_k   #testa se K<=N
	add a2,zero,a0           #passa o valor de K para a2
	jal ST_2                 #pula para a funcao principal
	add a0,a3,zero           #passa o resultado para a0
	li a7,1                  #seta instrucao de li para output de inteiro
	ecall                    #realiza o output do resultado
	nop 
	ebreak
ST_2:
	beq a6,a1,return         #testa se N chegou a 1, aka fim do trajeto da pilha, retorno a partir
	addi sp,sp,-16           #avanca posicao da pilha
	sw ra,0(sp)              #salva o endereco na pilha
	sw a1,4(sp)              #salva o valor de N na pilha
	sw a2,8(sp)              #salva o valor de K na pilha
	addi a1,a1,-1            #diminui N em 1 para a primeira recursao ST_2(N-1,K)
	jal ST_2                 #loopando (N-1,K)
	lw a1,4(sp)              #chama N da pilha apos realizar a primeira recursao ate a maior profundidade
	lw a2,8(sp)              #chama K da pilha
	lw ra,0(sp)              #chama o endereco da pilha
	mul a3,a2,a3             #realiza a multiplicacao de K*ST_2(N-1,K)
	sw a3,12(sp)             #salva o resultado da multiplicacao na pilha
	addi a1,a1,-1            #diminui N em 1 para a segunda recursao ST_2(N-1,K-1)
	addi a2,a2,-1            #diminui K em 1 para a segunda recursao ST_2(N-1,K-1)
	jal ST_2                 #loopando (N-1,K-1)
	lw a1,4(sp)              #chama N da pilha apos realizar a segunda recursao ate a maior profundidade
	lw a2,8(sp)              #chama K da pilha
	lw ra,0(sp)              #chama o endereco da pilha
	lw a4,12(sp)             #chama o resultado de multiplicacao da pilha
	add a3,a4,a3             #realiza a operacao de soma em K*ST_2(N-1,K)+ST_2(N-1,K-1)
	addi sp,sp,16            #volta posicao da pilha
	ret                      #retorna para a recursao que chamou, exceto se for o final do programa onde retorna para a chamada em main_input_k
return:
	beq a2,a6,ret_1          #testa se K=1, entao realizando a condicao ST_2(1,1)=1
	add a3,zero,zero         #poe o resultado em 0 pois ST_2(1,k)=0; K>1
	ret                      #retorna para a recursao que chamou
ret_1:
	add a3,zero,a6           #poe o resultado em 1 pois ST_2(1,1)=1
	ret                      #retorna para a recursao que chamou

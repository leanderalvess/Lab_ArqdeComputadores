################################################################################################################################################
			#Aluno: Leander Alves
			#Laboratório de Arquitetura de Computadores 
			#Primeira atividade
################################################################################################################################################
#INICIO DO PROGRAMA 

#declaracao das variáveis 
.data	
	TextPreco: .asciiz "Insira o preco: "
	TextQuant: .asciiz "Insira a quantidade: "
	TextResult: .asciiz "R$:"	
	preco: .float 0.0	#variavel do preco em float
	quant: .float 0		#variavel da quantidade em float
	resultado: .float 0.00	#variavel do resultado em float
.text


.globl main
main:
	#imprimir o texto de preco
	li $v0, 4
	la $a0, TextPreco
	syscall

	li $v0, 6		#recebe o preco por input
	syscall			#valor recebido estará em $f0
	
	s.s $f0, preco 		#guarda o input preco	
	la $a0, preco 		#carregando o endereço de preco (ponteiro)
	l.s $f1, 0($a0) 	#a0 --> preco
	
	#imprimir o texto de quantidade
	li $v0, 4
	la $a0, TextQuant
	syscall
	
	li $v0, 6		#recebe a quantidade por input
	syscall			#valor recebido estará em $f0

	s.s $f0, quant 		#guarda o input quantidade
	la $a1, quant		#carrega o enderdeço de quant (ponteiro)
	l.s $f3, 0($a1)		#a1 --> quant
	
	#multiplicando
	mul.s $f4, $f1, $f3 	#f4 = f1 * f3
	s.s $f4, resultado 	#guarda o resultado da multiplicacao em float na variavel resultado

	#imprime "R$:"
	li $v0, 4
	la $a0, TextResult
	syscall
	
	#imprimindo o resultado
	li $v0, 2		#chama print_float no code 2
	l.s $f12, resultado	#imprime o multiplicado float
	syscall
	
	#finalizando o programa
	li $v0, 10
	syscall

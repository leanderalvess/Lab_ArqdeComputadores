.data	
	preco: .float 0.00	
	quantidade: .float 0.00	
	text1: .asciiz "Insira o preco"
	text2: .asciiz "Insira a quantidade"	
.text

main:
	#imprimir o texto
	li $v0, 4
	la $a0, text1
	syscall
	li $v0, 6		#recebe o input
	syscall			
	s.s $f0, preco 		#guarda o input	
	la $a0, preco 		#carrega o endereço
	l.s $f1, 0($a0) 	
	
	#imprimir o texto
	li $v0, 4
	la $a0, text2
	syscall
	li $v0, 6		#recebe o input
	syscall			
	s.s $f0, quantidade	#guarda o input
	la $a1, quantidade	#carrega o enderdeço
	l.s $f3, 0($a1)		
	
	#multiplicando
	mul.s $f4, $f1, $f3 	
	s.s $f4, preco	 	#guarda o resultado da multiplicacao
	
	#imprime o resultado
	li $v0, 2		
	l.s $f12, preco	
	syscall
	
# Escreva um programa que lê do usuário o preço (float) de uma caixa  de leite -> $v0, passando 6, como argumento $f0 para ler e armazenar; e $v0,passando 2 como argumento $f12 para imprimir.
# e a quantidade de caixas  -> $v0, passando 5, como argumento $v0 para ler e armazenar; e $v0,passando 1 como argumento $a0 para imprimir.
# e imprime o preço  total a ser pago  pelo o usuário. 

.globl main
.data
	start: 	.asciiz  "Informe as notas de 0 a 10:\n"
	n1: 	.asciiz  "Informe a nota 1: "
	n2: 	.asciiz   "Informe a nota 2: "
	ap: 	.asciiz   "APROVADO"
	rp: 	.asciiz   "REPROVADO"
	mf: 	.asciiz   "\nSua Media Final foi: "
	nota1:		.float 0.00		#variavel da 1ªnota em float
	nota2:		.float 0.00		#variavel da 1ªnota em float
	resultado: 	.float 0.00		#variavel do resultado em float
	dividir:	.float 2.00		#variavel de média passando 2.0
	media:		.float 5.00		#variavel de média passando 2.0
.text

main:
#	Primeira nota
	li $v0,4			#Mandando as instruções básicas
	la $a0, start
	syscall
	li $v0,4			#pedindo a primeira nota
	la $a0, n1
	syscall
	li $v0, 6			#lendo a nota1
	syscall 
	s.s $f0, nota1 			#guarda o input preco	
	la $a0, nota1 			#carregando o endereço de preco (ponteiro)
	l.s $f1, 0($a0) 		#a0 --> preco

#	Segunda nota
	li $v0,4			#pedindo a segunda nota
	la $a0, n2
	syscall
	li $v0, 6			#lendo a nota2
	syscall 
	s.s $f0, nota2 			#guarda o input preco	
	la $a1, nota2			#carregando o endereço de preco (ponteiro)
	l.s $f2, 0($a1) 		#a0 --> preco

#	Cálculos 
	l.s $f3, dividir		#guarda no registrador o valor 2.00 (vindo de dividir) para ser divisor
	add.s $f4, $f1, $f2		#soma as duas notas em float ponto único
	div.s $f5, $f4, $f3		#faz a divisão por 2 (media simples)
	s.s $f5, resultado 		#guarda o resultado da multiplicacao em float na variavel resultado
	
#	Comparações
	l.s $f6, media			#guarda no registrador o valor 5.00 (vindo de media) para ser referencia da media
	c.lt.s $f5, $f6			#Compara se $f4 é menor $f6 = 5.00. Se for é setado como 1, se não, 0.
	bc1t imprimereprovado 		#Se o resultado for 1, é true/verdadeiro, então está reprovado
	bc1f imprimeaprovado		#Se o resultado for 0, é false/falso, então está aprovado
	
	imprimeaprovado:	#caso a nota final seja 5 ou maior que 5;
		li $v0, 4			
		la $a0, ap
		syscall 
		
		li $v0, 4
		la $a0, mf
		syscall
		
		li $v0, 2
		l.s $f12, resultado
		syscall
		
		li $v0, 10	
		syscall

	
	imprimereprovado:	#caso a nota final seja menor que 5
		li $v0, 4	
		la $a0, rp
		syscall 
		
		li $v0, 4
		la $a0, mf
		syscall
		
		li $v0, 2
		l.s $f12, resultado
		syscall
	
		li $v0, 10	#encerrando o programa
		syscall
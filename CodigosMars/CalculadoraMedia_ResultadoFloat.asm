.globl main
.data
	start: .asciiz  "Informe as notas de 0 a 10:\n"
	n1: .asciiz  "Informe a nota 1: "
	n2: .asciiz   "Informe a nota 2: "
	ap: .asciiz   "APROVADO"
	rp: .asciiz   "REPROVADO"
	mf: .asciiz   "\nSua Media Final foi: "
		resultado: .float 0.00	#variavel do resultado em float
.text

main:
	li $v0,4	#Mandando as instruções básicas
	la $a0, start
	syscall
	li $v0,4	#pedindo a primeira nota
	la $a0, n1
	syscall
	li $v0, 5	#lendo a nota
	syscall 
	move $t0, $v0	#movendo nota
	
	#converte variavel 1 para float
	addi $sp, $sp, -12	#Cria um ponteiro de pilha
	sw $t0, 0($sp)		#armzena o input1 no topo da stack
	lwc1 $f2, 0($sp) 	#carrega o endereço de memória da palavra no coprocessador
	cvt.s.w $f0, $f2	#converte word para um float de precisão única.
	
	li $v0,4	#pedindo a segunda nota
	la $a0, n2
	syscall
	li $v0, 5	#lendo a segunda nota
	syscall 
	move $t1, $v0	#novo registro de t1
	
	#converte variavel 2 para float
	sw $t1, 4($sp)		#armzena o input2 no topo da stack
	lwc1 $f4, 4($sp) 	#carrega o endereço de memória da palavra no coprocessador
	cvt.s.w $f6, $f4	#converte word para um float de precisão única.
	
	li $s0, 2	#divisor de media
	
	#converte media para float
	sw $s0, 0($sp)		#armzena o input2 no topo da stack
	lwc1 $f10, 0($sp) 	#carrega o endereço de memória da palavra no coprocessador
	cvt.s.w $f12, $f10	#converte word para um float de precisão única.	
	add.s $f8, $f0, $f6	#soma as duas notas em float ponto único
	div.s $f8, $f8, $f12	#faz a divisão por 2 (media simples)
	s.s $f8, resultado 	#guarda o resultado da multiplicacao em float na variavel resultado
	
	#realiza a soma novamente para poder fazer a rotina original
	add $s1, $t0, $t1	#soma as duas notas
	div $s1, $s0		#faz a divisão por 2 (media simples)
	mflo $s3	#nota final
	li $s5, 5	#linha de media	
	bge $s3, $s5, imprimeaprovado	#aprovado
	blt $s3, $s5, imprimereprovado 	#reprovado
	
	imprimeaprovado:
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

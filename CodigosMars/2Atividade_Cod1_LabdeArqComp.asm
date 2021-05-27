################################################################################################################################################
			#Aluno: Leander Alves
			#Laborat�rio de Arquitetura de Computadores 
			#Segunda atividade - 1� algoritmo: "Qual numero � o maior?"
################################################################################################################################################
#INICIO DO PROGRAMA 

#declaracao das vari�veis 
.data 
	mensagem1: .asciiz "Entre com o 1� valor: " 
    	mensagem2: .asciiz "Entre com o 2� valor: "
    	mensagem3: .asciiz "Entre com o 3� valor: "
    	resultado1: .asciiz "O 1� valor � o maior numero: "
    	resultado2: .asciiz "O 2� valor � o maior numero: "
   	resultado3: .asciiz "O 3� valor � o maior numero: "
    	numero1: .word 1					#variavel do 1� numero
    	numero2: .word 1					#variavel do 2� numero
    	numero3: .word 1					#variavel do 3� numero
    
.text   
	#imprime o texto de mensagem1, recebe o numero1 por input e salva o valor na memoria
	li $v0, 4
	la $a0, mensagem1
	syscall
	li $v0, 5
    	syscall
    	sw $v0, numero1 			
	
	#imprime o texto de mensagem2, recebe o numero2 por input e salva o valor na memoria
	li $v0, 4
	la $a0, mensagem2
	syscall
	li $v0, 5
    	syscall
    	sw $v0, numero2
    
	#imprime o texto de mensagem3, recebe o numero3 por input e salva o valor na memoria
    	li $v0, 4
	la $a0, mensagem3
	syscall
	li $v0, 5
    	syscall
    	sw $v0, numero3
    	
    	#carregando o endere�o de numero[1,2,3] na memoria dos registradores (ponteiro)
    	lw $t0, numero1	#t0 --> numero1
	lw $t1, numero2 #t1 --> numero2
	lw $t2, numero3 #t2 --> numero3
		
	#Faz os testes de compara��es se � maior ou igual. 
	bge $t0, $t1, teste1 	#Separa para a instru��o em teste1 se $t0 for maior ou igual a $t1
	bge $t1, $t2, teste2 	#Separa para a instru��o em teste3 se $t1 for maior ou igual a $t2
	bge $t2, $t1, teste3 	#Separa para a instru��o em teste4 se $t2 for maior ou igual a $t1

teste1:
	bge $t2, $t0, teste3	#Separa para a instru��o em teste2 se $t0 for maior ou igual a $t1, e se, $t2 for maior ou igual a $t0;
	bge $t0, $t2, teste4 	#Separa para a instru��o em teste2 se $t0 for maior ou igual a $t1, e se, $t0 for maior ou igual a $t2;
	
teste4:	
	li $v0, 4
	la $a0, resultado1 
	syscall
	li $v0, 1			
	lw $a0, numero1 	#define em $a0 o numero1 sendo maior
	syscall
	j fim			#Pula o programa para o final do c�digo

teste2:	
	li $v0, 4
	la $a0, resultado2 
	syscall
	li $v0, 1		
	lw $a0, numero2		#define em $a0 o numero2 sendo maior
	syscall
	j fim			#Pula o programa para o final do c�digo

teste3:	
	li $v0, 4
	la $a0, resultado3
	syscall
	li $v0, 1		
	lw $a0, numero3		#define em $a0 o numero3 sendo maior
	syscall
	j fim			#Pula o programa para o final do c�digo
fim:
	#finaliza o programa
	li $v0, 10
	syscall

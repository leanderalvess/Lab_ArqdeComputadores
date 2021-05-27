.data
	mensagem1: 	.asciiz "Digite um numero inteiro: "
	mensagem2: 	.asciiz "O resultado do fatorial é: "
	mensagem3: 	.asciiz "Você deseja reiniciar com outro numero? [s/n]: "
	espaco: 	.asciiz "\n"
	bye: 		.asciiz "  Bye, bye, birdie \n  I'm gonna miss you :'("
	mensagemErro1: 	.asciiz "ERRO: O número é maior que 12!"
	mensagemErro2: 	.asciiz "ERRO: Digite 's' para sim ou 'n' para não reiniciar o algortimo!"
.text

.globl main

main:
	jal enter			#Salta para enter deixando $ra como retorno 
	li      $v0, 4            		
	la      $a0, mensagem1		#imprime a mensagem da variavel mensagem1
	syscall                 
	li      $v0, 5          	#Lê o input mandado pelo user  		
	syscall 
	
  	bge $v0, 13, error1     	#Se $v0 for maior ou igual a 13, o programa se direciona a error
  
  	move    $t0, $v0         	#armazena o input em $t0
  	move    $a0, $t0         	#move o input para $a0
  	addi    $sp, $sp, -12     	#Cria um ponteiro de pilha
  	sw      $t0, 0($sp)      	#armzena o input no topo da stack
  	sw      $ra, 8($sp)       	#armazena o contador no fundo da pilha
  	jal     fatorial         	#configurando $ra, para o contador do programa como endereço de retorno e então pula para a fatorial.

  #Parte final de fatorial volta pra cá
  	lw      $s0, 4($sp)       	#carrega o valor final que está 4($sp) em $s0
  	li      $v0, 4            
  	la      $a0, mensagem2		#imprime a mensagem da variavel mensagem2
  	syscall                 
 	 
 	move    $a0, $s0         	#move o valor final de $s0 para $a0
  	li      $v0, 1            	#imprime o valor final
  	syscall                   
 	
  	addi    $sp, $sp, 12      	#finaliza com o ponteiro da pilha mexido dentro de main
 	
	j repeteOUfim			#salta pro user decidir se repete ou finaliza  

error1: #mensagem de erro1, caso o user digite um numero maior de 12
	li $v0, 4
	la $a0, mensagemErro1		#imprime a mensagem da variavel mensagemErro1
	syscall
	j repeteOUfim			#salta pro user decidir se repete ou finaliza  
	
error2: #mensagem de erro2, caso o user seja engraçadinho e coloque algo além de s/n.
	li $v0, 4
	la $a0, mensagemErro2		#imprime a mensagem da variavel mensagemErro1
	syscall
	j repeteOUfim			#salta pro user decidir se repete ou finaliza  

enter:	#simplesmente para dar uma linha em branco. É para aparência
	li $v0, 4
	la $a0, espaco
	syscall
	jr $ra
	
fatorial: #realiza o calculo fatorial 
  #Neste começo ainda estamos na pilha de main 
	lw      $t0, 0($sp)      	#carrega a entrada do topo da pilha em $t0
  	beq     $t0, 0, Coloca1		#Se $t0 for igual a 0, pula para Coloca1
  	addi    $t0, $t0, -1     	#subtrai 1 de $t0 , caso ele não for igual a 0. ($t0 = $t0 - 1)

  #Aqui começa a parte recursiva, no qual criamos uma segunda pilha para esta chamada 	 
  	addi    $sp, $sp, -12     	#Cria um ponteiro de pilha
  	sw      $t0, 0($sp)      	#armzena o numero atual no topo da pilha
  	sw      $ra, 8($sp)       	#armazena o contador no fundo da pilha
  	jal     fatorial         	#chamada recursiva

  #Coloca1 volta pra cá
  	lw      $ra, 8($sp)       	#carrega o valor de 8($sp) - contador - em $ra
  	lw      $t1, 4($sp)       	#carrega o valor de retorno 4($sp) em $t1
  	lw      $t2, 12($sp)      	#carrega o valor inicial em $t2
  	mul     $t3, $t1, $t2     	#multiplica o valor de $t1 pelo $t2, armazena em $t3. 
 	sw      $t3, 16($sp)      	#rmazena o resultado final de $t3 em 16($sp)
  
  	addi    $sp, $sp, 12      	#finaliza com o ponteiro da pilha mexido dentro de fatorial
  	jr      $ra              	#salta para a parte final de main, endereço está em $ra 

Coloca1: #Coloca 1 na variavel de retorno
  	li      $t0, 1            	#carregue 1 em $ t0
  	sw      $t0, 4($sp)       	#armazena 1 no registro de valor de retorno
  	jr      $ra               	#salta para a instrução cujo endereço está em $ra

repeteOUfim: #user escolhe se quer continuar ou sair do algoritmo através de "s"/"n"
	jal enter			#Salta para enter deixando $ra como retorno 
	li $v0, 4
	la $a0, mensagem3		#imprime a mensagem da variavel mensagem3
	syscall
	li $v0, 12			#lê o input caracter do user
	syscall
	
	move $v1, $v0			#move a entrada de $v0 para #v1, somente para não dar choque futuro
	
	li $t0, 's'			#valor previsto de resposta 's' é inserido em $t0
	li $t1, 'n'			#valor previsto de resposta 'n' é inserido em $t1
	
	jal enter			#Salta para enter deixando $ra como retorno 
	
	beq $v1, $t0, main		#compara $t0 com $v1, caso for igual, manda para main.
	bne $v1, $t1, error2		#compara $t1 com $v1, caso for diferente, manda para error2.
 	j goodbye			#salta para o final

goodbye:	#criada só para fazer graça, eu queria imprimir uma mensagem de adeus.
	li $v0, 4
	la $a0, bye			#imprime a mensagem da variavel bye
	syscall
	li $v0, 10			#finaliza o programa
	syscall

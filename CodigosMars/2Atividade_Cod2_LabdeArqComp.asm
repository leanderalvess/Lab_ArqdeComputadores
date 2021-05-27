################################################################################################################################################
			#Aluno: Leander Alves
			#Laboratório de Arquitetura de Computadores 
			#Segunda atividade - 2º algoritmo: "Verificador de Par/Impar" 
################################################################################################################################################
#INICIO DO PROGRAMA 

#declaracao das variáveis 
.data 
       	numero: .word 1		#variavel do numero
       	resto: .word 1		#variavel do resto
       	zero: .word 0		#variavel do numero 0
	mensagemInicial: .asciiz "Insira o valor: "
       	mensagemPar: .asciiz "O numero é par"
       	mensagemImpar: .asciiz "O numero é impar"
    	    	
    
.text   #imprime o texto de mensagemInicial, recebe o numero por input e salva o valor na memoria
	li $v0, 4
	la $a0, mensagemInicial
	syscall
	li $v0, 5
    	syscall
    	sw $v0, numero
    	
    	
    	lw $t1, numero	#carregando o endereço de numero na memoria dos registradores (ponteiro)
    	li $t2, 2	#carregando 2, em $t2   	
    	div $t1, $t2	#divide o valor inserido por 2
    	mfhi $t0	#Move from  HI register: Set $t0 to contents of HI, divide operation.
    	sw $t0, resto	#salva o resto da divisão na memoria

       	#carrega os valores
    	lw $t0, resto
    	lw $t1, zero
 
    	beq $t0, $t1, par	#Separa para a instrução em par se $t0 e $t1 são iguais

#Impar: se resto!=0, então o valor é impar.
    	li $v0, 4	 
	la $a0, mensagemImpar
      	syscall	
      	j fim
    							
par: 	#se resto=0, então o valor é par
  	li $v0, 4		
	la $a0, mensagemPar
	syscall 
	j fim
fim:
	#finaliza o programa
	li $v0, 10
	syscall
		
      	
		
	

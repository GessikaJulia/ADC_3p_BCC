.data #declara variaveis.

	.macro pegarNum(%local) #informar que isso é um argumento, tipo uma função.
		
		.data #declara variaveis.
			text: .asciiz "Digite um numero:"  #cria uma variável e armazena a string.
		.text #onde localiza o codigo.
			li $v0, 4 #prepara o registrador $v0 para chamar no sistema impressão de texto(4).Carrega um valor imediato para o registrador.
			la $a0, text #aloca no endereço a variável e armazenada no registrador (memória).
			syscall #Solicita que ele execute uma instrução especifica. 
			
			li $v0, 5 #prepara o registrador $v0 para a chamada do sistema para ler um inteiro da entrada padrão (5).Carrega um valor imediato para o registrador.
			syscall #Solicita que ele execute uma instrução especifica. 
			move %local,$v0 #copia o valor de um registrador(%local) para outro registrador($v0).
			
	.end_macro #final da função
	.macro printr(%r)#informar que isso é um argumento, tipo uma função.
		
		.data #declara variaveis.
			msg: .asciiz "A resposta é:" #cria uma variável e armazena a string.
			
		.text #onde localiza o codigo.
			li $v0, 4 #prepara o registrador $v0 para chamar no sistema impressão de texto(4).Carrega um valor imediato para o registrador.
			la $a0, msg #aloca no endereço a variável e armazenada no registrador (memória).
			syscall #Solicita que ele execute uma instrução especifica. 
			
			li $v0, 1 #preparando o registrador($v0)para chamar no sistema a impressão de um caractere(1).
			la $a0,(%r) #aloca no registrador $a0, a o valor da macro (%r).
			
			syscall #Solicita que ele execute uma instrução especifica. 
	.end_macro #final da função		
	
.text #onde localiza o codigo.

pegarNum($t0)#Chama a macro pegarNum, que aloca o valor no registrador escolhido($t0).
pegarNum($t1)#Chama a macro pegarNum é aloca o valoor no registrador escolhido($t1).
pegarNum($t2)#Chama a macro pegarNum é aloca o valoor no registrador escolhido($t2).
pegarNum($t3)#Chama a macro pegarNum é aloca o valoor no registrador escolhido($t3).

add $t4, $t0, $t1 #soma o valor de t0 e t1 e aloca no t4.
add $t4, $t4, $t2 #soma o valor de t4 e t2 e aloca no t4.
add $t4, $t4, $t3 #soma o valor de t4 e t3 e aloca no t4.

printr($t4) #Chama a macro printr que mostra na tela o resultado das somas.

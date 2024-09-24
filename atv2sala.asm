.data #declara variaveis.

	.macro print(%str) #informar que isso é um argumento, tipo uma função.
		.data #declara variaveis.
		msg: .asciiz %str #armazena a string no msg.
	
		.text #onde localiza o codigo.
		li $v0, 4 #prepara o registrador $v0 para chamar no sistema impressão de texto(4).Carrega um valor imediato para o registrador.
		la $a0, msg #aloca no endereço a variável e armazenada no registrador (memória).
		syscall #Solicita que ele execute uma instrução especifica.
	
	.end_macro #final da função.
	
	.macro pega_int(%int)#informar que isso é um argumento, tipo uma função.
		.data #declara variaveis.
	
		.text #onde localiza o codigo.
		li $v0, 5 #prepara o registrador $v0 para a chamada do sistema para ler um inteiro da entrada padrão (5).Carrega um valor imediato para o registrador.
		syscall #Solicita que ele execute uma instrução especifica.
		move %int, $v0 #copia o valor de um registrador(%int) para outro registrador($v0).
	
	.end_macro #final da função.

.text #onde localiza o codigo.

j ano #salta pro bloco ano.

condicao: #bloco chamado condicao.
	beq $t0,$zero, finaliza #Verifica se o valor no registrador $t0 é igual a zero. Se for, ele salta para o bloco finaliza.

	bgt $t0, $zero, verdade #Verifica se o valor no registrador $t0 é maior que zero. Se for, ele salta para o bloco verdade.

	blt $t0, $zero, invalido #Verifica se o valor no registrador $t0 é menor que zero. Se for, ele salta para o bloco invalido.

finaliza: #bloco chamado finaliza.
	print("Fim do programa\n") #Chama o macro print para imprimir a string.
	li $v0, 10 #Prepara o registrador $v0 para encerrar o programa(10).Carrega um valor imediato para o registrador.
	syscall #Solicita que ele execute uma instrução especifica.

invalido: #bloco chamado invalido.
	print("Valor invalido!\n") #Chama o macro print para imprimir a string.
	jal ano #salta pro bloco ano.

verdade: #bloco chamado verdade.
	bgt $t0, 2008, menor #Verifica se o valor no registrador $t0 é maior que 2008. Se for, ele salta para o bloco menor.
	ble $t0, 2008, maior #Verifica se o valor no registrador $t0 é menor ou igual a 2008. Se for, ele salta para o bloco menor.

menor: #bloco chamado menor.
	print("Não está apto para votar!\n") #Chama o macro print para imprimir a string.
	jal ano #salta pro bloco ano.

maior: #bloco chamado maior.
	print("Está apto para votar!\n") #Chama o macro print para imprimir a string.
	jal ano #salta pro bloco ano.

ano: #bloco chamado ano.
	print("Insira seu ano de nascimento:\n")
	pega_int($t0)#Chama a macro pega_int, que aloca o valor no registrador escolhido($t0).
	jal condicao #salta pro bloco condicao.

.data
.macro print(%str)
	.data
	msg: .asciiz %str
	.text
	li $v0, 4
	la $a0, msg
	syscall
.end_macro

.macro save_int(%int)
	.text
	li $v0, 5
	syscall
	move %int, $v0
.end_macro

.macro print_int(%printint)
	.text
	li $v0, 1
	la $a0, (%printint)
	syscall
.end_macro

.text

choices:
	print("\n1-INSERIR\n2-REMOVER ITEM\n3-CONSULTAR ITEM\n4-ENCERRAR OPERAÇÃO\n")
	save_int($t0)
	beq $t0, 1, inserir
	beq $t0, 2, remover
	beq $t0, 3, consultar
	beq $t0, 4, encerrar
	jal erro_entrada

inserir:
	print("Digite a quantidade de inserção do item: ")
	save_int($t2)
	blez $t2, erro_entrada
	add $t1, $t2, $t1
	jal choices

remover:
	print("Digite a quantidade de remoção do item: ")
	save_int($t2)
	print("")
	blez $t2, erro_entrada
	blt $t1, $t2, erro_entrada
	sub $t1, $t1, $t2
	jal choices

consultar:
	print("Quantidade atual do item: ")
	print_int($t1)
	print("")
	jal choices

encerrar:
	print("Desligando sistema...")
	li $v0, 10
	syscall
	
erro_entrada:
	print("Ocorreu um erro na entrada de dados.\n")
	jal choices

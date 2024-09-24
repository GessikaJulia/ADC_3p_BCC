.data
	msg: .asciiz "Insira seu ano de nascimento:\n"
	pode: .asciiz "Idade suficiente para ter carteira de habilitação!\n"
	naoPode: .asciiz "Idade insuficiente para ter carteira de habilitação!\n"
.text

li $v0, 4
la $a0, msg
syscall

li $v0, 5
syscall
move $t0, $v0

beq $t0, 2008, igualIdade
bgt $t0, 2008, menorIdade
blt $t0, 2008, maiorIdade

igualIdade: 
li $v0, 4
la $a0, pode
syscall
j finaliza

maiorIdade:
li $v0, 4
la $a0, pode
syscall
j finaliza

menorIdade:
li $v0, 4
la $a0, naoPode
syscall
j finaliza

finaliza: 
li $v0, 10
syscall
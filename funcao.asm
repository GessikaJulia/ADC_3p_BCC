.data
msgpositivo: .asciiz "Este numero é possitivo\n"
msgnegativo: .asciiz "Este numero é negativo\n"
msgentrada: .asciiz "Digite um numero:\n"
fim: .asciiz "Fim do programa\n"

.text
li $v0, 4
la $a0, msgentrada
syscall

li $v0, 5
syscall

move $t0, $v0

beq $t0, $0 sair
jal verifica

verifica:
bgt $t0, $0, maior
blt $t0, $0, menor

maior:
li $v0, 4
la $a0, msgpositivo
syscall
j sair

 menor: 
 li $v0, 4
 la $a0, msgnegativo
 syscall
 j sair 
 
 sair:
 li $v0, 4
 la $a0, fim
 syscall
 li $v0, 10
 syscall

















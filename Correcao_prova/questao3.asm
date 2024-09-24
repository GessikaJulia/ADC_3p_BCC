
.data
	msg: .asciiz "Digite um numero:\n"
	rSoma: .asciiz "A soma é:\n"
	rMedia: .asciiz "A media é:\n"
.text
la $t1, -1


loop:
li $v0, 4
la $a0, msg
syscall

li $v0, 6
syscall
add $t1, $t1, 1
j condicao

condicao:
c.eq.s $f0, $f5
bc1t sair 
jal soma

soma:
add.s $f12, $f12, $f0
j loop

sair:
li $v0, 4
la $a0, rSoma
syscall

li $v0,2
syscall

li $v0, 4
la $a0, rMedia
syscall

mtc1 $t1, $f1
cvt.s.w $f0, $f1
div.s $f12,$f12, $f0
syscall

li $v0,2
syscall

li $v0, 10
syscall

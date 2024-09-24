.data
ZERO: .float 0.0

	.macro print(%str) #função de imprimir string 
		.data
			msg: .asciiz %str
		.text
			li $v0, 4 #avisa o registrador
			la $a0, msg #carrega o valor no registrador
			syscall 
	.end_macro

.text
print("Quanto você ganha?")
li $v0, 6 #por definição o valor digitado fica guardado em $f0
syscall

#passo 1: definir recurso para auxiliar no uso de instruções (add.s)
lwc1 $f1,ZERO
add.s $f2, $f1, $f0 #guarda no f2 o valor de f1 + f2
print("Quanto você deve")
li $v0, 6
syscall
add.s $f3,$f1,$f0 
sub.s $f12, $f2, $f3
print("Seu saldo é")
li $v0, 2
syscall
li $v0, 10
syscall
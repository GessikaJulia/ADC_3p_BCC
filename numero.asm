.data
n1: .asciiz  "Digite um numero:"  #recebe uma variavel que fica na memoria.
n2: .asciiz "Digite outro numero:"
r: .asciiz "A resposta é:"


.text
li $v0, 4 #coloca imediatamente o valor em v0.
la $a0, n1 #coloca um valor indereçado em a0.
syscall #apenas ações associadas ao v0
li $v0, 5
syscall 
move $t1, $v0

li $v0, 4 
la $a0, n2 
syscall
li $v0, 5 
syscall
move $t2, $v0

add $t3, $t1, $t2

li $v0, 4
la $a0, r
syscall

li $v0, 1
la $a0, ($t3)
syscall

li $v0, 10
syscall
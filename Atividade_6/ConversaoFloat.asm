.data
x: .float 2.0

.text
.globl main
main:
    la $a0, x
    lwc1 $f12, 0($a0) # carrega o valor de x em f12
    jal dobro # chama a função dobro
    move $a0, $v0 # move o resultado para a0
    li $v0, 2 # código de serviço para imprimir float
    syscall # imprime o resultado
    li $v0, 10 # código de serviço para terminar a execução
    syscall # termina a execução

dobro:
    lwc1 $f12, 0($a0) # carrega o valor de a em f12
    add.s $f0, $f12, $f12 # dobro = 2*a
    swc1 $f0, 0($a0) # armazena o resultado em a
    jr $ra # retorna para a função chamadora

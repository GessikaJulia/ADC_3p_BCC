.data
    numMsg: .asciiz "Digite um numero:"
    resultMsg: .asciiz "O resultado é:"

.text
    .globl main
main:
    # Solicita ao usuário para inserir um número
    li $v0, 4
    la $a0, numMsg
    syscall

    # Lê o número do usuário
    li $v0, 5
    syscall
    move $t0, $v0  # O número é armazenado no registrador $t0

    # Calcula o quadrado do número
    mul $t0, $t0, $t0  # Multiplica o número por ele mesmo e armazena o resultado no registrador $t0

    # Imprime a mensagem "O resultado é:"
    li $v0, 4
    la $a0, resultMsg
    syscall

    # Imprime o quadrado do número
    li $v0, 1
    move $a0, $t0
    syscall

    # Termina o programa
    li $v0, 10
    syscall

.data
    salarioMsg: .asciiz "Digite o salario:"
    despesaMsg: .asciiz "Digite o valor total aproximado das despesas:"
    saldoMsg: .asciiz "Saldo restante:"
    dividaMsg: .asciiz "Divida de:"

.text
    .globl main
main:
    # Solicita ao usuário para inserir o salário
    li $v0, 4
    la $a0, salarioMsg
    syscall

    # Lê o salário do usuário
    li $v0, 5
    syscall
    move $t0, $v0  # Salário é armazenado no registrador $t0

    # Solicita ao usuário para inserir a despesa total
    li $v0, 4
    la $a0, despesaMsg
    syscall

    # Lê a despesa total do usuário
    li $v0, 5
    syscall
    move $t1, $v0  # Despesa total é armazenada no registrador $t1

    # Subtrai a despesa do salário e armazena o resultado no registrador $t0
    sub $t0, $t0, $t1

    # Verifica se o resultado é positivo ou negativo
    bltz $t0, Divida  # Se o resultado for negativo, vai para Divida
    b Saldo  # Se o resultado for positivo, vai para Saldo

Divida:
    # Imprime a mensagem de divida
    li $v0, 4
    la $a0, dividaMsg
    syscall

    # Imprime o valor da divida
    li $v0, 1
    move $a0, $t0
    syscall

    # Termina o programa
    li $v0, 10
    syscall

Saldo:
    # Imprime a mensagem de saldo
    li $v0, 4
    la $a0, saldoMsg
    syscall

    # Imprime o valor do saldo
    li $v0, 1
    move $a0, $t0
    syscall

    # Termina o programa
    li $v0, 10
    syscall

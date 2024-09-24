.data
mensagem: .asciiz "Digite um numero: \n"  # Mensagem solicitando um número do usuário
fibonacci: .asciiz "Fibonacci: "         # Mensagem para o resultado de Fibonacci
n:.word 1                                 # Variável para armazenar o número digitado

.text
main:
    # Exibir a mensagem para o usuário
    li $v0, 4                             # Código para imprimir string
    la $a0, mensagem                      # Endereço da mensagem
    syscall                               # Chamar sistema para imprimir

    # Ler o número digitado pelo usuário
    li $v0, 5                             # Código para ler inteiro
    syscall                               # Chamar sistema para ler
    sw $v0, n                             # Armazenar número em 'n'

    # Se o número for 0, imprimir 0
    lw $t0, n                             # Carregar 'n' em $t0
    beq $t0, $zero, print_zero            # Se $t0 (n) for 0, ir para print_zero

    # Se o número for 1, imprimir 1
    li $t1, 1                             # Carregar 1 em $t1
    beq $t0, $t1, print_one               # Se $t0 (n) for 1, ir para print_one

    # Inicializar variáveis de Fibonacci
    addi $t2, $zero, 0                    # F(n-2) = 0
    addi $t3, $zero, 1                    # F(n-1) = 1
    addi $t4, $zero, 2                    # Contador = 2

    # Loop para calcular Fibonacci
fib_loop:
    add $t5, $t2, $t3                     # F(n) = F(n-1) + F(n-2)
    addi $t2, $t3, 0                      # Atualizar F(n-2) para F(n-1)
    addi $t3, $t5, 0                      # Atualizar F(n-1) para F(n)
    addi $t4, $t4, 1                      # Incrementar contador
    lw $t0, n                             # Carregar 'n' novamente
    bne $t4, $t0, fib_loop                # Se contador != n, continuar loop

    # Imprimir resultado
    li $v0, 4                             # Código para imprimir string
    la $a0, fibonacci                     # Endereço da string 'fibonacci'
    syscall                               # Chamar sistema para imprimir

    li $v0, 1                             # Código para imprimir inteiro
    move $a0, $t5                         # Mover resultado para $a0
    syscall                               # Chamar sistema para imprimir
    j end                                 # Ir para final do programa

# Imprimir 0
print_zero:
    li $v0, 4                             # Código para imprimir string
    la $a0, fibonacci                     # Endereço da string 'fibonacci'
    syscall                               # Chamar sistema para imprimir

    li $v0, 1                             # Código para imprimir inteiro
    move $a0, $zero                       # Mover 0 para $a0
    syscall                               # Chamar sistema para imprimir
    j end                                 # Ir para final do programa

# Imprimir 1
print_one:
    li $v0, 4                             # Código para imprimir string
    la $a0, fibonacci                     # Endereço da string 'fibonacci'
    syscall                               # Chamar sistema para imprimir

    li $v0, 1                             # Código para imprimir inteiro
    li $a0, 1                             # Carregar 1 em $a0
    syscall                               # Chamar sistema para imprimir

end:
    li $v0, 10                            # Código para sair do programa
    syscall                               # Chamar sistema para terminar

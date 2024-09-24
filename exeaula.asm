.data
mensagem: .asciiz "Digite um numero:\n"   # Mensagem solicitando ao usuário para digitar um número
fatorial: .asciiz "Fatorial: "            # Mensagem para exibir o resultado do fatorial
n: .word 1                                # Variável para armazenar o número inserido pelo usuário

.text
.globl main

main:
    # Exibir mensagem para o usuário
    li $v0, 4                 # Carregar o código de serviço para impressão de string
    la $a0, mensagem          # Carregar o endereço da mensagem para $a0
    syscall                   # Chamar o serviço do sistema

    # Ler número inserido pelo usuário
    li $v0, 5                 # Carregar o código de serviço para leitura de inteiro
    syscall                   # Chamar o serviço do sistema

    # Armazenar o número em n
    sw $v0, n                 # Armazenar o valor lido na variável n

    # Inicializar registradores
    move $s0, $v0             # $s0 = número inserido pelo usuário
    li $s1, 1                 # $s1 = 1 (resultado do fatorial)

    # Estrutura de loop para calcular o fatorial
For: 
    # Verificar se $s0 é maior que zero
    blez $s0, Fim_For         # Se $s0 <= 0, pular para Fim_For

    # Calcular o fatorial
    mul $s1, $s1, $s0         # $s1 = $s1 * $s0
    sub $s0, $s0, 1           # $s0 = $s0 - 1
    j For                     # Voltar para o início do loop For

Fim_For:
    # Exibir mensagem de fatorial
    li $v0, 4                 # Carregar o código de serviço para impressão de string
    la $a0, fatorial          # Carregar o endereço da mensagem para $a0
    syscall                   # Chamar o serviço do sistema

    # Exibir o resultado do fatorial
    li $v0, 1                 # Carregar o código de serviço para impressão de inteiro
    move $a0, $s1             # Mover o resultado do fatorial ($s1) para $a0
    syscall                   # Chamar o serviço do sistema

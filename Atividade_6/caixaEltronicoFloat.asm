#1) Adapte o exercicio do caixa eletronico para usar com ponto flutuante.

.data
	ZERO: .float 0.0
	mensagemId: .asciiz "Digite o seu Id:\n"
	mensagemSucesso: .asciiz "Operação bem sucedida\n"
	mensagemSenha: .asciiz "Digite a sua senha:\n"
	mensagemMenu: .asciiz "\n1 para saldo\n2 para depósito\n3 para saque\n4 para encerrar o programa\n"
	mensagemErro: .asciiz "Erro\n"
	opcao: .word 0
	quantidade: .float 0.0
	idUsuario: .word 1234
	senhaUsuario: .word 4321
	saldo: .float 0.0
	limite: .float 0.0
	mensagemDeposito: .asciiz "Digite a quantia de depósito:\n"
	mensagemSaque: .asciiz "Digite a quantia de saque:\n"
	mensagemEncerramento: .asciiz "Digite 1 para confirmar o encerramento, ou 0 para cancelar a ação:\n"
	mensagemOpcaoInvalida: .asciiz "Opção inválida\n"
	mensagemSaldoInsuficiente: .asciiz "Saldo insuficiente\n"
	adicionarLimite: .asciiz "Adicione seu valor de limite: "
	confirmarEmprestimo: .asciiz "Digite 1 para fazer emprestimo ou 0 para cancelar a ação:\n"
	mensagemEmprestimo: .asciiz "Digite a quantia de emprestimo:\n"

.text

.globl main
main:

# Carregamento de id e senha
   lw $t0, idUsuario
   lw $t1, senhaUsuario

# Autenticação id
    li $v0, 4
    la $a0, mensagemId
    syscall

    li $v0, 5
    syscall

    beq $t0, $v0, autenticacao

    bne $t0, $v0, fim

#Macros para leitura de senha

autenticacao:
    li $v0, 4
    la $a0, mensagemSenha
    syscall

    li $v0, 5
    syscall

    beq $t1, $v0, ramoAdicionarLimite
    li $v0, 4
    la $a0, mensagemErro
    syscall
    j fim

#addlimit

ramoAdicionarLimite:
#adicionar limite

    li $v0, 4
    la $a0, adicionarLimite
    syscall

    li $v0, 6
    syscall
    mov.s $f12, $f0

    lwc1 $f13, limite
    add.s $f13, $f13, $f12
    swc1 $f13, limite
    j menu


# Menu

menu:
#iniciar menu

    li $v0, 4
    la $a0, mensagemMenu
    syscall

#Opção do menu
    li $v0, 5
    syscall
    move $t2, $v0

#Condições para opções do menu
    beq $t2, 1, verificarSaldo
    beq $t2, 2, deposito
    beq $t2, 3, saque
    beq $t2, 4, encerramento
    j opcaoInvalida

# Funções

verificarSaldo:
    li $v0, 2
    lwc1 $f12, saldo
    syscall
    j menu

#Macro de depósito

deposito:
    li $v0, 4
    la $a0, mensagemDeposito
    syscall

    li $v0, 6
    syscall
    mov.s $f12, $f0

    lwc1 $f13, saldo
    add.s $f13, $f13, $f12
    swc1 $f13, saldo

    li $v0, 4
    la $a0, mensagemSucesso
    syscall
    j menu

# Macro de saque

saque:
    li $v0, 4
    la $a0, mensagemSaque
    syscall

    li $v0, 6
    syscall
    mov.s $f12, $f0

    lwc1 $f13, saldo
    
    lwc1 $f16, limite
    add.s $f16, $f16, $f13
    
    c.lt.s $f16, $f12
    bc1t emprestimo

    sub.s $f13, $f13, $f12
    swc1 $f13, saldo

    li $v0, 4
    la $a0, mensagemSucesso
    syscall
    j menu
    
 #Macro para emprestimo
 
 emprestimo:
    li $v0, 4
    la $a0, confirmarEmprestimo
    syscall

    li $v0, 5
    syscall
    move $t5, $v0

    beq $t5, 1, emprestimo_2
    beq $t5, 0, menu
    j opcaoInvalida
    
#Macro para continuação do emprestimo
emprestimo_2:
    li $v0, 4
    la $a0, mensagemEmprestimo
    syscall

    li $v0, 6
    syscall
    mov.s $f12, $f0

    lwc1 $f13, saldo
    add.s $f13, $f13, $f12
    swc1 $f13, saldo

    li $v0, 4
    la $a0, mensagemSucesso
    syscall
    j menu
 

# Macro de saldo insuficiente para saque

saldoInsuficiente:
    li $v0, 4
    la $a0, mensagemSaldoInsuficiente
    syscall
    j menu

# Macro para encerrar

encerramento:
    li $v0, 4
    la $a0, mensagemEncerramento
    syscall

    li $v0, 5
    syscall
    move $t5, $v0

    beq $t5, 1, fim
    beq $t5, 0, menu
    j opcaoInvalida

# Macro para opção inválida

opcaoInvalida:
    li $v0, 4
    la $a0, mensagemOpcaoInvalida
    syscall
    j menu

# Macro para finalizar o programa

fim:
    li $v0, 10
    syscall

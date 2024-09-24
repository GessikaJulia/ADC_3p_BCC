.data
	inputIdMsg: .asciiz "Digite o seu Id:\n"
	successMsg: .asciiz "Operação bem sucedida\n"
	inputPasswordMsg: .asciiz "Digite a sua senha:\n"
	menuMsg: .asciiz "\n1 para saldo\n2 para depósito\n3 para saque\n4 para encerrar o programa\n"
	errorMsg: .asciiz "Erro\n"
	option: .word 0
	amount: .word 0
	userId: .word 1234
	userPassword: .word 4321
	balance: .word 0
	limit: .word 0
	depositMsg: .asciiz "Digite a quantia de depósito:\n"
	withdrawMsg: .asciiz "Digite a quantia de saque:\n"
	closingMsg: .asciiz "Digite 1 para confirmar o encerramento, ou 0 para cancelar a ação:\n"
	invalidOptionMsg: .asciiz "Opção inválida\n"
	insufficientBalanceMsg: .asciiz "Saldo insuficiente\n"
	addLimit: .asciiz "Adicione seu valor de limite: "
	loan_confirm: .asciiz "Digite 1 para fazer emprestimo ou 0 para cancelar a ação:\n"
	loanMsg: .asciiz "Digite a quantia de emprestimo:\n"

.text

.globl main
main:

# Carregamento de id e senha
   lw $t0, userId
   lw $t1, userPassword

# Autenticação id
    li $v0, 4
    la $a0, inputIdMsg
    syscall

    li $v0, 5
    syscall

    beq $t0, $v0, authentication

    bne $t0, $v0, end

#Macros para leitura de senha

authentication:
    li $v0, 4
    la $a0, inputPasswordMsg
    syscall

    li $v0, 5
    syscall

    beq $t1, $v0, addLimit_branch
    li $v0, 4
    la $a0, errorMsg
    syscall
    j end

#addlimit

addLimit_branch:
#adicionar limite

    li $v0, 4
    la $a0, addLimit
    syscall

    li $v0, 5
    syscall
    move $t3, $v0

    lw $t4, limit
    add $t4, $t4, $t3
    sw $t4, limit
    j menu


# Menu

menu:
#iniciar menu

    li $v0, 4
    la $a0, menuMsg
    syscall

#Opção do menu
    li $v0, 5
    syscall
    move $t2, $v0

#Condições para opções do menu
    beq $t2, 1, checkBalance
    beq $t2, 2, deposit
    beq $t2, 3, withdraw
    beq $t2, 4, closing
    j invalidOption

# Funções

checkBalance:
    li $v0, 1
    lw $a0, balance
    syscall
    j menu

#Macro de depósito

deposit:
    li $v0, 4
    la $a0, depositMsg
    syscall

    li $v0, 5
    syscall
    move $t3, $v0

    lw $t4, balance
    add $t4, $t4, $t3
    sw $t4, balance

    li $v0, 4
    la $a0, successMsg
    syscall
    j menu

# Macro de saque

withdraw:
    li $v0, 4
    la $a0, withdrawMsg
    syscall

    li $v0, 5
    syscall
    move $t3, $v0

    lw $t4, balance
    
    lw $t7, limit
    add $t7, $t7, $t4
    
    slt $t5, $t7, $t3
    beq $t5, 1, loan

    sub $t4, $t4, $t3
    sw $t4, balance

    li $v0, 4
    la $a0, successMsg
    syscall
    j menu
    
 #Macro para emprestimo
 
 loan:
    li $v0, 4
    la $a0, loan_confirm
    syscall

    li $v0, 5
    syscall
    move $t5, $v0

    beq $t5, 1, loan_2
    beq $t5, 0, menu
    j invalidOption
    
#Macro para continuação do emprestimo
loan_2:
    li $v0, 4
    la $a0, loanMsg
    syscall

    li $v0, 5
    syscall
    move $t3, $v0

    lw $t4, balance
    add $t4, $t4, $t3
    sw $t4, balance

    li $v0, 4
    la $a0, successMsg
    syscall
    j menu
 

# Macro de saldo insuficiente para saque

insufficientBalance:
    li $v0, 4
    la $a0, insufficientBalanceMsg
    syscall
    j menu

# Macro para encerrar

closing:
    li $v0, 4
    la $a0, closingMsg
    syscall

    li $v0, 5
    syscall
    move $t5, $v0

    beq $t5, 1, end
    beq $t5, 0, menu
    j invalidOption

# Macro para opção inválida

invalidOption:
    li $v0, 4
    la $a0, invalidOptionMsg
    syscall
    j menu

# Macro para finalizar o programa

end:
    li $v0, 10
    syscall

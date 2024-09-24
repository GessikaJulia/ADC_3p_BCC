.include "musica.asm"

.text
.globl main
main:
    # Carrega o endereço do vetor de bytes da música em $t0
    la $t0, musica
    # Copia o byte na posição atual da RAM (endereço em $t0) para $t1
    lb $t1, ($t0)

    # Inicializa $t2 com 0
    add $t2, $zero, $zero

loop:
    # Verifica se chegamos ao final da música (-1)
    beq $t1, -1, end

    # Prepara para a chamada de sistema para tocar o som (syscall 31)
    li $v0, 31
    # Define o parâmetro do som (nota) em $a0
    add $a0, $zero, $t1
    # Define a duração do som em $a1 (700 milissegundos)
    addi $a1, $zero, 700
    # Define o instrumento em $a2
    add $a2, $zero, $t2
    # Define o volume do som em $a3 (700)
    addi $a3, $zero, 700
    # Chama o sistema para tocar o som
    syscall

    # Prepara para a chamada de sistema para a pausa (syscall 32)
    li $v0, 32
    # Define o tempo de pausa em $a0 (200 milissegundos)
    add $a0, $zero, 200
    # Chama o sistema para a pausa
    syscall

    # Prepara para a chamada de sistema para alterar o instrumento (syscall 42)
    li $v0, 42
    # Define o novo instrumento em $a1 (115)
    li $a1, 115
    # Chama o sistema para alterar o instrumento
    syscall
    # Move o novo instrumento para $t2
    move $t2, $a0

    # Incrementa o ponteiro do vetor de bytes da música ($t0)
    addi $t0, $t0, 1
    # Carrega o próximo byte do vetor de bytes da música em $t1
    lb $t1, ($t0)
    # Volta para o loop para tocar a próxima nota
    j loop

end:
    # Termina o programa
    li $v0, 10
    syscall

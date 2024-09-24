.data #tem como função pré definir variaveis.
msg: .asciiz "Hello world" #variaveal identificada como string.


.text #tem como função apresentar a sequencia lógica.
#preparar o processador para receber a string.
li $v0, 4   #carrega o valor 4 no registrador $v0, e chamada sistema para imprimir string.
la $a0, msg #ler o endereço da memoria, visto que a mensagem está na memoria.
syscall #sistema imprimi a string.
li $v0, 10 #prepara o processador para finalizar, chama o valor 10 referente a finalizar do programa.
syscall #sistema finaliza o programa.
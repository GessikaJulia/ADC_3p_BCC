.data


.macro printf(%str) #informar que isso é um argumento, tipo uma função
        .data
        	msg: .asciiz %str 
        
        .text
		li $v0, 4
		la $a0, msg #a0 vai receber msg
		syscall
		

.end_macro #final da macro

.text
.globl principal #bloco principal

principal:
printf("Oi turma.\n")
printf("Oi turma novamente!\n")
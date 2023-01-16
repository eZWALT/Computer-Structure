# PRACTICA 1 #######################

	.data
	fib: .space 40
	.text
	.globl main
main:
	addiu $s0,$0,2
	la $t3,fib	# adreça de fib
	li $t1,1
	sw $0,0($t3)
	sw $t1,4($t3)
	
while:	#used regs: s0,t3
	slti $t0,$s0,10
	beq $t0,$0,fi
	sll $t2,$s0,2	#farem servir el t2 com a index del vector fib
	addu $t2,$t2,$t3
	lw $t4, -4($t2) #t4 = fib[i-1]
	lw $t5, -8($t2) #t4 = fib[i-2]
	addu $t5,$t4,$t5
	sw $t5,0($t2)
	addiu $s0,$s0,1
	b while
fi:

	jr $ra		# main retorna al codi de startup


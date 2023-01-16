# PRACTICA 1 #######################

	.data
	A: .word 3,5,7
	punter: .word 0

	.text
	.globl main
main:
	la $t1, A
	addiu $t1,$t1,8
	la $t2, punter
	sw $t1,0($t2)
	
	lw $s0,0($t1)
	addiu $s0,$s0,2
	
	addiu $t1,$t1,-8
	lw $t2,0($t1)
	addu $s0,$s0,$t2
	sw $s0,4($t1)
	
	li $v0, 1
	addiu $a0,$s0,0
	syscall

	jr $ra		# main retorna al codi de startup


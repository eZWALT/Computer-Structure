	.data
result: .word 0
num:	.byte '5'

	.text
	.globl main
main:

	la $t0, num
	la $t1,result
	lw $t0,0($t0)
	
	slti $t2,$t0,'a'
	bne $t2,$zero, or_condition
	li $t2, 'z'
	ble $t0,$t2,if_action 	#S'ha complert una de les 2 parts de la OR , realitzem el if
or_condition:
	slti $t2,$t0,'A'
	bne $t2,$zero,else
	li $t2,'Z'
	bgt $t0,$t2,else	#aqui anem al if per continuacio o be al else
if_action:	
	sw $t0,0($t1) 		#RESULT = NUM
	b end_conditional       #Acabem , anem al final
else:
	slti $t2,$t0,'0'
	bne $t2,$zero,else2
	li $t2,'9'
	bgt $t0,$t2,else2
	li $t2,'0'
	subu $t4,$t0,$t2 	#s'ha complert el if interior -> result = num - '0'
	sw $t4,0($t1)
	b end_conditional	#Acabem , anem al final
else2:
	li $t2, -1
	sw $t2,0($t1)
	
end_conditional:		#Punt de referencia per quan s'acaben els ifs
	jr $ra


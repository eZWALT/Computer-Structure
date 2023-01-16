.data
M: .word 1,2,3,4,5,6,7,8,9,8,7,6,5,4,3,2,1,2,3,4
V: .word 0,0,0,0,0,0,0,0

.text
.globl main

main:	
	move $s0,$zero	#i
	li $t0,5
	li $t1,4	#limits dels fors
	la $t2,M
	la $t3,V
	
for1:	bge $s0,$t0,end_for1
	sll $t4,$s0,2
	addu $t4,$t3,$t4		#Vbase + i 
	addiu $t4,$t4,12		#Vbase + i + 3
	
	move $s1,$zero	#j
	
for2:	bge $s1,$t1,end_for2
	sll $t5,$s1,2
	subu $t5,$t4,$t5		#vbase + i + 3 - j 
	
	lw $t6,0($t5)		#carreguem vector
	lw $t7,0($t2)		#valor matriu
	addu $t6,$t6,$t7	#v = v + m
	sw $t6,0($t5)
	
	addiu $t2,$t2,4
	addiu $s1,$s1,1
	b for2
end_for2:

	addiu $s0,$s0,1
	b for1
end_for1:
	
	jr $ra

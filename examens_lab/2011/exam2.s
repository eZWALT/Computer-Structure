.data
V1: .word -32,64,-10,16,-20
V2: .word 8,-70,30,-17
suma1: .word 0
suma2: .word 0

.text
.globl main

main:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $s0, suma1
	la $s1, suma2
	
	la $a0,V1
	li $a1,5
	jal subr1
	sw $v0,0($s0)
	
	la $a0,V2
	li $a1,4
	jal subr1
	sw $v0,0($s1)
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
subr1:
	addiu $sp,$sp,-20
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	
	move $s0,$zero #s0 = i
	move $s1,$a0   #s1 = p
	move $s2,$a1   #s2 = x
	move $s3,$zero #s3 = aux
	
for:	bge $s0,$s2,end_for
	lw $t0,0($s1)	 #carreguem el valor del punter
	move $a0,$t0
	move $a1,$s0
	jal subr2
	addu $s3,$s3,$v0	#aux = aux + subr(*P,I)
	
	addiu $s1,$s1,4
	addiu $s0,$s0,1
	b for
end_for:
	move $v0,$s3	#return aux
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	addiu $sp,$sp,20
	jr $ra
	
subr2:	
	li $t0,2
	li $t1,3
	div $a0,$t1
	blt $a1,$t0,else	#if
	mfhi $v0
	b end_cond
else:
	mflo $v0
end_cond:
	jr $ra
	
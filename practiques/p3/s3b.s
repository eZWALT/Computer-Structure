	# Sessio 3 , exercici b

	.data 
mat1: .space 120
mat4: .word 2,3,1,2,4,3
col:  .word 2

	.text 
	.globl main
main:
	addiu $sp, $sp,-4
	sw $ra,0($sp)
	
	la $s0,mat4
	la $s1,mat1
	la $a2,col
	lw $a2, 0($a2)  #a2 = col
	move $a0,$s0	#a0 = @mat4
	lw $a1,8($s0)	#a1 = mat4[0][2]
	jal subr
	sw $v0,108($s1) #mat1[4][3] = v0
	
	move $a0,$s0
	addiu $a1,$zero,1
	addiu $a2,$zero,1
	jal subr
	sw $v0,0($s1) #mat1[0][0] = v0
	lw $ra,0($sp)
	addiu $sp, $sp,4
	jr $ra

subr:
	sll $t1,$a2,2
	addu $a0,$a0,$t1
	sll $t1,$a1,2
	li $t2,3
	mult $t1,$t2
	mflo $t1
	addu $a0,$a0,$t1
	la $t1, mat1
	lw $a0,0($a0)   #carreguem mat4 + i*4*3 + j*4
	
	li $t2,20 	#20 = 5 * 4
	li $t3, 6
	sll $a2,$a2,2   #j*4
	mult $t3,$a2    #j*4*6
	mflo $a2
	addu $t1,$t1,$a2
	addu $t1,$t1,$t2
	sw $a0, 0($t1) #mat[j][5] = x...
	move $v0,$a1
	jr $ra
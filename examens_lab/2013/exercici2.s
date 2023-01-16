.data
	res: .word 0
	x: .word 3 
	y: .word 2
	n: .word 7
.text

	.globl main
main:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,x
	la $a1,y
	la $a2,n
	lw $a0,0($a0)
	lw $a1,0($a1)
	lw $a2,0($a2)
	jal powermod
	la $t0,res
	sw $v0,0($t0)
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra

squaremod:	#funcio 1
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	li $t0,1
	bne $a0,$t0, else
	move $v0,$t0	#return 1
	b end_square
	
else:	move $a2,$a1
	move $a1,$a0	#a0 = a , a1 = a,a2 = c	
	jal multmod

end_square: lw $ra,0($sp)
	    addiu $sp,$sp,4
	    jr $ra
	    
multmod:	#funcio 2
	mult $a0,$a1
	mflo $v0
	div $v0,$a2
	mfhi $v0	#modul = v0
	jr $ra

powermod:	#funcio3 
	addiu $sp,$sp,-24
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $s4,20($sp)
	
	move $s0,$a0	# s0 = a
	move $s1,$a1	# s1 = b
	move $s2,$a2	# s2 = c
	li $s3,31	# s3 = i
	li $s4,1	# s4 = r , s'ha de tenir en compte que z = t1
	
for:	blt $s3,$zero,end_for
	move $a0,$s4
	move $a1,$s2
	jal squaremod		#squaremod(r,c)
	move $s4,$v0
	
	move $t1,$s1
	srav $t1,$t1,$s3
	andi $t1,$t1,0x01	#z = (b>>i)&0x01
	
	li $t0,1
	bne $t1,$t0, not_condition
	move $a0,$s4
	move $a1,$s0
	move $a2,$s2
	jal multmod
	move $s4,$v0		
not_condition:	addiu $s3,$s3,-1
	b for
	
end_for: move $v0,$s4
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $s4,20($sp)
	addiu $sp,$sp,24
	
	jr $ra

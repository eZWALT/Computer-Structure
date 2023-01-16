	.data
w:      .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra

nofares:
	li	$t0, 0x12345678
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
	addiu $sp,$sp,-60 #reservem 40 bytes pel vector , 4 pel RA i 4*4 pels segurs
	sw $ra,40($sp)
	sw $s0,44($sp)
	sw $s1,48($sp)
	sw $s2,52($sp)
	sw $s3,56($sp)
		
	move $t0, $zero
for:
	slti $t1,$t0,10
	beq $t1,$0, end_for
	sll $t1,$t0,2
	addu $t1,$t1,$sp	 #sp  = &histo(0) , llavors sp + i * 4
	sw $zero,0($t1) 	 #histo(k) = 0
	addi $t0,$t0,1
	b for
end_for:
	move $s0,$a0    #s0 = &vec[0]
	move $s1,$a1	#s1 = num , index del for2
	li $s2, 0	#mourem k inicialitzat a 0 per no perdre dsps de trucar a update
	li $s3,'0' 	#max = '0'
	
for2:	
	bge $s2,$s1,end_for2
	move $a0,$sp	 #base histo
	addu $t0,$s0,$s2
	lb $a1,0($t0)
	addiu $a1,$a1,-48	 #recordatori: el ascii de '0' es 48
	addiu $a2,$s3,-48
	jal update	#ara tenim a v0 el valor update
	addiu $s3,$v0,48
	
	addi $s2,$s2,1
	b for2
end_for2:

	move $v0,$s3 	#return max
	lw $ra,40($sp)
	lw $s0,44($sp)
	lw $s1,48($sp)
	lw $s2,52($sp)
	lw $s3,56($sp)
	addiu $sp,$sp,60	 #restauració de registres i stack pointer abans del salt
	jr $ra
update:
	addiu $sp,$sp,-16 #guardem ra i els safe's que utilitzarem 
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2	#assegurem que no es perdin els parametres
	jal nofares
	
	sll $t0,$s1,2	#els chars ja venen en numeros del 0 al 9 gracies al - '0'
	addu $t0,$s0,$t0
	lw $t1,0($t0) 
	addiu $t1,$t1,1
	sw $t1,0($t0) 	#incrementem h[i]++;
	sll $t2,$s2,2	 #imax * 4 = t2
	addu $t2,$s0,$t2
	lw $t2,0($t2)
	
	ble $t1,$t2, else
	move $v0,$s1
	b end_conditional
else:
	move $v0,$s2	#guardem i o imax

end_conditional:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp,$sp,16
	jr $ra
	# Sessio 3

	.data 
mat:	.word 0,0,2,0,0,0
	.word 0,0,4,0,0,0
	.word 0,0,6,0,0,0
	.word 0,0,8,0,0,0
	
resultat: .space 4

	.text 
	.globl main

main:
	addiu $sp,$sp,-4
	sw $ra, 0($sp) 	#Guardem per normativa abi
		
	la $s0, resultat
	la $a0, mat
	jal suma_col
	sw $v0,0($s0)
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra

suma_col:
	move $t0,$zero #t0 = suma = 0
	move $t1,$zero #t1 = i = 0
	la $t2, mat
	addiu $t2,$t2,8 #t1 = m[0][2]
	li $t3 , 4      #t3 = centinella del for
for:	
	bge $t1,$t3,end_for
	lw $t4, 0($t2) 		#*p
	addu $t0,$t0,$t4 	# suma += *p
	addiu $t2,$t2,24	#stride es 24 bytes
	
	addiu $t1,$t1,1
	b for
	
end_for:
	move $v0,$t0
	jr $ra




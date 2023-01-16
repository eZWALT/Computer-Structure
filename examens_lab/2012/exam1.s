.data

files: .space 16
columnes: .space 16
M: .space 100
suma: .word 0

.text
.globl main

main:
	move $s0,$zero 	#k = 0
	la $s1,files	#base de files
	la $s2,columnes #base de columnes
	la $s3,M	#base de M
	addiu $s4,$zero,4
	
for:	bge $s0,$s4,end_for
	la $t0,suma
	lw $t1,0($t0)	#carreguem suma
	
	lw $t2,0($s1)	 #files[k] loaded
	li $t5,5
	mult $t2,$t5
	mflo $t2
	lw $t3,0($s2)	 #columnes[k] loaded
	addu $t2,$t2,$t3 #files * 4 + columnes
	sll $t2,$t2,2	 # 4(files*4 + columnes)
	addu $t2,$t2,$s3 #ja tenim tot el acces a matrix complert
	lw $t2,0($t2)
	lw $t3,0($t0)    #t3 conte suma
	addu $t3,$t3,$t2 #suma = suma + M...
	sw $t3,0($t0)
	
	addiu $s1,$s1,4  
	addiu $s2,$s2,4
	addiu $s0,$s0,1
	b for
end_for:
	jr $ra	
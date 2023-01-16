.data
v:	.word 10,3141224,323,-32,3123,12,2132,44,1,2,0 
s:	.word 10
espai:	.asciiz

.text
.globl main
main:
	la $a0, v
	la $a1, s
	lw $s1,0($a1)
	move $a1,$s1
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	jal selection_sort
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
selection_sort:
	addiu $sp,$sp,-16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s3, 12($sp)
	
	move $s1,$a1	#s1 = tamany vector
	move $s0,$a0	#s0 = direccio base
	addu $s2,$0,$0  #iterador vector j 
	
for:
	bge $s2,$s1,end_for
	la   $a0,v
	move $a1,$s2		#nota: a0 no cal canviarlo pas, es el mateix argument que per la funcio min
	jal find_min
	sll $t0,$s2,2	#j * 4
	sll $t1,$v0,2	#min * 4
	addu $t0,$t0,$s0 # t0 = arr[j]
	addu $t1,$t1,$s0 # t1 = arr[min]
	move $a1,$t0
	move $a0,$t1
	jal swap
no_swap:
	addiu $s2,$s2,1
	b for
end_for:

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s3, 12($sp)
	addiu $sp,$sp,16
	jr $ra
	
find_min:
	addiu $a1,$a1,1  #++inicial;
	addiu $t1,$a1,-1 #int posicio = inicial;
	la $t0, s	#cargar el size del array
	lw $t0,0($t0)
for2:
	bge $a1,$t0,end_for2
	sll $t2,$a1,2
	sll $t3,$t1,2
	addu $t2,$t2,$a0
	addu $t3,$t3,$a0
	lw $t2, 0($t2)  #v[i]
	lw $t3, 0($t3)  #v[posicio]
	bge $t2,$t3,branch
	move $t1,$a1	#si v-posicio es mes gran que v-i posicio = i	
branch:	
	addiu $a1,$a1,1
	b for2
end_for2:
	move $v0,$t1
	jr $ra

swap:
	lw $t0,0($a0)
	lw $t1,0($a1)
	sw $t0,0($a1)
	sw $t1,0($a0)
	jr $ra

#CACHE DIRECTA , 8 BLOCS, 32 BYTES/BLOC,ESCRIPTURA IMMEDIATA AMB ASSIGNACIO
#ANALISIS ADREÇA: 24b tag, 3b bloc, 5b bytes

.data
	v: .byte 'a','b','c','d','e','f','g','h','+','-','*','/'
	m: .space 144
.text
	.globl main
	main:
	move $t0,$zero #t0 == i
	li $t1,12
	li $t2,'z'
	la $t3,v
	la $t4,m
	
for:	move $t5,$t3	#vbase
	addu $t5,$t5,$t1	#vbase + 12
	addiu $t5,$t5,-1	#vbase + 11
	subu $t5,$t5,$t0	#vbase + 11 - i 
	lb $t5,0($t5)	#Carreguem a t5 el v[12-i-1]
	beq $t5,$t2,end_for
	bge $t0,$t1,end_for
	
	mult $t0,$t1
	mflo $t6
	addu $t6,$t6,$t4	#mbase + i*12
	sw $t5,0($t6)		#m[i][0] = v[12-i-1]
	addiu $t0,$t0,1
	b for
end_for:
	jr $ra
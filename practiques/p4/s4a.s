	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x40000001
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	swc1	$f0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra

	#$t0 = signe , $t1 = exp , $a0 = mantiss
descompon:
	slti $t0,$a0,0   	#(cf < 0) bool
	sw $t0,0($a1)		# s = bool
	
	sll $a0,$a0,1		# <<
	bne $a0,$zero,else
if:	move $t1,$zero		#estructura condicional (if cf == 0)
	b end_if
		
else:
	li $t1,18
while:	blt $a0,$zero,end_while
	sll $a0,$a0,1		#cf = cf << 1
	addiu $t1,$t1,-1	#--exp
	b while
end_while:	
	sra $a0,$a0,8
	li $t2,0x7FFFFF
	and $a0,$a0,$t2		#cf = (cf >> 8) & 0x7FFFFFF(mascara)
	addiu $t1,$t1,127	
end_if:
	sw $t1,0($a2)
	sw $a0,0($a3)
	jr $ra
	
compon:
	sll $a0,$a0,31
	sll $a1,$a1,23
	
	or $t0,$a0,$a1
	or $t0,$t0,$a2
	mtc1 $t0,$f0
	jr $ra


.data
vec1: .space 40
vec2: .space 52

.text
.globl main

main:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
func:	

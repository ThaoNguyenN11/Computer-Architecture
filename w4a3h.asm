.text
#abs
	li $s0,-1000
	slt $t1,$s0,$zero
	bne $t1,$zero,NEGATIVE
	j default
NEGATIVE:
	nor $s1,$s0,$zero
	addi $s2,$s1,1
default:
	
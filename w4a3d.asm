.text
#ble
	li $s2,1000
	li,$s1,100
	slt $t1,$s2,$s1
	beq $t1,$zero,Branch
	j continue
Branch:
	li $t3,1
continue:

.text
	li $s1, 0x7fffffff
	li $s2, 2
start:
	li $t0, 0 #no overflow is default status
	addu $s3,$s1,$s2 #s3=s1+s2
	xor $t1,$s1,$s2 #test if s1 and s2 have the same sign
	bltz $t1,EXIT
	xor $t2,$s3,$s1 #test if s3 and s1 have the same sign
	bltz $t2, OVERFLOW
OVERFLOW:
	li $t0, 1
EXIT:

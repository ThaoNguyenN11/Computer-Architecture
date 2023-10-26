start: 
	li $s1, 6	#i=6
	li $s2, 5	#j=5
	li $t2, 2 #x=2
	li $t3, 3 #y=3
	li $t4, 4 #z=4
	li $t1, 1
	li $t5, 1 #m=1
	li $t6, 2 #n=2
	add $t5,$t5,$t6 #t5=m+n
	add $s1, $s1, $s2 #s1=i+j
	slt $t0,$t5,$s1 # set less than i+j>m+n
	bne $t0,$t1,else #branch to else i+j<m+n
	addi $t2,$t2,1 # then part: x=x+1
	addi $t4,$zero,1 # z=1
j endif # skip “else” part
else: 	addi $t3,$t3,-1 # begin else part: y=y-1
	add $t4,$t4,$t4 # z=2*z
endif:
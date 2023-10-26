.data
A: .word 4, -6, 12, -5, 8
.text
	li $s1, -1 #i=-1
	la $s2, A #s2 strore address A[i]
	li $s3, 5 #number of elements of A
	li $s4, 1, #step
	addi $s5, $zero, 0 # sum = 0
loop: 	
	add $s1,$s1,$s4 #i=i+step
	add $t1,$s1,$s1 #t1=2*s1
	add $t1,$t1,$t1 #t1=4*s1
	add $t1,$t1,$s2 #t1 store address of A[i]
	lw $t0,0($t1) #t0=A[i]
	add $s5,$s5,$t0 #sum=sum+A[i]
	slt $t5,$s5,$zero #t5=1 (sum<0), t5=0 (sum>=0)
	beq $t5,$zero,loop #t5=1 loop

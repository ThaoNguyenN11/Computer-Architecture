.data
A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9
.text
	addi $s1, $zero, 0 # i = 0
	la $s2, A #s2 strore address A[i]
	li $s3, 9 #number of elements of A
	li $s4, 1, #step
	addi $s5, $zero, 0 # sum = 0
loop: 	slt $t2, $s1, $s3 # $t2 = i < n ? 1 : 0
	beq $t2, $zero, endloop
	add $t1, $s1, $s1 # $t1 = 2 * $s1
	add $t1, $t1, $t1 # $t1 = 4 * $s1
	add $t1, $t1, $s2 # $t1 store the address of A[i]
	lw $t0, 0($t1) # load value of A[i] in $t0
	add $s5, $s5, $t0 # sum = sum + A[i]
	add $s1, $s1, $s4 # i = i + step
j loop # goto loop
endloop:
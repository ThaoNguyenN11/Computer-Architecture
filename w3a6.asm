.data
A: .word 1, 2, 3, 4, 5, 6, 7, 8, -9
.text
	li $s6, 0 #case
	li $s7, 1 #case

	li $s1,-1 #i=-1
	la $s2,A #s2 store address A[i]
	li $s3,9 #number of elements of A
	li $s4,1 #step
	li $s5,0 #max

loop:
	add $s1,$s1,$s4 #i=i+step
	add $t1,$s1,$s1 #t1=2*s1
	add $t1,$t1,$t1 #t1=4*s1
	add $t1,$t1,$s2 #t1 store address of A[i]
	lw $t0,0($t1) #load value of A[i] in $t0
start:
	slti $t6,$t0,0 #A[i]<0
	bne $t6,$zero,else #
	slt $t8,$t0,$s5 #A[i]<max
	beq $t8,$s6,case0 #t7!=t6 A[i]>max
	beq $t8,$s7,case1 #t7=t6
	j endif
else:
	mul $t0,$t0,-1 #abs
	slt $t7,$t0,$s5 #A[i]<max
	beq $t7,$s6,case0 #t7!=t6 A[i]>max
	beq $t7,$s7,case1 #t7=t6
	j default
endif:
case0:
	add $s5,$t0,$zero #max=A[i]
	j continue
case1:
	j continue
default:
continue:
bne $s1,$s3,loop #if i!=n, goto loop
	

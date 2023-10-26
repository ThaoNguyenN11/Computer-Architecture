.data
	A: .space 64
	mess0: .asciiz "Nhap so phan tu: "
	mess1: .asciiz "Nhap phan tu thu "
	mess2: .asciiz " : "
	Message1:	.asciiz "Array after each round bubble sort is:"
	Message2:	.asciiz " , "
	Newline:	.asciiz "\n"
.text
main:
	add  $t4, $zero, $zero		#counter loop
 	
 	li $v0, 4
	la $a0, mess0
	syscall
	
	la $a0,A 			#$a0 = Address(A[0])
	li $v0, 5
	syscall
	mul $a1, $v0, 4
	addi $a1, $a1, -4
	add $a1, $a1, $a0
	add $s2, $a1, $zero
	j bubble_sort
swat:
 	lw 	$t2, 0($a2)	# $t2 = value of address A[i]
 	sw 	$t2, 0($t1)	# value of address A[j] = $t2
 	sw	$v0, 0($a2)	# value of A[i] = A[j]
 	j continue
reset:
	la	$a0, A
	addi	$t0, $zero, 0	# j = 0
	addi	$a2, $a2, 4	# i++
	j bubble_sort
print_sort:
	li	$v0, 4
	la	$a0, Message1
	syscall			#print message1
	la	$a0, Newline
	syscall			#print newLine
	la	$s0, A
	l
	lw	$s2, 0($s0)
	li	$v0, 1
	la	$a0, 0($s2)	#print number1 of array
	syscall
	addi	$t3, $zero, 0 	#i = 0
	j print_array
bubble_sort:
	bgt  	$a2, $a1, end_main	# if i>(n-1) end
	add 	$t1, $a0, $t0		# $t1 = address of A[0] + 4*j (A[j])
	beq	$t1, $a2, print_sort	# if j = i print
	lw	$v0, 0($t1)		# $v0 = A[j]
	lw	$v1, 0($a2)		# $v1 = A[i]
	blt	$v1, $v0, swat		# if A[i] > A[j] swat
continue:
	addi	$t0, $t0, 4		# j++
	j bubble_sort
print_array:
	addi	$t3, $t3, 4		# i++
	add	$t4, $s0, $t3		# $t1 = adrress of A[0] + 4*i (A[i])
	lw	$t5, 0($t4)		# x = A[i]
	beq	$t4, $s1, end		# if i>(n-1) end
	li	$v0, 4
	la	$a0, Message2
	syscall				# print Message2
	li	$v0, 1
	la	$a0, 0($t5)
	syscall				# print A[i]
	j	print_array
end:
	li	$v0, 4
	la	$a0, Newline
	syscall
	j	reset
end_main:
	li	$v0, 10
	syscall				# exit


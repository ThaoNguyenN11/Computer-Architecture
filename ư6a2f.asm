.data
	A: .space 64
	mess0: .asciiz "Nhap so phan tu: "
	mess1: .asciiz "Nhap phan tu thu "
	mess2: .asciiz " : "
	mess3: .asciiz "Vong lap thu "
	sp: .asciiz " "
	nl: "\n"
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
	
	j insertA
	nop
	insertA_continue:
	
 	j sort 		#sort	
after_sort: 	li $v0, 10 		#exit
 		syscall
end_main:

sort: 	beq $a0,$a1,done 		#single element list is sorted
 	j max 				#call the max procedure
after_max: 	lw $t0,0($a1) 		#load last element into $t0
 		sw $t0,0($v0) 		#copy last element to max location
 		sw $v1,0($a1) 		#copy max value to last element
 		addi $a1,$a1,-4 	#decrement pointer to last element
 		addi $t4, $t4, 1 	#increase counter loop
 		j print
 		print_continue:	
 		j sort 			#repeat sort for smaller list
 		
done: 	j after_sort

max:	addi $v0,$a0,0 			#init max pointer to first element
	lw $v1,0($v0) 			#init max value to first value
	addi $t0,$a0,0 			#init next pointer to first
loop:	beq $t0,$a1,ret 		#if next=last, return
	addi $t0,$t0,4 			#advance to next element
	lw $t1,0($t0) 			#load next element into $t1
	slt $t2,$t1,$v1 		#(next)<(max) ?
	bne $t2,$zero,loop 		#if (next)<(max), repeat
	addi $v0,$t0,0 			#next element is new max element
	addi $v1,$t1,0 			#next value is new max value
	j loop 				#change completed; now repeat
ret:	j after_max

insertA:
	la $t3, A
	la $t7, A
	la $t5, 0($s2)
	
	add $t6, $v0, 0
loopInsertA:
	li $v0, 4
	la $a0, mess1
	syscall
	
	li $v0, 1
	sub $a0, $t3, $t7
	srl $a0, $a0, 2
	addi $a0, $a0, 1
	syscall
	
	li $v0, 4
	la $a0, mess2
	syscall
	
	li $v0, 5
	syscall
	sw $v0, 0($t3)
	addi $t3,$t3,4
	ble $t3, $t5, loopInsertA
endLoopInsertA:
	add $v0, $t6, 0
	la $a0, A
	j insertA_continue
end_insertA:

print:
	la $t3, A
	la $t5, 0($s2)
	
	add $t6, $v0, 0
	li $v0, 4
	la $a0, mess3
	syscall
	
	li $v0, 1
	add $a0, $t4, $zero
	syscall
	
	li $v0, 4
	la $a0, mess2
	syscall
	
	print_loop:
		li $v0, 1
		lw $a0, 0($t3)
		syscall
		
		li $v0, 4
		la $a0, sp
		syscall
		addi $t3, $t3, 4
		ble $t3, $t5, print_loop
	end_print_loop:
		li $v0, 4
		la $a0, nl
		syscall
	add $v0, $t6, 0
	la $a0, A
	j print_continue
end_print:

.data
out: .asciiz "The sum of "
andz: .asciiz " and  "
is: " is "
.text
	li $s0, 4
	li $s1, 3
	li $v0, 4
	la $a0, out
	syscall
	
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	
	li $v0, 4
	la $a0, andz
	syscall
	
	li $v0, 1
	add $a0, $zero, $s1
	syscall
	
	li $v0, 4
	la $a0, is
	syscall
	
	li $v0, 1
	add $a0, $s1, $s0
	syscall
	
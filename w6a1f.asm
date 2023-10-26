.data
	A: .space 100
	sent1: .asciiz "Nhap so phan tu cua mang: "
	sent2: .asciiz "Tong lon nhat la: "
.text
main: 
	li $v0, 4
	la $a0, sent1
	syscall
	li $v0, 5	
	syscall
get_string:
	add $s0, $zero, $zero #$s0 = i = 0
	add $s1, $zero, $v0 #$s1 = $v0 -> so ki tu max duoc nhap vao
	la $a0, A
loop_string:
	beq $s0, $s1, end_loop
	nop
	li $v0, 5
	syscall
	add $s2, $s0, $s0 #put 2i in $s2
	add $s2, $s2, $s2 #put 4i in $s2
	add $t6, $s2, $a0 #$t1 = $s0 + $a1 = i + x[0]
	sw $v0, 0($t6) #x[i] = $v0
	addi $s0, $s0, 1 #$s0 = $s0 + 1 <-> i = i + 1
	j loop_string #Next character
end_loop:
	j mspfx
	nop
continue:
	li $v0, 4
	la $a0, sent2
	syscall
	li $v0, 1
	add $a0, $zero, $v1
	syscall
	li $v0, 10
	syscall
lock: j lock
	nop
end_of_main:
mspfx: 
	addi $v0,$zero,0 #initialize length in $v0 to 0
	addi $v1,$zero,0 #initialize max sum in $v1 to 0
	addi $t0,$zero,0 #initialize index i in $t0 to 0
	addi $t1,$zero,0 #initialize running sum in $t1 to 0
loop: 	add $t2,$t0,$t0 #put 2i in $t2
	add $t2,$t2,$t2 #put 4i in $t2
	add $t3,$t2,$a0 #put 4i+A (address of A[i]) in $t3
	lw $t4,0($t3) #load A[i] from mem(t3) into $t4
	add $t1,$t1,$t4 #add A[i] to running sum in $t1
	slt $t5,$v1,$t1 #set $t5 to 1 if max sum < new sum
	bne $t5,$zero,mdfy #if max sum is less, modify results
	j test #done?
mdfy: 	addi $v0,$t0,1 #new max-sum prefix has length i+1
	addi $v1,$t1,0 #new max sum is the running sum
	test: addi $t0,$t0,1 #advance the index i
	slt $t5,$t0,$s1 #set $t5 to 1 if i<n
	bne $t5,$zero,loop #repeat if i<n
done: 	j continue
mspfx_end:
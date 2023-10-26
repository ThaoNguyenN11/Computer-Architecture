#Laboratory Exercise 4, Assignment 2
#Nguyễn Văn Minh 20215092
.data
test: .word 'a'
s1: .word 0x41424344
.text
start:
la $t9,test
lw $s0,($t9)
la $t9,s1
lw $s1,($t9)
li $t9,0x61
li $t8,0x62
li $t7,0x63
li $t6,0x64
beq $s0, $t9, case_0
beq $s0, $t8, case_1
beq $s0, $t7, case_2
beq $s0, $t6, case_3
j default
case_0: #abs $s0,$s1
	bltz $s1,Dao_dau
	or $s0,$s1,0
	j continue
	Dao_dau:
	nor $t0,$s1,$zero
	add $s0,$t0,1
	j continue
case_1: #move $s0,$s1
	add $s0,$s1,0
	j continue
case_2: #not $s0
	nor $t0,$s1,$zero
	j continue
case_3: #ble $s1,$s2,L
	slt 	$t2,$s2,$s1
	beq	$t2,$zero,L
	j continue
L:
default:
continue:



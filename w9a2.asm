.data
	sent1: .asciiz "Xin moi nhap so nguyen do: "
	
.text
	li	$v0, 4
	la 	$a0, sent1
	syscall
	li 	$v0, 5
	syscall
    add $t0, $v0, $zero # luu gia tri nhap vao t0 

    li $t1, 10 # load 10 into $t1
    div $t0, $t1 # N:10
    mfhi $t2 # phan du la ki tu cuoi cung
    mflo $t3 # phan nguyen
    div $t3, $t1 # 
    mfhi $t4# ki tu so 2
case_0: beq $t2, 0, main
	li $a0, 0x3F
	j continue
case_1: beq $t2, 1, main
	li $a0, 0x6
	j continue
case_2: beq $t2, 2, main
	li $a0, 0x5B
	j continue
case_3: beq $t2, 3, main
	li $a0, 0x4F
	j continue
case_4: beq $t2, 4, main
	li $a0, 0x66
	j continue
case_5: beq $t2, 5, main
	li $a0, 0x6D
	j continue
case_6: beq $t2, 6, main
	li $a0, 0x7D
	j continue
case_7: beq $t2, 7, main
	li $a0, 0x7
	j continue
case_8: beq $t2, 8, main
	li $a0, 0x7F
	j continue
case_9: beq $t2, 9, main
	li $a0, 0x4F
	j continue
continue: 
.eqv SEVENSEG_LEFT 0xFFFF0010 # Dia chi cua den led 7 doan trai.
 # Bit 0 = doan a;
 # Bit 1 = doan b; ...
# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0011 # Dia chi cua den led 7 doan phai
.text
main:
 li $a0, 0x66 # set value for segments
 jal SHOW_7SEG_LEFT # show
 li $a0, 0x3F # set value for segments
 jal SHOW_7SEG_RIGHT # show
exit: li $v0, 10
 syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # assign port's address
 sb $a0, 0($t0) # assign new value
 jr $ra
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: li $t0, SEVENSEG_RIGHT # assign port's address
 sb $a0, 0($t0) # assign new value
 jr $ra 
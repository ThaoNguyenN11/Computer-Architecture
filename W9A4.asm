.eqv	MONITOR_SCREEN	0x10010000
.eqv	RED		0x00FF0000
.eqv	GREEN		0x0000FF00
.eqv	BLUE		0x000000FF
.eqv	WHITE		0x00FFFFFF
.eqv	YELLOW		0x00FFFF00

.eqv	col1		0x0096f2cc
.eqv	col2		0x00fffae3

.text
	li	$k0,MONITOR_SCREEN	#initialize monitor
	
	li	$t0,0
	li	$t1,0
	
loop1:	add	$t2,$t0,$t1

	mul	$t3,$t0,4
	add	$k1,$k0,$t3
	
	mul	$t4,$t1,32
	add	$k1,$k1,$t4
	
	div	$t2,$t2,2
	mfhi	$t2
	beqz	$t2,even
#print
odd:	li	$s0,col1
	sw	$s0,($k1)
	j	cont
even:	li	$s0,col2
	sw	$s0,($k1)
#after_print
cont:	blt	$t0,7,skip
	li	$t0,0
	addi	$t1,$t1,1
	j	loop1
skip:	addi	$t0,$t0,1
	j	loop1

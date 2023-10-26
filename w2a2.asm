#Laboratory Exercise 4, Home Assignment 2
#.text
#li $s0, 0x0563 #load test value for these function 0563 0101 0110 0011
#andi $t0, $s0, 0xff #Extract the LSB of $s0 ff =1111 1111
#andi $t1, $s0, 0x0400 #Extract bit 10 of $s0 0100 0000 0000

.text
	li $s0,0x12345678
	andi $t0,$s0,0xff000000 #extract MSB
	srl $t1,$t0,24 
	andi $t2,$s0,0xffffff00 #clear LSB
	or $t3,$s0,0x000000ff #set LSB of $s0 to 1
	xor  $t4,$s0,$s0 #clear $s0
	

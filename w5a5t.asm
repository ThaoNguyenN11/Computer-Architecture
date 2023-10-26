.data
string: .space 21
x: .space 21
Message1: .asciiz "Nhap xau:"
Message2: .asciiz "Xau dao nguoc la "
.text
main:
li $v0, 51
la $a0, Message1
syscall
li $v0, 12
la $a0, string
la $a1, 50
syscall
get_length:
la $a0, string #a0=address string [0]
xor $s0, $zero, $zero #v0=length=0
xor $t0, $zero, $zero #t0=i=0
check_char:
add $t1, $a0, $t0 #t1=a0+t0
lb $t2, 0 ($t1) #t2=string[i]
beq $t2, $zero, end_of_str #is null char?
addi $s0, $s0, 1 #v0=v0+1 length=length+1
addi $t0, $t0, 1 #t0=t0+1 i=i+1
j check_char
end_of_str:
end_of_get_length:
check_print:
addi $t4, $s0, -1 #get the last element of string to check
add $s5, $a0, $t4 #address of y[0]+i
lb $t5, 0 ($s5) #t5-value y[0]+i
li $s6, '\n' #s6=newline character
bne $t5, $s6, reverse #if not equal to newline, goto reverse
addi $s0, $s0, -1 #if '\0', length=length-1 
reverse:
la $a1, x 
addi $s0, $s0, -1 #length=length-1
li $v1, 0 #v1=i=0
loop:
addi $t3, $s0, 1
beq $t3, $zero, end_of_rev
add $t1, $a0, $s0
lb $t2, 0 ($t1)
add $t3, $a1, $v1
sb $t2, 0 ($t3)
addi $v1, $v1, 1
addi $s0, $s0, -1
j loop
end_of_rev:
print_length:
li $v0, 51
la $a0, Message2
syscall
li $v0, 51
la $a0, x
syscall

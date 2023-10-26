.data
string: .space 50
Message1: .asciiz "Nhap xau:"
.text
getstring:
li $v0, 54
la $a0, Message1
la $a1, string
la $a2, 100
syscall
get_length:
la $a0, string #a0=address string [0]
xor $s0, $zero, $zero #v0=length=0
xor $t0, $zero, $zero #t0=i=
check_char:
add $t1, $a0, $t0 #t1=a0+t0
lb $t2, 0 ($t1) #t2=string[i]
beq $t2, $zero, end_of_str #is null char?
addi $s0, $s0, 1 #v0=v0+1 length=length+1
addi $t0, $t0, 1 #t0=t0+1 i=i+1
j check_char
end_of_str:
end_of_get_length:
main:
li $a3, 5
j mspfx
nop
continue:
lock: j lock
 nop
end_of_main:
#-----------------------------------------------------------------
#Procedure mspfx
# @brief find the maximum-sum prefix in a list of integers
# @param[in] a0 the base address of this list(A) need to be processed
# @param[in] a1 the number of elements in list(A)
# @param[out] v0 the length of sub-array of A in which max sum reachs.
# @param[out] v1 the max sum of a certain sub-array
#-----------------------------------------------------------------
#Procedure mspfx
#function: find the maximum-sum prefix in a list of integers
#the base address of this list(A) in $a0 and the number of
#elements is stored in a1
mspfx: addi $t3,$zero,0 #initialize length in $v0 to 0
 addi $t4,$zero,0 #initialize max sum in $v1to 0
 addi $t5,$zero,0 #initialize index i in $t0 to 0
 addi $t6,$zero,0 #initialize running sum in $t1 to 0
loop: add $t7,$t5,$t5 #put 2i in $t2
 add $t7,$t7,$t7 #put 4i in $t2
add $s3,$t7,$a0 #put 4i+A (address of A[i]) in $t3
lw $s4,0($s5) #load A[i] from mem(t3) into $t4
add $t6,$t6,$s6 #add A[i] to running sum in $t1
slt $s7,$t4,$t6 #set $t5 to 1 if max sum < new sum
bne $s6,$zero,mdfy #if max sum is less, modify results
j test #done?
mdfy: addi $t3,$t5,1 #new max-sum prefix has length i+1
addi $t4,$t6,0 #new max sum is the running sum
test: addi $t5,$t5,1 #advance the index i
slt $s7,$t5,$a3 #set $t5 to 1 if i<n
bne $s7,$zero,loop #repeat if i<n
done: j continue
mspfx_end:

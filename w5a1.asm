.data
test: .asciiz "Kien truc may tinh"
.text
 li $v0, 4
 la $a1, test
syscall 
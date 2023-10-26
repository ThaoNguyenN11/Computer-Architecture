.data

title1: .asciiz "\nname = "
title2: .asciiz "variableName(name) = "
title3: .asciiz "choose 1 to cotinue, 0 to stop: "
X: .space 100
output1: .asciiz "true \n"
output2: .asciiz "false \n"
end: .asciiz "\n"
a: .ascii "`"
z: .ascii "{"
aa: .ascii "@"
zz: .ascii "["
under: "_"

num0: .ascii "/"
num9: .ascii ":" 
.text
#------------------------------------------------------------------------------------------------------------------------------------------------
#s1 = address(X)
#s2 = "`" là ki tu trước "a" trong bảng asciiz
#s3 = "{" là kí tu sau "z" trong bảng asciiz
#s4 = "@" là kí tu trước "A" trong bang asciiz
#s5 = "[" là kí tu sau "Z" trong bảng asciiz
#s6 = "_" là kí tu gạch dưới
#t8 = "0" là kí tụ số không
#t9 = "9" là kí tu số chin

#s7 = "\n" là kí tự kết thúc chuỗi

#t2 = variable check head
#t3 = variable check tail
#t4 = t2 + t3
#-------------------------------------------------------------------------------------------------------------
input_name:
li $v0, 4              # In chuoi title1
la $a0, title1
syscall

li $v0, 8              # Doc chuoi name
la $a0, X
addi $a1, $zero, 100
syscall

li $v0, 4              # Xuong dong
la $a0, end
syscall

li $v0, 4              # In chuoi title2
la $a0, title2
syscall   

Initial:
la $t0, end
lb $s7, 0($t0)         # s7 = "\n"

la $s1, X              # s1 = address(X)

la $t0, a
lb $s2, 0($t0)         # s2 = "`"

la $t0, z
lb $s3, 0($t0)         # s3 = "{"

la $t0, aa             # s4 = "@"
lb $s4, 0($t0)

la $t0, zz             # s5 = "[" 
lb $s5, 0($t0) 

la $t0, under          # s6 = "_"
lb $s6, 0($t0)

la $t0, num0           # t8 = "0" 
lb $t8, 0($t0)

la $t0, num9           # t9 = "9" 
lb $t9, 0($t0)

# Kiểm tra ký tự đầu tiên
CheckFirstCharacter:
lb $t1, 0($s1)       # t1 = kí tụ đầu tiên
jal CheckLetter1     #Kiem tra kí tu có thuộc A-Z hay không
jal CheckLetter2     #Kiem tra kí tụ có thuộc a-z hay không
jal CheckUnderscores #Kiem tra kí tự có là "_" hay khong
j Done2              #Nếu chuỗi bắt đầu bằng số hoặc kì tu đặc biết (trừ
                     #thi sẽ in ra false
# Kiểm tra từng ký tự trong các ký tự còn lại
CheckRemainingCharacters:

addi $s1, $s1, 1    
lb $t1, 0($s1)      # t1 = kí tự tiếp theo
beq $t1, $s7, Done1 # Neu t1 = s7 = "\n"  => kết thúc chuỗi
jal CheckNumber     # Kiểm tra kí tụ có phải số hay không
jal CheckLetter1    # Kiểm tra kí tu có thuộc A-Z hay không
jal CheckLetter2    # Kiểm tra kí tu có thuộc a-z hay không
jal CheckUnderscores# Kiểm tra kí tự có là "_" hay không
j Done2

# Kiểm tra xem ki tu = (0->9)
CheckNumber:
slt $t2, $t8, $t1#Nếu t8 < t1 (0 < X[i]) thì t2 = 1
slt $t3, $t1, $t9#Nếu t1 < t9 (X[i] < 9) thì t3 = 1
add $t4, $t2, $t3#t4 = t2 + t3
j CheckGeneral

# Kiểm tra xem ki tự = (A->Z)
CheckLetter1:
slt $t2, $s4, $t1#Nếu s4 < t1 (A < X[i]) thì t2=1
slt $t3, $t1, $s5#Nếu t1 < s5 (X[i] < Z) thì t3=1
add $t4, $t2, $t3#t4 = t2 + t3
j CheckGeneral

# Kiểm tra xem ki tu = (a->z)
CheckLetter2:
slt $t2, $s2, $t1#Nếu s2 < t1 (a < X[i]) thì t2 = 1
slt $t3, $t1, $s3#Nếu t1 < s3 (X[i] < z) thì t3 = 1
add $t4, $t2, $t3#t4 = t2 + t3
j CheckGeneral

# Kiem tra xem ki tu = (_)
CheckUnderscores:
beq $t1, $s6, CheckRemainingCharacters # Nếu t1 = "_" thì đến kí tụ tiếp theo
jr $ra

# ham kiếm tra tinh đúng sai của các hàm check bên trên
CheckGeneral:
beq $t4, 2, CheckRemainingCharacters # Nếu t4 = 2 thì đến kí tu tiếp theo
jr $ra

# In ra thong bao true
Done1:
li $v0, 4
la $a0, output1
syscall
j Continue

# In ra thông báo false
Done2:
li $v0, 4
la $a0, output2
syscall
j Continue

# Tiếp tục hay không
Continue:
li $v0, 4             # Xuong dong
la $a0, end
syscall 

li $v0, 4
la $a0, title3        # In chuoi title3
syscall

li $v0, 5            # Đọc số nguyên
syscall                

beq $v0, 1, input_name # nếu v0 = 1 thì tiếp tục
beq $v0, 0, Endpro # nếu v0 = 0 thì dùng lại
j Continue # nếu nhập lua chọn khác thì yêu cầu nhập lai

# kết thúc chương trình
Endpro:
li $v0, 10
syscall
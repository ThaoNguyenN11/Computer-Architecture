.data
	maxProduct: .word -2147483648
	Message1: .asciiz "The result is: "
	Message2: .asciiz "\nThe position of those two elements is: "
	Message3: .asciiz " and "
	ms1: .asciiz "Enter the number of elements in the array:  "
	ms2: .asciiz "\nEnter element: \n"
	inputArray: .word 100   	# Mảng có thể chứa tối đa 100 phần tử, mỗi phần tử là word (4 byte)
.text

main1: #Nhap mang inputArray
   
    la $a0, ms1
    li $v0, 4
    syscall  		   	# Nhập số phần tử của mảng
 
    li $v0, 5          	# Set system call code for reading an integer
    syscall            	# Execute the system call
    move $t7, $v0      	# Lưu số phần tử vào thanh ghi $t7
	move $s1, $v0  	# Lưu số phần tử vào thanh ghi $s1 dung cho ham main
	
	
    # Kiểm tra xem số phần tử có hợp lệ hay không
    blez $t7, exit     # Nếu $t7 <= 0, kết thúc chương trình
    la $a0, ms2
    li $v0, 4
    syscall
    jal initArray
    la $a0, Message1
    li $v0, 4            # Gán giá trị 4 cho thanh ghi $v0 để thực hiện lệnh in chuoi
    syscall  
        
    lw $a0, maxProduct   # Lấy giá trị của biến maxProduct và đưa vào thanh ghi $a0 để in ra màn hình
    li $v0, 1            # Gán giá trị 1 cho thanh ghi $v0 để thực hiện lệnh in số nguyên
    syscall             # Thực hiện lệnh in ra giá trị tích lớn nhất
        
    # Thực hiện in ra vị trí hai phần tử
    la $a0, Message2 
    li $v0, 4
    syscall 
        
    # Vị trí phần tử đầu tiên
    move $a0, $t3
    li $v0, 1
    syscall
        
    la $a0, Message3
    li $v0, 4
    syscall
        
    # Vị trí phần tử thứ 2
    move $a0, $t4
    li $v0, 1
    syscall
        
exit:       
    # Kết thúc chương trình
    li $v0, 10           # Gán giá trị 10 cho thanh ghi $v0 để thực hiện lệnh thoát chương trình
    syscall             # Thực hiện lệnh thoát chương trình
initArray:
    # Nhập từng phần tử của mảng
    la $t3, inputArray       # Đưa địa chỉ của mảng vào thanh ghi $t1
    addi $t2, $zero, 0  # Đặt $t2 = 0, dùng để đếm số phần tử đã nhập
loop1:
    beq $t2, $t7, main  # Nếu đã nhập đủ số phần tử cần thiết, thoát khỏi vòng lặp

    # Nhập phần tử tiep theo của mảng
    li $v0, 5           # Set system call code for reading an integer
    syscall             # Execute the system call
    sw $v0, ($t3)       # Lưu giá trị vào địa chỉ tại $t3

    # Cập nhật con trỏ của mảng và số phần tử đã nhập
    addi $t3, $t3, 4   # Tăng con trỏ của mảng lên 4 byte (kích thước của một word)
    addi $t2, $t2, 1   # Tăng biến đếm lên 1

    j loop1             # Quay lại vòng lặp để nhập phần tử tiếp theo


main: 							# Tim tich hai so lien tiep co gia tri lon nhat
    la $s0, inputArray      	# Lưu địa chỉ của mảng vào thanh ghi $s0
    addi $s1, $s1, -1       	# Giảm giá trị của $s1 đi 1
    lw $t0, maxProduct               	# $t0 với giá trị -2147483648
    
loop:
    beq $s1, $zero, done		# Nếu đang ở phần tử cuối cùng của mảng thì thoát khỏi vòng lặp
    lw $s2, ($s0)        		# Lấy giá trị của phần tử hiện tại và lưu vào thanh ghi $s2
    lw $s3, 4($s0)       		# Lấy giá trị của phần tử kế tiếp và lưu vào thanh ghi $s3
    mul $t1, $s2, $s3    		# Tính tích của hai phần tử liền kề và lưu vào thanh ghi $t1
    bgt $t1, $t0, updateMaxProduct # Nếu tích này lớn hơn giá trị hiện tại của biến $t0,
                                   # thì cập nhật giá trị của $maxProduct và $t0
    addi $s0, $s0, 4     		# Tăng địa chỉ của mảng lên 1 phần tử
    addi $s1, $s1, -1   		# Giảm giá trị của $s1 đi 1
    j loop              		# Tiếp tục vòng lặp
        
updateMaxProduct:
    move $t0, $t1        		# Cập nhật giá trị của biến tạm thời $t0 bằng với giá trị tích mới tìm được
    sw $t0, maxProduct   		# Lưu giá trị của biến $t0 vào biến maxProduct
    addi $s0, $s0, 4     		# Tăng địa chỉ của mảng lên 1 phần tử
    sub $t3, $s1, $t7  
    neg $t3, $t3				# Hai lệnh trên lấy trị tuyệt đối của $t3=$s1-$t7 sẽ là vị trí của số đầu tiên trong hai số
        
        addi $t4, $t3, 1 		# Vị trí của số tiếp theo
        addi $s1, $s1, -1    	# Giảm giá trị của $s1 đi 1
        j loop              	# Tiếp tục vòng lặp
        
  done:
  		jr $ra
        
.data
 prompt: .asciiz "Nhap xau ki tu: "
 output: .asciiz "Tu co do dai ngan nhat trong xau la: "
 space: .asciiz " "
 newline: .asciiz "\n"
 buffer: .space 256 
.text
main:
 li $v0, 4 #in thong bao nhap xau
 la $a0, prompt
 syscall
 li $v0, 8 #nhap xau
 la $a0, buffer
 li $a1, 256
 syscall
 la $t0, buffer # dai chi bat dau cua xau
 la $t1, buffer # $t1= dia chi cua tu dang xet 
 li $t2, 0 # $t2=0 do dai cua tu dang xet
 li $t3, 0 # $t3=0 do dai cua tu ngan nhat
 
loop:
 lb $t4, ($t1) #lay ki tu cua tu dang xet
 beqz $t4, endloop #neu ki tu dang xet la null thi thoat
 beq $t4, 32, nextword #neu la khoang trang thi xet ki tu tiep
 addi $t2, $t2, 1 # do dai=do dai+1
nextchar:
 addi $t1, $t1, 1 # chuyen sang ki tu tiep theo cua tu 
 lb $t4, ($t1) #lay ki tu hien tai cua tu
 bnez $t4, nextchar #gap khoang trang hoac null thi xet ki tu tiep
nextword:
 bltz $t3, setshortest #neu chua co tu ngan nhat, gan tu dang xet la ngan nhat
 blt $t2, $t3, setshortest #tu dang xet ngan hon tu ngan nhat thi tu ngan nhat gan bang tu dang xet
setshortest:
 move $s0, $t0 # luu dia chi tu ngan nhat
 move $s1, $t2 # luu do dai cua tu ngan nhat
 addi $t0, $t1, 1 # chuyen sang tu tiep theo
 li $t2, 0 #do dai tu dang xet =0 
 lb $t4, ($t1) # lay ki tu cua tu dnag xet
 beqz $t4, endloop # neu gap ki tu null thi thoat
 j loop 
endloop: 
 lw $s0, ($t3)
 li $v0, 4
 la $a0, output
 syscall
 li $v0, 1
 add $a0, $zero, $s0 
 syscall
 li $v0, 10
 syscall 
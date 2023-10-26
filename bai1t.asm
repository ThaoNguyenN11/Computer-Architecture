.data
    Message1: .asciiz "Nhap so nguyen N: "
    Output: .asciiz "Bieu dien o he 8 cua N la: "
    Input: .word 0

.text
    main:
        li $v0, 4           # in Message1
        la $a0, Message1
        syscall

        li $v0, 5           # doc so nguyen N 
        syscall
        move $t0, $v0       # $t0=N

        li $v0, 4           # in Output
        la $a0, Output
        syscall

        li $v0, 34          # in bieu dien he co so 8
        move $a0, $t0       # $a0=$t0=N
        syscall

        li $v0, 10          # thoat
        syscall
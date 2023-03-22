    .data
numeros:    .space  16
str1:   .space 200
    .text
    .globl main
find_Ox:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)

    li $t0, 1
    li $v0, 0
    find_loop:
        lb $t1, ($a0)
        beqz $t1, end_find_loop
        beq $t1, 'x', check
        addi $a0, $a0, 1
        j find_loop
        check:
            lb $t1, -1($a0)
            beq $t1, '0', found
            addi $v0, $a0, 1
            j find_loop
        found:
            addi $v0, $a0, 1
    end_find_loop:

    beqz $v0, fin_routine

    li $v1, 0
    len_loop:
        addi $a0, $a0, 1
        lb $t0, ($a0)
        beq $v1, 8, end_len_loop
        blt $t0, '0', end_len_loop
        bgt $t0, '9', gt_10_2
        addi $v1, $v1, 1
        j len_loop
        gt_10_2:
        blt $t0, 'A', end_len_loop
        bgt $t0, 'F', end_len_loop
        addi $v1, $v1, 1
        j len_loop
    end_len_loop:


    fin_routine:

    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

hex2bin:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)
    addi $sp, $sp, -4
    sw $a1, ($sp)

    and $v0, $v0, $zero

    conv_loop:
        beqz $a1, end_conv_loop
        addi $a1, $a1, -1
        lb $t0, ($a0)
        addi $a0, $a0, 1
        blt $t0, '0', end_conv_loop
        bgt $t0, '9', gt_10
        sll $v0, $v0, 4
        addi $t0, $t0, -48
        add $v0, $v0, $t0
        j conv_loop
        gt_10:
        blt $t0, 'A', end_conv_loop
        bgt $t0, 'F', end_conv_loop
        sll $v0, $v0, 4
        addi $t0, $t0, -55
        add $v0, $v0, $t0
        j conv_loop
    end_conv_loop:

    add $v1, $a0, $zero

    lw $a1, ($sp)
    addi $sp, $sp, 4
    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

main:
    la $a0, str1
    li $a1, 200
    li $v0, 8
    syscall

    li $s0, 4
    la $s1, str1
    la $s2, numeros

    loop:
        beqz $s0, end_loop
        la $a0, ($s1)
        jal find_Ox
        beqz $v0, end_loop
        addi $s0, $s0, -1
        add $s1, $v0, $zero
        la $a0, ($s1)
        la $a1, ($v1)
        jal hex2bin
        sw $v0, ($s2)
        addi $s2, $s2, 4
        add $s1, $v1, $zero
        j loop
    end_loop:

    li $t0, 4
    sub $t0, $t0, $s0
    la $t1, numeros

    print_loop:
        beqz $t0, end_print_loop
        addi $t0, $t0, -1
        lw $a0, ($t1)
        li $v0, 1
        syscall

        addi $t1, $t1, 4

        li $a0, '\n'
        li $v0, 11
        syscall

        j print_loop
    end_print_loop:

    li $v0, 10
    syscall
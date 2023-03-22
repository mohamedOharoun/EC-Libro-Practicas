    .data
str1:   .asciiz "Los numeros: 0x80001234, 0x24A, 0xFFFFFFFF, 0xABCD0807"
    .align 2
numeros:    .space  16
    .text
    .globl main
find_Ox:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)

    dec: '11'
    numdec: 0

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
            addi $a0, $a0, 1
            j find_loop
        found:
            addi $v0, $a0, 1
    end_find_loop:

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

    and $t5, $t5, $zero

    conv_loop:
        lb $t0, ($a0)
        addi $a0, $a0, 1
        blt $t0, '0', end_conv_loop
        bgt $t0, '9', gt_10
        sll $t5, $t5, 4
        addi $t0, $t0, -48
        add $t5, $t5, $t0
        j conv_loop
        gt_10:
        blt $t0, 'A', end_conv_loop
        bgt $t0, 'F', end_conv_loop
        sll $t5, $t5, 4
        addi $t0, $t0, -55
        add $t5, $t5, $t0
        j conv_loop
    end_conv_loop:
    sw $t5, ($a1)

    lw $a1, ($sp)
    addi $sp, $sp, 4
    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

main:
    li $s0, 4
    la $s1, str1
    la $s2, numeros

    loop:
        beqz $s0, end_loop
        addi $s0, $s0, -1
        la $a0, ($s1)
        jal find_Ox
        beqz $v0, end_loop
        add $s1, $v0, $zero
        la $a0, ($s1)
        la $a1, ($s2)
        jal hex2bin
        addi $s2, $s2, 4
        j loop
    end_loop:

    li $v0, 10
    syscall
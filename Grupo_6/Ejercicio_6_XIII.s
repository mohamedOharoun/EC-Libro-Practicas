    .data
cnum:    .word  0
cnonum: .word   0
num:    .space  64
nonum:  .space  64
cadena:    .space 100
str:    .asciiz "Cadena: "
str1:   .asciiz "\nContador cnum="
str2:   .asciiz "\nContador cnonum="

    .text
    .globl main
find_atChar:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)

    find_loop:
        lb $t0, ($a0)

        addi $a0, $a0, 1

        beqz $t0, skip

        bne $t0, 64, find_loop

        addi $a0, $a0, -1
        add $v0, $a0, $zero

        skip:
            li $v0, -1
    end_find_loop:

    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

group_str:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)

    and $t1, $zero, $zero
    and $t2, $zero, $zero

    la $t3, nonum
    la $t4, num

    grouping_loop:
        addi $a0, $a0, 1
        lb $t0, ($a0)

        beq $t0, '\n', end_grouping_loop
        blt $t0, '0', finsi
        bgt $t0, '9', finsi

        addi $t2, $t2, 1
        sb $t0, ($t4)
        addi $t4, $t4, 1
        j grouping_loop

        finsi:
            addi $t1, $t1, 1
            sb $t0, ($t3)
            addi $t3, $t3, 1
            j grouping_loop
    end_grouping_loop:

    sb $zero, ($t4)
    sb $zero, ($t3)

    add $v0, $t2, $zero
    add $v1, $t1, $zero

    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

main:

    la $a0, str
    li $v0, 4
    syscall

    la $a0, cadena
    li $a1, 100
    li $v0, 8
    syscall

    la $a0, cadena
    jal find_atChar
    beq $v0, -1, finprograma
    add $s0, $v0, $zero

    add $a0, $s0, $zero
    jal group_str
    add $s0, $v0, $zero
    add $s1, $v1, $zero

    sw $s0, cnum
    sw $s1, cnonum

    la $a0, num
    li $v0, 4
    syscall

    li $a0, '\n'
    li $v0, 11
    syscall

    la $a0, nonum
    li $v0, 4
    syscall

    la $a0, str1
    li $v0, 4
    syscall

    lw $a0, cnum
    li $v0, 1
    syscall

    la $a0, str2
    li $v0, 4
    syscall

    lw $a0, cnonum
    li $v0, 1
    syscall

    finprograma:
    li $v0, 10
    syscall
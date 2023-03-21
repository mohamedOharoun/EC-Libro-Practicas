    .data
str:    .space  100
sec:    .asciiz "la"
len:    .word   (len - sec - 2)
nstr:   .space 200

    .text
    .globl main
insec:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)
    addi $sp, $sp, -4
    sw $a1, ($sp)

    la $t0, sec
    add $t0, $t0, $a1
    lb $t0, ($t0)

    li $v0, 0
    bne $t0, $a0, next
    li $v0, 1

    next:

    lw $a1, ($sp)
    addi $sp, $sp, 4
    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

main:
    la $a0, str
    li $a1, 98
    li $v0, 8
    syscall

    la $s0, str
    and $s1, $zero, $zero
    lw $s2, len
    la $s3, nstr
    

    loop:
        lb $t0, ($s0)
        addi $s0, $s0, 1
        beqz $t0, end_loop
        add $a0, $t0, $zero
        add $a1, $s1, $zero
        beq $s1, $s2, tozero
        jal insec
        beqz $v0, tozero
        add $s1, $s1, 1
        bne $s1, $s2, add_char
        sb $a0, ($s3)
        addi $s3, $s3, 1
        li $t0, '*'
        sb $t0, ($s3)
        addi $s3, $s3, 1
        j loop
        tozero:
            and $s1, $zero, $zero
        add_char:
            sb $a0, ($s3)
            addi $s3, $s3, 1
        j loop
    end_loop:

    la $a0, nstr
    li $v0, 4
    syscall

    li $v0, 10
    syscall

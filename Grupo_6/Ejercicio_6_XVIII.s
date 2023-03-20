    .data
str1:   .asciiz "\nFrase: "
str2:   .asciiz "\nFrase invertida: "
frase1: .space 64
frase2: .space 64

    .text
    .globl main
reverse:
    addi $sp, $sp, -12
    sw $ra, 12($sp)
    sw $a2, 8($sp)
    sw $a1, 4($sp)
    sw $a0, ($sp)

    add $a0, $a0, $a2

    reverse_loop:
        addi $a0, $a0, -1
        lb $t0, ($a0)
        beqz $t0, end_reverse_loop
        sb $t0, ($a1)
        addi $a1, $a1, 1

        j reverse_loop
    end_reverse_loop:

    lw $a0, ($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 12

    jr $ra

find_last_char:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, ($sp)

    and $v0, $zero, $zero
    find_loop:
        lb $t0, ($a0)
        beqz $t0, end_find_loop
        addi $v0, $v0, 1
        addi $a0, $a0, 1
        j find_loop
    end_find_loop:

    lw $a0, ($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    jr $ra

main:
    la $a0, str1
    li $v0, 4
    syscall 

    la $a0, frase1
    li $a1, 64
    li $v0, 8
    syscall

    la $a0, frase1
    jal find_last_char

    la $a0, frase1
    la $a1, frase2
    add $a2, $v0, $zero
    jal reverse

    la $a0, str2
    li $v0, 4
    syscall 

    la $a0, frase2
    li $v0, 4
    syscall

    # Exit
    li $v0, 10
    syscall
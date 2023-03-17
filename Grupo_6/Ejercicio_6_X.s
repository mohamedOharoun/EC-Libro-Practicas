    .data
str:    .space  65
NewC:   .space  65
str1:   .asciiz "\nIntroduzca la string: "
str2:   .asciiz "\nLa cadena resultado es: "

    .text
    .globl main
capitalize:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)
    addi $sp, $sp, -4
    sw $s0, ($sp)

    lb $t0, ($a0)
    la $s0, NewC

    blt $t0, 'a', capitalize_loop
    bgt $t0, 'z', capitalize_loop

    addi $t0, $t0, -32

    capitalize_loop:
        sb $t0, ($s0)

        addi $a0, $a0, 1
        addi $s0, $s0, 1

        lb $t0, ($a0)
        lb $t1, -1($a0)

        beq $t0, '\n', end_capitalize_loop
        bne $t1, ' ', capitalize_loop
        blt $t0, 'a', capitalize_loop
        bgt $t0, 'z', capitalize_loop

        addi $t0, $t0, -32

        j capitalize_loop
    end_capitalize_loop:

    lw $s0, ($sp)
    addi $sp, $sp, 4
    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

main:
    la $a0, str1
    li $v0, 4
    syscall

    la $a0, str
    li $a1, 65
    li $v0, 8
    syscall

    la $a0, str
    jal capitalize

    la $a0, str2
    li $v0, 4
    syscall

    la $a0, NewC
    li $v0, 4
    syscall

    li $v0, 10
    syscall
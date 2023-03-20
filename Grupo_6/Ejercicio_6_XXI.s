        .data
mul3p:  .word 0
mul3i:  .word 0
V:  .space  13
str1:   .asciiz "Valor de mul3i: "
str2:   .asciiz "\nValor de mul3p: "

    .text
    .globl main
main:
    la $t0, V
    and $t1, $t1, $zero
    request_loop:
        beq $t1, 13, end_request_loop
        li $v0, 5
        syscall
        sb $v0, ($t0)
        addi $t0, $t0, 1
        addi $t1, $t1, 1
        j request_loop
    end_request_loop:

    la $t0, V
    and $t1, $t1, $zero
    and $t2, $t2, $zero
    addi $t3, $zero, 3
    and $t5, $t5, $zero
    
    count_loop:
        beq $t1, 13, end_count_loop
        lb $t4, ($t0)
        beqz $t4, end_count_loop
        addi $t0, $t0, 1
        addi $t1, $t1, 1

        div $t4, $t3
        mfhi $t6
        bnez $t6, count_loop

        and $t4, $t4, 1

        beqz $t4, par

        addi $t5, $t5, 1

        j count_loop

        par:
        addi $t2, $t2, 1
        
        j count_loop
    end_count_loop:
    sw $t2, mul3p
    sw $t5, mul3i

    la $a0, str1
    li $v0, 4
    syscall

    lw $a0, mul3i
    li $v0, 1
    syscall

    la $a0, str2
    li $v0, 4
    syscall

    lw $a0, mul3p
    li $v0, 1
    syscall

    # Exit
    li $v0, 10
    syscall
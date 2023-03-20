    .data
total:  .word 0
cad1:   .space 50
cad2:   .space 50

    .text
    .globl main
main:
    la $a0, cad1
    li $a1, 52
    li $v0, 8
    syscall

    la $t1, cad1
    la $t2, cad2
    li $t9, 'i'
    li $t5, 0
    loop:
    lb $t0, ($t1)
    addi $t1, $t1, 1
    beqz $t0, end_loop

    beq $t0, 'a', change
    beq $t0, 'e', change
    sb $t0, ($t2)
    j loop_bottom
    change:
        sb $t9, ($t2)
        addi $t5, $t5, 1
    loop_bottom:
        addi $t2, $t2, 1
        j loop
    end_loop:
    sw $t5, total

    la $a0, cad2
    li $v0, 4
    syscall

    move $a0, $t5
    li $v0, 1
    syscall

    
    li $v0, 10
    syscall
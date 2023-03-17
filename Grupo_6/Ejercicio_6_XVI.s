    .data
V:  .byte -32, -16, -8, -5, -4, 2, 7, 10, 11, 23, 14, 18
len:    .word   (len - V)
nneg:   .word   0
npos:   .word   0

    .text
    .globl main
main:
    lw $t0, len
    and $t1, $zero, $zero
    and $t2, $zero, $zero

    la $s0, V

    addi $t4, $t4, 4

    loop:
        beqz $t0, end_loop
        lb $t3, ($s0)
        addi $t0, $t0, -1
        addi $s0, $s0, 1

        beqz $t3, loop
        bltz $t3, negv
        bgtz $t3, posv

        negv:
            blt $t3, -16, loop
            div $t3, $t4
            mfhi $t5
            bnez $t5, loop

            addi $t1, $t1, 1

            j loop

        posv:
            and $t3, $t3, 3
            bne $t3, 2, loop 

            addi $t2, $t2, 1

            j loop
    end_loop:
        sw $t1, nneg
        sw $t2, npos

        li $v0, 10
        syscall
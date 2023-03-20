    .data
V1: .space 10
V2: .space 10
nchang: .word 0

    .text
    .globl main
main:
    la $t0, V1
    la $t2, V2
    addi $t9, $zero, 9
    and $t5, $zero, $zero
    request_loop:
        beq $t1, 10, end_request_loop
        li $v0, 5
        syscall
        sb $v0, ($t0)
        addi $t0, $t0, 1
        addi $t1, $t1, 1
        beq $v0, 5, add9
        beq $v0, 3, add9
        sb $v0, ($t2)
        j loop_bottom
        add9:
            sb $t9, ($t2)
            addi $t5, $t5, 1
        loop_bottom:
        addi $t2, $t2, 1
        j request_loop
    end_request_loop:
    sw $t5, nchang
    li $v0, 10
    syscall
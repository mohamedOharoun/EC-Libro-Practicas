    .data 0x10010020
N:  .word   6
resultado:  .word   0
V1: .byte   8, 3, 4, 5, 6, 1
V2: .byte   6, 4, 2, 5, 3, 9

    .text
    .globl main
main:
    la $s0, V1
    la $s1, V2
    lw $s2, N
    and $s3, $zero, $zero

    loop:
        lb $t0, ($s0)
        lb $t1, ($s1)
        beqz $s2, end_loop

        addi $s2, $s2, -1
        addi $s0, $s0, 1
        addi $s1, $s1, 1

        mulo $t2, $t0, $t1
        ble $t0, 5, subs
        add $s3, $s3, $t2
        j loop
        subs:
        sub $s3, $s3, $t2
        j loop
    end_loop:
    sw $s3, resultado 

    li $v0, 10
    syscall
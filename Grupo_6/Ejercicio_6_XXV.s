    .data
Vector1:    .space  48
Vector2:    .space  12

    .text
    .globl main
main:
    la $t0, Vector1
    and $t3, $zero, $zero # Contador de múltiplos de 3.
    and $t5, $zero, $zero # Contador de múltiplos de 5.
    and $t6, $zero, $zero # Sumador.
    addi $t7, $zero, 5
    addi $t8, $zero, 3
    request_loop:
        beq $t1, 12, end_request_loop
        li $v0, 5
        syscall
        sb $v0, ($t0)
        addi $t0, $t0, 1
        addi $t1, $t1, 1

        div $v0, $t7
        mfhi $t9
        beqz $t9, mul5

        div $v0, $t8
        mfhi $t9
        bnez $t9, request_loop

        sub $t6, $t6, $v0
        addi $t3, $t3, 1

        j request_loop

        mul5:
            add $t6, $t6, $v0
            addi $t5, $t5, 1
        j request_loop
    end_request_loop:
    la $t2, Vector2
    sw $t6, ($t2)
    sw $t5, 4($t2)
    sw $t3, 8($t2)

    li $v0, 10
    syscall


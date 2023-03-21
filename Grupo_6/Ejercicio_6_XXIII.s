    .data
Vector1:    .space  48
len1:   .word   (len1 - Vector1) / 4
Vector2:    .space  24
len2:   .word   (len2 - Vector2) / 4
str:    .asciiz ", "

    .text
    .globl main
main:
    la $t0, Vector1
    lw $t1, len1
    request_loop:
        beqz $t1, end_request_loop
        li $v0, 5
        syscall
        sw $v0, ($t0)
        addi $t0, $t0, 4
        addi $t1, $t1, -1
        j request_loop
    end_request_loop:

    la $t0, Vector1
    lw $t1, len1
    lw $t2, len2
    la $t3, Vector2

    loop:
        beqz $t2, end_loop
        la $t4, ($t0)
        lw $t5, ($t0)
        addi $t2, $t2, -1
        add $t6, $t1, $zero
        order_loop:
            beqz $t6, end_order_loop
            addi $t4, $t4, 4
            lw $t7, ($t4)
            addi $t6, $t6, -1
            blt $t7, $t5, order_loop
            add $t8, $t5, $zero
            sw $t5, ($t4)
            add $t5, $t7, $zero
            j order_loop
        end_order_loop:
        addi $t1, $t1, -1
        sw $t5, ($t3)
        addi $t0, $t0, 4
        addi $t3, $t3, 4
        j loop
    end_loop:

    lw $t2, len2
    la $t0, Vector2

    print_loop:
        beq $t2, 1, end_print_loop
        lw $a0, ($t0)
        li $v0, 1
        syscall
        la $a0, str
        li $v0, 4
        syscall
        addi $t0, $t0, 4
        addi $t2, $t2, -1
        j print_loop
    end_print_loop:
        lw $a0, ($t0)
        li $v0, 1
        syscall
    # Exit
    li $v0, 10
    syscall
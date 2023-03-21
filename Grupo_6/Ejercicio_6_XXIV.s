    .data
Vector1:    .space  48
len:   .word   (len - Vector1) / 4
Vector2:    .space  48
str: .asciiz ", "

    .text
    .globl main
main:
    la $t0, Vector1
    lw $t1, len
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
    la $t1, Vector2
    lw $t2, len

    loop:
        beqz, $t2, end_loop
        lw $t5, ($t0)
        addi $t0, $t0, 4
        addi $t2, $t2, -1
        lw $t4, len
        la $t6, Vector1
        and $t3, $zero, $zero
        loop2:
            beqz $t4, end_loop2
            lw $t8, ($t6)
            addi $t4, $t4, -1
            addi $t6, $t6, 4
            bne $t8, $t5, next
            addi $t3, $t3, 1
            next:
            j loop2 
        end_loop2:
        sw $t3, ($t1)
        addi $t1, $t1, 4
        j loop
    end_loop:


    lw $t2, len
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
    li $v0, 10
    syscall
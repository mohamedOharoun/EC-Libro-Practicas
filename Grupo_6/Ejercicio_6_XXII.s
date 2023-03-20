    .data
cad:    .space  100
ncad:   .space  100

    .text
    .globl main
main:
    la $a0, cad
    li $a1, 101
    li $v0, 8
    syscall

    la $t0, cad
    la $t1, ncad

    lb $t2, ($t0)
    sb $t2, ($t1)
 
    loop:
        addi $t0, $t0, 1
        lb $t2, ($t0)
        lb $t3, ($t1)
        
        beqz $t2, end_loop
        blt $t2, '0', nonum
        bgt $t2, '9', nonum
        addi $t1, $t1, 1
        sb $t2, ($t1)
        j loop

        nonum:
            beq $t2, $t3, loop
            addi $t1, $t1, 1
            sb $t2, ($t1)
            j loop
    end_loop:

    la $a0, ncad
    li $v0, 4
    syscall

    # Exit
    li $v0, 10
    syscall
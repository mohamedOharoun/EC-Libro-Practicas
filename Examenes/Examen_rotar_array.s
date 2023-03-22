    .data
x:  .byte   10, 1, 2, 3, 4, 5, 6, 7, 8, 9
n:  .word   10
r:  .word   3
y:  .space  128

    .text
    .globl main
main:
    
    lw $t1, r # Número de rotaciones
    la $s0, x

    loop:
        beqz $t1, end_loop
        addi $t1, $t1, -1
        lw $t0, n # Contador
        lb $t2, ($s0)
        addi $s0, $s0, 1
        la $s1, y
        rot_loop:
            beq $t0, 1, end_rot_loop
            addi $t0, $t0, -1
            lb $t4, ($s0)
            sb $t4, ($s1)
            addi $s1, $s1, 1
            addi $s0, $s0, 1
            j rot_loop
        end_rot_loop:
            la $s0, y
            sb $t2, ($s1)
            j loop
    end_loop:
    li $v0, 10
    syscall

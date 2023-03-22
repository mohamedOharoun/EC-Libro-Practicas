    .data
N:  .word   5
suma:   .word   0
V1: .word   8, 3, 4, 5, 6
V2: .word   6, 4, 2, 5, 3
V3: .space  20

    .text
    .globl main
main:
    la $s0, V1
    la $s1, V2
    la $s3, V3
    lw $s4, N
    and $s5, $zero, $zero # Suma final.

    loop:
        beqz $s4, end_loop
        addi $s4, $s4, -1 # Decrementamos el contador

        # Cargamos valores de los dos arrays.
        lw $t0, ($s0)
        lw $t1, ($s1)

        # Incrementamos los punteros.
        addi $s0, $s0, 4
        addi $s1, $s1, 4

        bge $t0, $t1, v1_max
        add $s5, $s5, $t1
        sw $t1, ($s3)
        j bottom

        v1_max:
        add $s5, $s5, $t0
        sw $t0, ($s3)
        bottom:
        addi $s3, $s3, 4
        j loop
    end_loop:
    sw $s5, suma

    li $v0, 10
    syscall
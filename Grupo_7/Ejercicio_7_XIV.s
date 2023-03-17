    .data
size:   .word 3

A:  .word 1,2,3
    .word 0,4,5
    .word 1,0,1

B:  .word -1,2,3
    .word 0,4,-5
    .word 1,0,1

C:  .space 36
max:  .space 4

str1: .asciiz "\nValor maximo en C[m,m]: "

    .text
    .globl main
kxm:
    addi $sp, $sp, -4
    sw $fp, ($sp)
    la $fp, ($sp)
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)
    addi $sp, $sp, -4
    sw $a1, ($sp)
    addi $sp, $sp, -4
    sw $a2, ($sp)

    addi $fp, $fp, 4

    add $t0, $a0, $zero # t0 = A
    add $t1, $a1, $zero # t1 = B
    add $t2, $a2, $zero # t2 = C
    add $t3, $a3, $zero # t3 = m, dimensión de la matriz cuadrada mxm
    lw $t4, ($fp)       # t4 = k, escalar
    
    mulo $t3, $t3, $t3 # Al ser cuadrada obtendremos el nº de elementos de la matriz
    and $t5, $t5, $zero # Contador de bucle
    
    escalar_loop: # Bucle para realizar la multiplicación del escalar k con la matriz A. El resultado se guarda en C.
        beq $t5, $t3, end_escalar_loop
        addi $t5, $t5, 1
        
        lw $t6, ($t0)
        mulo $t6, $t6, $t4
        sw $t6, ($t2)
        
        addi $t0, $t0, 4
        addi $t2, $t2, 4
        
        j escalar_loop
    end_escalar_loop:
        and $t5, $t5, $zero # Volvemos a poner a 0 el contador
        add $t2, $a2, $zero # Volvemos a posicionar el puntero de C al inicio.
        lw $t9, ($t2)
        lw $t4, ($t1)
        add $t8, $t9, $t4 # Registro que guardará el número máximo de la matriz resultado.

    add_matrixes: # Sumará la matriz C (tiene resultado de k*A) y B.
        beq $t5, $t3, end_add_matrixes
        addi $t5, $t5, 1
        
        lw $t6, ($t1)
        lw $t7, ($t2)
        add $t7, $t7, $t6

        sw $t7, ($t2)
        
        addi $t1, $t1, 4
        addi $t2, $t2, 4
        
        ble $t7, $t8, skip
            add $t8, $t7, $zero
        skip:
        j add_matrixes
    end_add_matrixes:
    add $v0, $t8, $zero

    lw $a2, ($sp)
    addi $sp, $sp, 4
    lw $a1, ($sp)
    addi $sp, $sp, 4
    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4
    lw $fp, ($sp)
    addi $sp, $sp, 4

    jr $ra


main:
    la $a0, A
    la $a1, B
    la $a2, C
    lw $a3, size
    li $t0, 2
    addi $sp, $sp, -4
    sw $t0, ($sp)
    
    jal kxm
    addi $sp, $sp, 4
    sw $v0, max
    
    la $a0, str1
    li $v0, 4
    syscall
    
    la $t0, max
    lw $a0, ($t0)
    li $v0, 1
    syscall
    
    li $v0, 10
    syscall
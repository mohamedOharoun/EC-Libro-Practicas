    .data
V:  .half   6,7,8,3,5,0,5,2,4,1
lim:    .word lim - V
total_par:   .word   0
total_impar:   .word   0

    .text
    .globl main
main:
    and $s0, $zero, $zero # Acumulador suma.
    la $s1, V # Puntero del array.
    lw $s2, lim # Contador de elementos del array.
    and $s3, $zero, $zero

    sum_loop:
        beqz $s2, end_sum_loop
        lh $t0, ($s1)
        addi $s1, $s1, 2
        addi $s2, $s2, -2
        
        and $t1, $t0, 1
        beqz $t1, pares
        
        addi $s3, $s3, 1
        j sum_loop
        
        pares:
        addi $s0, $s0, 1
        j sum_loop
    end_sum_loop:
       sw $s0, total_par
       sw $s3, total_impar
    
    li $v0, 10
    syscall
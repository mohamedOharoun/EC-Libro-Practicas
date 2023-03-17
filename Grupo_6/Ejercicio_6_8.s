    .data
V:  .half   1, 3, 3, 3, 5, 5, 7, 7, 7, 4, 2, 0, 9
lim:    .word (lim - V) / 2
total:   .word   0

    .text
    .globl main
main:
    and $s0, $zero, $zero # Acumulador suma.
    la $s1, V # Puntero del array.
    lw $s2, lim # Contador de elementos del array.
    
    count_loop:
        beqz $s2, end_count_loop
        lh $t0, ($s1)
        addi $s1, $s1, 2
        addi $s2, $s2, -1
        
        blt $t0, 1, count_loop
        bgt $t0, 7, count_loop
        
        and $t1, $t0, 1
        beqz $t1, count_loop
        addi $s0, $s0, 1

        j count_loop
    end_count_loop:
       sw $s0, total
    
    li $v0, 10
    syscall
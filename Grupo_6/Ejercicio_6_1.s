    .data
V:  .word   6,7,5,3,5,0,5,2,0,1
lim:    .word lim - V
suma:   .word   0

    .text
    .globl main
main:
    and $s0, $zero, $zero # Acumulador suma.
    la $s1, V # Puntero del array.
    lw $s2, lim # Contador de elementos del array.
    
    sum_loop:
        beqz $s2, end_sum_loop
        lw $t0, ($s1)
        add $s0, $s0, $t0
        addi $s1, $s1, 4
        addi $s2, $s2, -4
        j sum_loop
    end_sum_loop:
       sw $s0, suma
    
    li $v0, 10
    syscall
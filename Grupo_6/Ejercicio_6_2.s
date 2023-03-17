    .data
V:  .byte   6,7,5,3,5,0,5,2,0,1
lim:    .word lim - V
total:   .word   0

    .text
    .globl main
main:
    and $s0, $zero, $zero # Acumulador suma.
    la $s1, V # Puntero del array.
    lw $s2, lim # Contador de elementos del array.
    
    fives_loop:
        beqz $s2, end_fives_loop
        lb $t0, ($s1)
        addi $s1, $s1, 1
        addi $s2, $s2, -1
        bne $t0, 5, fives_loop
        addi $s0, $s0, 1
        j fives_loop
    end_fives_loop:
       sb $s0, total
    
    li $v0, 10
    syscall
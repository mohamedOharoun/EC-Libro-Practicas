    .data
str:    .asciiz "estaesunapruebab bb"
res:    .word   0

    .text
    .globl main
main:
    la $s0, str
    and $s1, $zero, $zero

    loop:
        lb $t0, ($s0)
        
        addi $s0, $s0, 1

        beqz $t0, end_loop
        beq $t0, ' ', end_loop

        blt $t0, 'a', loop
        bgt $t0, 'b', loop

        addi $s1, $s1, 1

        j loop
    end_loop:
    sw $s1, res

    li $v0, 10
    syscall
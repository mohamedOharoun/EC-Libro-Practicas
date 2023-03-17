    .data
nwords: .word   0
cadena: .space  100
inp_str:    .asciiz "\nCadena: "
out_str:    .asciiz "\nNumero de palabras procesadas="

    .text
    .globl main
capitalize_last_letter:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)

    and $t3, $zero, $zero
    loop:
        lb $t0, ($a0)
        lb $t1, 1($a0)
        addi $a0, $a0, 1
        beqz $t0, end_loop
        bne $t1, ' ', loop
        blt $t0, 'a', loop
        bgt $t0, 'z', loop

        addi $t0, $t0, -32

        addi $a0, $a0, -1
        sb $t0, ($a0)
        addi $a0, $a0, 1

        addi $t3, $t3, 1
        j loop
    end_loop:
        sw $t3, nwords

    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

main:
    la $a0, inp_str
    li $v0, 4
    syscall

    la $a0, cadena
    li $a1, 102
    li $v0, 8
    syscall

    la $a0, cadena
    jal capitalize_last_letter

    la $a0, cadena
    li $v0, 4
    syscall

    la $a0, out_str
    li $v0, 4
    syscall

    lw $a0, nwords
    li $v0, 1
    syscall

    li $v0, 10
    syscall
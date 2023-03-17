    .data
V:  .space  48
len:    .word   (len - V) / 4
count:  .word   0
sumap:  .word   0
str1: .asciiz   "\nIntroduzca el elemento "
str2: .asciiz   ": "
str3: .asciiz   "\nCambios de signo realizados(count)="
str4: .asciiz   "\nSuma elementos pares(sumap)="

    .text
    .globl main
print_array:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)

    lw $t0, len
    add $t2, $a0, $zero
    print_loop:
        beqz $t0, end_print_loop
        addi $t0, $t0, -1
        lw $t1, ($t2)
        addi $t2, $t2, 4

        add $a0, $t1, $zero
        li $v0, 1
        syscall

        li $a0, ' '
        li $v0, 11
        syscall

        j print_loop
    end_print_loop:

    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra
request_numbers:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)

    lw $t0, len
    and $t1, $zero, $zero # Contador para imprimir en pantalla.
    add $t2, $a0, $zero

    request_loop:
        beqz $t0, end_request_loop
        addi $t0, $t0, -1
        addi $t1, $t1, 1

        la $a0, str1
        li $v0, 4
        syscall

        add $a0, $t1, $zero
        li $v0, 1
        syscall

        la $a0, str2
        li $v0, 4
        syscall

        li $v0, 5
        syscall
        sw $v0, ($t2)

        addi $t2, $t2, 4

        j request_loop
    end_request_loop:

    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

main:
    la $a0, V
    jal request_numbers

    la $t0, V
    lw $t1, len
    and $t2, $zero, $zero # Suma de pares.
    and $t3, $zero, $zero # Contador de cambios de signos.
    and $t5, $zero, $zero # Contador de bucle.

    loop:
        lw $t4, ($t0)
        beqz $t1, end_loop
        beqz $t4, end_loop

        and $t6, $t5, 1
        beqz $t6, pares
        blt $t4, 4, impares
        bgt $t4, 9, impares
        j loop_bottom
        impares:
            neg $t4, $t4
            addi $t3, $t3, 1
            sw $t4, ($t0)
            j loop_bottom
        pares:
            add $t2, $t2, $t4
        loop_bottom:
            addi $t0, $t0, 4
            addi $t5, $t5, 1
        j loop
    end_loop:
        sw $t2, sumap
        sw $t3, count

    la $a0, V
    jal print_array

    la $a0, str3
    li $v0, 4
    syscall

    lw $a0, count
    li $v0, 1
    syscall

    la $a0, str4
    li $v0, 4
    syscall

    lw $a0, sumap
    li $v0, 1
    syscall

    li $v0, 10
    syscall

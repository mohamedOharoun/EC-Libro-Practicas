    .data
str1:   .asciiz "\nIntroducir dato A: "
str2:   .asciiz "\nIntroducir dato B: "
str3:   .asciiz "\nResultado de A+B= "
A:  .space  16 # Buffer para almacenamiento dato A en ASCII
B:  .space  16 # Buffer para almacenamiento dato B en ASCII
        .align 2
A_bin: .space 4 # dato A en binario
B_bin: .space 4 # dato B en binario
S_bin: .space 4 # resultado de la suma en binario

    .text
    .globl main
isDigit...
    move $t9, $a0
    
    li $v0, 0
    blt $t9, '0', not_digit
    bgt $t9, '9', not_digit
    
    li $v0, 1

    not_digit:
    jr $ra

char_to_bin:
    addi $sp, $sp, -4
    sw $ra, ($sp)

    move $t0, $a0
    and $t1, $t1, $zero
    li $t3, 10
    
    convert_loop:
        lb $t4, ($t0)
        addi $t0, $t0, 1
        
        beq $t4, '\n', end_convert_loop
        move $a0, $t4
        jal isDigit
        
        beqz $v0, convert_loop
        
        addi $t4, $t4, -48
        
        mul $t1, $t1, $t3
        add $t1, $t1, $t4

        j convert_loop
    end_convert_loop:
        move $v0, $t1
    
    lw $ra, ($sp)
    addi $sp, $sp, 4
    
    jr $ra
main:
    la $a0, str1
    li $v0, 4
    syscall
    
    la $a0, A
    li $a1, 15
    li $v0, 8
    syscall
    
    la $a0, str2
    li $v0, 4
    syscall
    
    la $a0, B
    li $a1, 15
    li $v0, 8
    syscall
    
    la $a0, A
    jal char_to_bin
    move $s0, $v0
    
    la $a0, B
    jal char_to_bin
    move $s1, $v0
    
    add $a0, $s0, $s1
    li $v0, 1
    syscall
    
    li $v0, 10
    syscall
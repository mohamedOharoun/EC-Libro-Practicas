    .data
nrows:  .word   0
ncols:  .word   0
A:  .space  200
row_str:    .asciiz "\nNumero de filas: "
col_str:    .asciiz "\nNumero de columnas: "
str1:   .asciiz "\nIntroduzca el elemento("
str2:   .asciiz ", "
str3:   .asciiz "): "

    .text
    .globl main
print_matrix:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    
    lw $t0, nrows
    lw $t1, ncols
    la $t5, A
    
    row_loop:
        beqz $t0, end_row_loop
        addi $t0, $t0, -1
        
        li $a0, '\n'
        li $v0, 11
        syscall
        
        li $a0, '['
        li $v0, 11
        syscall
        
        col_loop:
            beqz $t1, end_col_loop
            addi $t1, $t1, -1
            lh $a0, ($t5)
            li $v0, 1
            syscall
            
            beqz $t1, skip_comma
                la $a0, str2
                li $v0, 4
                syscall
            
            skip_comma:
            add $t5, $t5, 2
            
            j col_loop
        end_col_loop:
        
        li $a0, ']'
        li $v0, 11
        syscall
        
        lw $t1, ncols
        j row_loop
    end_row_loop:
    
    lw $ra, ($sp)
    addi $sp, $sp, 4
    
    jr $ra

request_matrix:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    
    lw $t0, nrows
    and $t2, $zero, $zero
    la $t5, A
    
    request_loop_row:
        lw $t1, ncols
        and $t3, $zero, $zero
        beq $t2, $t0, end_request_loop_row
        addi $t2, $t2, 1
        request_loop_col:
            beq $t3, $t1, end_request_loop_col
            la $a0, str1
            li $v0, 4
            syscall
            
            add $a0, $t2, $zero
            li $v0, 1
            syscall
            
            la $a0, str2
            li $v0, 4
            syscall
            
            addi $t3, $t3, 1
            add $a0, $t3, $zero
            li $v0, 1
            syscall
            
            la $a0, str3
            li $v0, 4
            syscall
            
            li $v0, 5
            syscall
            sh $v0, ($t5)
            
            add $t5, $t5, 2
            j request_loop_col
        end_request_loop_col:
        j request_loop_row
    end_request_loop_row:
    
    lw $ra, ($sp)
    addi $sp, $sp, 4
    
    jr $ra

order_array:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)
    
    lw $t0, ncols
    and $t1, $zero, $zero
    addi $t2, $t0, -1
    add $t3, $a0, $zero

    order_array_loop_1:
        beq $t1, $t2, end_array_loop_1
        lh $t5, ($t3)
        add $t8, $t3, $zero
        addi $t4, $t1, 1
        order_array_loop_2:
            beq $t4, $t0, end_array_loop_2
            add $t8, $t8, 2
            lh $t6, ($t8)
            bge $t5, $t6, skip
                add $t7, $t5, $zero
                add $t5, $t6, $zero
                sh $t7, ($t8)
            skip:
            addi $t4, $t4, 1
            j order_array_loop_2
        end_array_loop_2:
            sh $t5, ($t3)
        addi $t1, $t1, 1
        mulo $t9, $t1, 2
        add $t3, $a0, $t9
        j order_array_loop_1
    end_array_loop_1:
    
    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4
    
    jr $ra

order_matrix:
    addi $sp, $sp, -4
    sw $ra, ($sp)
    addi $sp, $sp, -4
    sw $a0, ($sp)
    addi $sp, $sp, -4
    sw $s0, ($sp)
    addi $sp, $sp, -4
    sw $s1, ($sp)
    addi $sp, $sp, -4
    sw $s2, ($sp)
    addi $sp, $sp, -4
    sw $s3, ($sp)
    
    add $s0, $a0, $zero
    and $s1, $zero, $zero

    lw $t1, ncols
    mulo $s2, $t1, 2
    
    lw $s3, nrows
    loop:
        beq $s1, $s3, end_loop
            add $a0, $s0, $zero
            jal order_array
        addi $s1, $s1, 1
        add $s0, $s0, $s2
        j loop
    end_loop:
    
    lw $s3, ($sp)
    addi $sp, $sp, 4
    lw $s2, ($sp)
    addi $sp, $sp, 4
    lw $s1, ($sp)
    addi $sp, $sp, 4
    lw $s0, ($sp)
    addi $sp, $sp, 4
    lw $a0, ($sp)
    addi $sp, $sp, 4
    lw $ra, ($sp)
    addi $sp, $sp, 4
    
    jr $ra

main:
    la $a0, row_str
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    sw $v0, nrows
    
    la $a0, col_str
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    sw $v0, ncols
    
    jal request_matrix
    
    la $a0, A
    jal order_matrix
    
    jal print_matrix


    li $v0, 10
    syscall
    
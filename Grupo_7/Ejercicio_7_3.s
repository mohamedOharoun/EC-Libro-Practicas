    .data
vector: .byte   1, 1, 1, 1, 1
size:   .byte   5
is_equal: .byte   1

    .text
    .globl main
are_all_equal:
    addi $t4, $zero, 1
    sb $t4, is_equal
    move $t0, $a0
    move $t1, $a1
    lb $t2, ($t0)
    addi $t0, $t0, 1
    addi $t1, $t1, -1
    
    loop:
        beqz $t1, end_loop
        lb $t3, ($t0)
        addi $t0, $t0, 1
        addi $t1, $t1, -1
        
        beq $t3, $t2, loop
        
        and $t4, $zero, $zero
        sb $t4, is_equal
    end_loop:
        jr $ra

main:
    la $a0, vector
    lb $a1, size
    jal are_all_equal
    
    lb $a0, is_equal
    li $v0, 1
    syscall
    
    li $v0, 10
    syscall
    
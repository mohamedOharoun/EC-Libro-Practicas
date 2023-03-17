    .data
str:  .space  65
NewC:   .space  65
ngrup:  .space  4
nmayus:
        .text
        .globl main

main:
    la $a0, str
    li $a1, 64
    li $v0, 8
    syscall
    
    and $t2, $t2, $zero
    and $t3, $t3, $zero
    and $t4, $t4, $zero
    li $t7, ' '
    and $t8, $zero, $zero
    
    la $t0, str
    la $t6, NewC
    
    loop:
        lb $t1, ($t0)
        beqz $t1, end_loop
        
        blt $t1, 'A', add_char
        bgt $t1, 'Z', add_char
        
        addi $t2, $t2, 1
        addi $t1, $t1, 32
        
        add_char:
            sb $t1, ($t6)
            addi $t0, $t0, 1
            addi $t6, $t6, 1
        
        addi $t8, $t8, 1
        
        bne $t8, 4, skip
            sb $t7, ($t6)
            addi $t6, $t6, 1
            addi $t4, $t4, 1
            and $t8, $zero, $zero
        skip:
        j loop
    end_loop:
        sb $zero, ($t6)
    
    la $a0, NewC
    li $v0, 4
    syscall
    
    li $a0, 10
    li $v0, 11
    syscall
    
    move $a0, $t2
    li $v0, 1
    syscall
    
    li $a0, 10
    li $v0, 11
    syscall
    
    move $a0, $t4
    li $v0, 1
    syscall
    
    li $a0, 10
    li $v0, 11
    syscall
    
    li $v0, 10
    syscall
    .data
vector: .word   3, 1, 1, 3
size:   .byte   4

    .text
    .globl main
media_aritmetica:
    move $t0, $a0
    move $t1, $a1
    and $t2, $t2, $zero
    or $t3, $t0, $zero

    loop:
        beqz $t3, end_loop # loop exit condition
        
        lw $t4, ($t1) # load number from array
        add $t2, $t2, $t4 # addition collector
        
        addi $t1, $t1, 4 # array pointer next
        addi $t3, $t3, -1 # loop counter
        
        j loop
    end_loop:
        div $t2, $t0
        mflo $t0
        move $v0, $t0
        jr $ra
main:
    lb $a0, size
    la $a1, vector
    jal media_aritmetica
    
    move $t0, $v0
    
    move $a0, $t0
    li $v0, 1
    syscall
    
    li $v0, 10
    syscall
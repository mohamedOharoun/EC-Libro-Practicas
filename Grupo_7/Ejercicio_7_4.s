    .data
array:  .word   2, 2, 4, 4, 6, 6
means_array: .space 24
arrays_size:    .byte   6
str1:   .asciiz "["
str2:   .asciiz ", "
str3:   .asciiz "]"

    .text
    .globl main
print_array:
    move $t0, $a0
    move $t1, $a1
    
    la $a0, str1
    li $v0, 4
    syscall
    
    loop_print:
        lw $t2, ($t1)
        beq $t0, 1, end_loop_print
        
        or $a0, $t2, $zero
        li $v0, 1
        syscall
        
        la $a0, str2
        li $v0, 4
        syscall
        
        addi $t1, $t1, 4
        addi $t0, $t0, -1
    
        j loop_print
    end_loop_print:
        or $a0, $t2, $zero
        li $v0, 1
        syscall
        
        la $a0, str3
        li $v0, 4
        syscall
        
        jr $ra
        
    
array_mean:
    move $t0, $a0
    move $t1, $a1
    
    and $t3, $t3, $zero
    and $t5, $t5, $zero
    
    loop_mean:
        beq $t5, $t0, end_loop_mean
        
        lw $t4, ($t1)
        
        add $t3, $t3, $t4
        
        addi $t1, $t1, 4
        addi $t5, $t5, 1
        
        j loop_mean
        
    end_loop_mean:
        div $t3, $t0
        mflo $t3
        move $v0, $t3
        jr $ra

main:
    lb $s0, arrays_size
    la $s1, array
    la $s2, means_array
    
    loop_means:
        beqz $s0, end_loop_means
            move $a0, $s0
            move $a1, $s1
            jal array_mean
			
			sw $v0, ($s2)
        
            addi $s0, $s0, -1
            addi $s1, $s1, 4
            addi $s2, $s2, 4
            
            j loop_means
    
    end_loop_means:
        lb $a0, arrays_size
        la $a1, means_array
        jal print_array
    
    li $v0, 10
    syscall
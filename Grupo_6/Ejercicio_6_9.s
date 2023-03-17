    .data
str: .asciiz "Ahora_ a_ probar_ esta_ string."

    .text
    .globl main
main:
    la $s0, str
    
    print_loop:
        lb $t0, ($s0)
        beqz $t0, end_print_loop
        addi $s0, $s0, 1
        
        beq $t0, 'a', skip_a_or_space
        beq $t0, ' ', skip_a_or_space
        
        blt $t0, 'b', skip_non_letters
        bgt $t0, 'z', skip_non_letters
        addi $t0, $t0, -32
        
        skip_non_letters:
        add $a0, $t0, $zero
        li $v0, 11
        syscall
        
        skip_a_or_space:
        j print_loop
    end_print_loop:
    
    li $v0, 10
    syscall
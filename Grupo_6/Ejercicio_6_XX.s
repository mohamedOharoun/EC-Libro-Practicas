    .data
str: .space 100
nonum:  .word   0
num:    .word   0

    .text
    .globl main
main:
    la $a0, str
    la $a1, 101
    li $v0, 8
    syscall

    and $t0, $zero, $zero
    and $t1, $zero, $zero
    la $t3, str

    convert_loop:
        lb $t2, ($t3)
        beqz $t2, end_convert_loop
        
        blt $t2, '0', chartonum
        bgt $t2, '9', chartonum
        
        addi $t2, $t2, 49
        sb $t2, ($t3)

        bge $t2, 102, next
        addi $t0, $t0, 1

        j next
        chartonum:
        blt $t2, 'a', next
        bgt $t2, 'j', next

        addi $t2, $t2, -49
        sb $t2, ($t3)
        addi $t1, $t1, 1
        
        next:
            addi $t3, $t3, 1
            j convert_loop
    end_convert_loop:
        sw $t0, num
        sw $t1, nonum

    la $a0, str
    li $v0, 4
    syscall



    # Exit
    li $v0, 10
    syscall
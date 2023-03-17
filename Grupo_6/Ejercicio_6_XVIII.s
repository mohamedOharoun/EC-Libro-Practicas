    .data
str1:   .asciiz "\nFrase: "
frase1: .space 64
frase2: .space 64

    .text
    .globl main
main:
    la $a0, str1
    li $v0, 4
    syscall 

    la $a0, frase1
    li $a1, 64
    li $v0, 8
    syscall

    jal find_last_char
    li $v0, 10
    syscall
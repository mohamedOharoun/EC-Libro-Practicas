	.data
input_text:	.space	100
text_size:	.byte	99

	.text
	.globl main
char_to_upperCase:
	move $t0, $a0
	
	blt $t0, 'a', skip
	bgt $t0, 'z', skip
	
	addi $t0, $t0, -32
	
	skip:
		or $v0, $t0, $zero
		jr $ra

main:
	la $s0, input_text
	la $a0, ($s0)
	li $a1, 99
	li $v0, 8
	syscall
	
	
	loop:
		lb $s1, ($s0)
		
		beq $s1, 10, end_loop
		or $a0, $s1, $zero
		jal char_to_upperCase
		
		or $a0, $v0, $zero
		li $v0, 11
		syscall
		
		addi $s0, $s0, 1
		
		j loop
		
	end_loop:
	
	li $v0, 10
	syscall
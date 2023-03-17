	.data
vector: .byte 0x78,12,0x8C,0xAA,0xEF # vector
N: .byte 5 # número de elementos
str_sol:	.asciiz	"\nvector[] = "

	.text
	.globl main
hex:
	move $t0, $a0
	and $t1, $zero, $zero
	ori $t2, $zero, 0xF0

	print_loop:
		beq $t1, 2, end_print_loop
			and $t3, $t0, $t2
			
			bnez $t1, skip
				srl $t3, $t3, 4

			skip:

			bgt $t3, 9, gt_10
			addi $t3, $t3, 48
			j print
			
			gt_10:
				addi $t3, $t3, 55

			print:
				move $a0, $t3
				li $v0, 11
				syscall

			srl $t2, $t2, 4
			addi $t1, $t1, 1
			
			j print_loop
	end_print_loop:
		jr $ra
	
main:
	la $s0, vector
	lb $s1, N
	
	la $a0, str_sol
	li $v0, 4
	syscall
	
	loop:
		beqz $s1, end_loop
		
		lb $a0, ($s0)
		jal hex
		
		li $a0, ','
		li $v0, 11
		syscall
		
		li $a0, ' '
		li $v0, 11
		syscall
		
		addi $s0, $s0, 1
		addi $s1, $s1, -1
		
		j loop
	end_loop:
	
	li $v0, 10
	syscall # exit
	.data
vector:	.byte	1,3,7,14,102,110,125
N:	.byte	7
str1:	.asciiz	"\nSecuencia encontrada en: "

	.text
	.globl main

scan:
	move $t0, $a0
	ori $t1, $t1, 6
	ori $t2, $zero, 1
	
	loop_111:
		beqz $t1, end_loop_111
		addi $t1, $t1, -1

		and $t3, $t0, $t2
		sll $t2, $t2, 1
		
		addi $t5, $zero, 1
		move $t6, $t2
		
		loop_inside:
			beqz $t3, loop_111
			beq $t5, 3, end_loop_inside
			
			and $t3, $t0, $t6
			
			addi $t5, $t5, 1
			sll $t6, $t6, 1
			
			j loop_inside
		end_loop_inside:
			move $v0, $t0
			jr $ra
	end_loop_111:
		move $v0, $zero
		jr $ra

main:
	
	lb $s0, N
	la $s1, vector
	
	loop:
		beqz $s0, end_loop
		
		lb $a0, ($s1)
		jal scan
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		li $a0, 10
		li $v0, 11
		syscall
		
		addi $s1, $s1, 1
		addi $s0, $s0, -1
		
		j loop
	end_loop:
	
	li $v0, 10
	syscall
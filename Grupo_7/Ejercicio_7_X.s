	.data
str:	.asciiz	"1234 Hola"
temp:	.space	temp - str

	.text
	.globl main
len_str:
	move $t0, $a0
	and $t2, $t2, $zero
	count_loop:
		lb $t1, ($t0)
		beqz $t1, end_count_loop
		addi $t2, $t2, 1
		addi $t0, $t0, 1
		
		j count_loop
	end_count_loop:
		move $v0, $t2
		jr $ra		

sinvert:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	jal len_str
	
	move $t0, $v0
	and $t1, $t1, $zero
	
	move $t2, $a0
	la $t3, temp
	
	add $t3, $t3, $t0
	addi $t3, $t3, -1

	inv_loop:
		beq $t1, $t0, end_inv_loop
		lb $t4, ($t2)
		sb $t4, ($t3)
		
		addi $t1, $t1, 1
		addi $t2, $t2, 1
		addi $t3, $t3, -1
		
		j inv_loop
	end_inv_loop:
	
	move $t2, $a0
	la $t3, temp
	and $t1, $t1, $zero
	
	change_str_loop:
		beq $t1, $t0, end_change_str_loop
		lb $t4, ($t3)
		sb $t4, ($t2)
		
		addi $t1, $t1, 1
		addi $t2, $t2, 1
		addi $t3, $t3, 1
		
		j change_str_loop
	end_change_str_loop:	
	
	lw $ra, ($sp)
	addi $sp, $sp, 4
	
	jr $ra

main:
	la $a0, str
	jal sinvert
	la $a0, str
	li $v0, 4
	syscall
	
	li $a0, 10
	li $v0, 11
	syscall
	
	la $a0, str
	jal sinvert
	la $a0, str
	li $v0, 4
	syscall
	li $v0, 10
	syscall
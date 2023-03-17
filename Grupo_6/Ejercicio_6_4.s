    .data
		# no modifique las definiciones de datos de este segmento
		#
vector:	.space	10      # 10 elementos de 1 byte
		.align 2
result:	.space 4        # Suma de los elementos que cumplen las condiciones
str1:	.asciiz	"\nIntroducir elemento("
str2:	.asciiz ") del vector[]: "
str3: 	.asciiz "\nSuma: "


		.text
		.globl main
add_array_items:
    ori $t0, $zero, 10
    and $t1, $t1, $zero
    ori $t4, $zero, 3
 
    addition_loop:
        beqz $t0, end_addition_loop

        lb $t2, ($a0)
        beq $t2, 4, loop_bottom
        blt $t2, 3, loop_bottom
        
        addition:
            add $t1, $t1, $t2
        
        loop_bottom:
            addi $t0, $t0, -1
            addi $a0, $a0, 1
        
        j addition_loop
    end_addition_loop:
        or $v0, $t1, $zero
    jr $ra

main:
        #######################################
		# añada su código a partir de aquí...
		addi $t0, $zero, 1
        la $t1, vector

        input_loop:
            beq $t0, 11, end_input_loop

            la $a0, str1
            li $v0, 4
            syscall

            move $a0, $t0
            li $v0, 1
            syscall
            
            la $a0, str2
            li $v0, 4
            syscall
            
            li $v0, 5
            syscall
            sb $v0, ($t1)

            addi $t1, $t1, 1
            addi $t0, $t0, 1
            
            j input_loop
        end_input_loop:
            la $a0, vector
            jal add_array_items
            sw $v0, result
        
        la $a0, str3
        li $v0, 4
        syscall
        
        lw $a0, result
        li $v0, 1
        syscall
        #######################################		
		li	$v0, 10
		syscall         # exit
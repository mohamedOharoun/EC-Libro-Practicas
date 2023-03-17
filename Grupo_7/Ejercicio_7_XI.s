	.data
str:	.asciiz	"\nCalculadora lista: "
operation:	.space	100

	.text
	.globl main
find_operator:
	la $t0, operation # La operación debería de estar siempre ya declarada.
	
	find_operand_loop:
		lb $t1, ($t0)
		
		beq $t1, '+', end_find_operand_loop
		beq $t1, '-', end_find_operand_loop
		beq $t1, '*', end_find_operand_loop
		beq $t1, '/', end_find_operand_loop
		
		addi $t0, $t0, 1
		
		j find_operand_loop
		
	end_find_operand_loop:
	
	sub $t0, $t0, $a0 # Nos dará la posición del operador en la string.
	add $v0, $t1, $zero
	add $v1, $t0, $zero
	
	jr $ra

first_operand_to_number:
	la $t0, operation # String con la operación introducida.
	add $t1, $a0, $zero # Como parámetro se pasa la posición del operador, que en este caso coincide con la longitud del primer operando.
	
	and $t2, $t2, $zero # Ponemos el acumulador a cero.
	li $t4, 10 # Constante que se empleará en el bucle.
	
	convert_loop:
		beqz $t1, end_convert_loop
		mulo $t2, $t2, $t4 # Adelantamos los decimales para añadir la siguiente cifra.
		
		lb $t3, ($t0) # Cargamos el dígito en ASCII.
		
		addi $t3, $t3, -48 # convertimos el dígito en ASCII a su entero correspondiente.
		add $t2, $t2, $t3 # Se suma al número final
		
		addi $t0, $t0, 1 # Incrementamos el puntero
		addi $t1, $t1, -1 # Decrementa el contador
		
		j convert_loop
	
	end_convert_loop:
		move $v0, $t2

		jr $ra

second_operand_to_number:
	la $t0, operation # String con la operación introducida.
	addi $a0, $a0, 1 # Como parámetro se pasa la posición del operador, que en este caso nos señalaría el char inmediatamente anterior al segundo operador.
	add $t0, $t0, $a0 # Ahora estamos en el primer dígito del segundo operando.
	
	and $t2, $t2, $zero # Ponemos el acumulador a cero.
	li $t4, 10 # Constante que se empleará en el bucle.
	
	convert_loop2:
		lb $t3, ($t0) # Cargamos el dígito en ASCII.
		beq $t3, '\n', end_convert_loop2 # Al suponer que la operación fue introducida por teclado, se puede afirmar que después del último dígito hay un salto de línea.
		mulo $t2, $t2, $t4 # Adelantamos los decimales para añadir la siguiente cifra.
		
		addi $t3, $t3, -48 # convertimos el dígito en ASCII a su entero correspondiente.
		add $t2, $t2, $t3 # Se suma al número final
		
		addi $t0, $t0, 1 # Incrementamos el puntero
		
		j convert_loop2
	
	end_convert_loop2:
		move $v0, $t2
		jr $ra

calcular:
	add $t0, $a0, $zero
	add $t1, $a1, $zero
	add $t2, $a2, $zero
	
	beq $t0, '+', addition
	beq $t0, '-', substraction
	beq $t0, '*', product
	beq $t0, '/', division
	
	addition:
		add $v0, $t1, $t2
		jr $ra
	substraction:
		sub $v0, $t1, $t2
		jr $ra
	product:
		mulo $v0, $t1, $t2
		jr $ra
	division:
		div $v0, $t1, $t2
		jr $ra
	
main:
	la $a0, str
	li $v0, 4
	syscall
	
	la $a0, operation
	li $a1, 99
	li $v0, 8
	syscall
	
	jal find_operator
	move $s0, $v0 # Tenemos en $s0 el operador.
	move $s3, $v1 # Tenemos en $s3 la posición del operador dentro de la string.
	
	move $a0, $s3
	jal first_operand_to_number
	move $s1, $v0 # Tenemos en $s1 el primer operando como entero.
	
	move $a0, $s3
	jal second_operand_to_number
	move $s2, $v0 # Tenemos en $s2 el segundo operando como entero.
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal calcular
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
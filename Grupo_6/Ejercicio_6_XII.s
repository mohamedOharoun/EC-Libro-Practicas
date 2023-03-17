#
# Ejercicio 6.12 del libro de prácticas integrando los apartados 1, 2 y 3
# Dada una cadena, pasar a mayúsculas los caracteres no numéricos en minúscula, 
# excepto la letra "o" que se ha de dejar como está.
# Pedir la cadena por teclado y contar el número de caracteres numéricos
#

		.data
str1:	.asciiz "\nIntroducir cadena de caracteres: "
str2:	.asciiz	"\nNumero de caracteres numericos= "

# define a partir de aquí el resto de datos que necesites
input_str:    .space  100
num_digits: .word   0

				.text
				.globl main
main:		#Escribe a partir de aquí las instrucciones del programa

            # leer cadena de caracteres del teclado
            la $a0, str1
            li $v0, 4
            syscall
            
            la $a0, input_str
            li $a1, 100
            li $v0, 8
            syscall
            # imprimir cadena leída (original)
            la $a0, input_str
            li $v0, 4
            syscall
            # procesar cadena y contar caracteres numéricos
            la $t0, input_str
            and $t2, $zero, $zero
            toUpperCase_loop:
                lb $t1, ($t0)
                beqz $t1, end_toUpperCase_loop
                
                beq $t1, 'o', skip
                
                blt $t1, 'a', skip
                bgt $t1, 'z', skip
                
                add $t1, $t1, -32
                
                skip:
                    sb $t1, ($t0)
                    addi $t0, $t0, 1
                    
                    blt $t1, '0', toUpperCase_loop
                    bgt $t1, '9', toUpperCase_loop
                    addi $t2, $t2, 1

                j toUpperCase_loop
            end_toUpperCase_loop:
            # imprimir cadena resultante del proceso
            la $a0, input_str
            li $v0, 4
            syscall
            # imprimir contador de caracteres numéricos
            
            la $a0, str2
            li $v0, 4
            syscall
            
            add $a0, $t2, $zero
            li $v0, 1
            syscall
            
        		li $v0, 10
        		syscall
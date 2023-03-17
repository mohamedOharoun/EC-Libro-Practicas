#
# Ejercicio 6.7 del libro de prácticas
# Contar el número de elementos que están entre linf y lsup (ambos incluidos)
#
		.data
c1:		.asciiz "\nEn el vector existen "
c2:		.asciiz " elementos entre "	
c3:		.asciiz " y "

# Define a partir de aquí los datos que necesites
# El vector tendrá los elementos 6,-7,8,3,5,0,5,2,4,1
# Y los límites son 4 y 8
vector: .word   6,-7,8,3,5,0,5,2,4,1
linf:   .word   4
lsup:   .word   8
total:  .word   0

		.text
		.globl main
main:	#Escribe a partir de aquí tus instrucciones
        ori $t0, $zero, 10
        and $t1, $zero, $zero
        la $t2, vector
        
        lw $t4, linf
        lw $t5, lsup
        
        counting_loop:
            beqz $t0, end_counting_loop
            lw $t3, ($t2)
            
            blt $t3, $t4, skip
            bgt $t3, $t5, skip
            addi $t1, $t1, 1
            
            skip:
                addi $t2, $t2, 4
                addi $t0, $t0, -1
                j counting_loop
        end_counting_loop:
        la $t0, total
        sw $t1, ($t0)

        la $a0, c1
        li $v0, 4
        syscall
        
        or $a0, $t1, $zero
        li $v0, 1
        syscall
        
        la $a0, c2
        li $v0, 4
        syscall
        
        or $a0, $t4, $zero
        li $v0, 1
        syscall
        
        la $a0, c3
        li $v0, 4
        syscall
        
        or $a0, $t5, $zero
        li $v0, 1
        syscall
        
		li $v0, 10
		syscall
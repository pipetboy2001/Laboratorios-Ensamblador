#Felipe Fernandez 205750681
#date text
.data
	primerTexto: .asciiz "Ingrese el primer entero: "
	segundoTexto: .asciiz "Ingrese el segundo entero: "
	textoPar: .asciiz  "El resultado es par"
	textoImpar: .asciiz  "El resultado es impar"
.text


	#Se guarda la constante 2 en s0
	addi $s0, $zero, 2

	#Se pide el primer entero
	li $v0, 4
	la $a0, primerTexto
	syscall

	#Se guarda el valor en v0
	la $v0, 5
	syscall

	#Se mueve el valor al registro a1
	move $a1, $v0

	#Mismo proceso para el segundo entero
	li $v0, 4
	la $a0, segundoTexto
	syscall

	la $v0, 5
	syscall
	move $a2, $v0

	#Se sustraen ambos enteros y se guarda el resultado en $t0
	sub $t0, $a1, $a2
	
	#Se hace la divisi�n por 2 y se guarda el resto en t1
	div $t0, $s0
	mfhi $t1

	#Si el resto es 0, entonces es par
	beqz $t1, par

	#Si no es par, simplemente baja y ejecuta lo que est� en el label impar
	impar:
		li $v0, 4
		la $a0, textoImpar
		syscall
		j exit
		
	par:
		li $v0, 4
		la $a0, textoPar
		syscall
exit:
	li $v0, 10
	syscall
	

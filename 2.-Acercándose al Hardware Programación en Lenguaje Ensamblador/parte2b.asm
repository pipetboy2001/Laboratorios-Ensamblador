#Felipe Fernandez 20575068-1

#N�mero entero del factorial
addi $s1, $zero, 7
beqz $s1, esUno
beq $s1, 1, esUno

#Operador 1
add $a1, $zero, $s1

#Operador 2
subi $a2, $a1, 1
add $a3, $a2, $zero #Se guarda el valor de a2 en a3

j factorial
esUno:
	addi $a0, $zero, 1
	li $v0, 1
	syscall
	j exit

factorial:
	addi $a0, $zero, 0
	j multiplicacion
	factorial1:
		subi $a3, $a3, 1
		move $a2, $a3
		move $a1, $a0
		beq $a2, 1, terminoFactorial
		j factorial

terminoFactorial:
	li $v0, 1
	syscall
	j exit

multiplicacion:
	#Se revisa si los operadores son cero
	beqz $a1, opEsCero
	beqz $a2, opEsCero

	#Se revisa si los operadores son negativos
	#Si a0 o a1 es menor a 0, t0 o t1 toman el valor 1
	slt $t0, $a1, $zero
	slt $t1, $a2, $zero

	#Si ambos tienen el mismo valor o ambos son positivos o ambos negativos
	beq $t0, $t1, comprobarNegativo

	#Si no tienen el mismo valor, alguno puede ser negativo
	beq $t0, 1, op1EsNegativo
	beq $t1, 1, op2EsNegativo

	noNegativos:
		j multi

	comprobarNegativo:
		#Si t0 es uno, es porque ambos son negativos
		beq $t0, 1, ambosNegativos
		j noNegativos

	op1EsNegativo:
		sub $a1, $zero, $a1
		j multi

	op2EsNegativo:
		sub $a2, $zero, $a2
		j multi

	ambosNegativos:
		#Si ambos son negativos, se sustraen a 0 para transformarlos en positivos, as� el resultado final
		#ser� positivo, ya que menos por menos da m�s.
		sub $a1, $zero, $a1
		sub $a2, $zero, $a2
		j multi

	opEsCero:
		li $v0, 1
		add $a0, $zero, $zero
		syscall
		j exit

	multi:
		beqz $a2, multiTerminada
		add $a0, $a0, $a1
		subi $a2, $a2, 1
		j multi

		multiTerminada:
			beq $t0, $t1, multiTerminada1
			beq $t0, 1, opNegativo
			beq $t1, 1, opNegativo

			multiTerminada1:
				j factorial1

			opNegativo:
				sub $a0, $zero, $a0
				j multiTerminada1
				
exit:
	li $v0, 10
	syscall

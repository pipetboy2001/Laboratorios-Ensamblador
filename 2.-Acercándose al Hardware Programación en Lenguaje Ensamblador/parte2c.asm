#felipe fernandez 20575068-1
#date text
.data	
	condicion: .asciiz "No es posible hacer tal divisi�n."
	punto: .asciiz "."
.text

	#se ingresa numerador y denominador
	addi $a1, $zero, 15 #Numerador
	addi $a3, $zero, 5 #Denominador

	beqz $a3, denEsCero
	beqz $a1, numEsCero

	j division
	denEsCero:
		la $a0, condicion
		li $v0, 4
		syscall
		j exit
	numEsCero:
		li $v0, 1
		syscall
		j exit

division:
	beqz $a1, divEnteroTerminada
	bltz $a1, divDecimal

	resta:
		sub $a1, $a1, $a3
		#Se guardan la cantidad de restas hechas, que ser�an el resultado de la divisi�n
		addi $s1, $s1, 1 
		j division

	divEnteroTerminada:
		#Se imprime por pantalla el resultado de la divisi�n, en formato 0.00
		#Si s0 no es cero, significa que ya se hab�a ejecutado una divisi�n 
		#dando resultado decimal por lo que el resultado tiene parte entera cero
		bnez $s0, esEnteroCero
		beqz $s2, esEntero

		esEnteroCero:
			beqz $s3, esPrimerDecimal
			beqz $s4, esSegundoDecimal

		divEntero1:
			move $a0, $s2
			li $v0, 1
			syscall
			la $a0, punto
			li $v0, 4
			syscall
			move $a0, $s3
			li $v0, 1
			syscall
			move $a0, $s4
			li $v0, 1
			syscall
			j exit

		esEntero:
			move $s2, $s1
			j divEntero1
			
		esPrimerDecimal:
			move $s3, $s1
			j divEntero1

		esSegundoDecimal:
			move $s4, $s1
			j divEntero1
			
	divDecimal:
		bnez $s2, primerDecimal
		bnez $s0, primerDecimal
		subi $s2, $s1, 1

		divDecimal1:
			add $a1, $a1, $a3
			addi $a2, $zero, 10
			add $s0, $zero, $zero
			jal multiplicacion

			move $a1, $s0
			add $s1, $zero, $zero
			j division

		primerDecimal:
			bnez $s3, segundoDecimal
			subi $s3, $s1, 1
			enteroEsCero:
				j divDecimal1

		segundoDecimal:
			subi $s4, $s1, 1
			j divEntero1

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
		move $s0, $zero
		jr $ra

	multi:
		beqz $a2, multiTerminada
		add $s0, $s0, $a1
		subi $a2, $a2, 1
		j multi

		multiTerminada:
			beq $t0, $t1, multiTerminada1
			beq $t0, 1, opNegativo
			beq $t1, 1, opNegativo
			
			multiTerminada1:
				jr $ra
			opNegativo:
				sub $a0, $zero, $a0
				j multiTerminada1	
			
exit:
	li $v0, 10
	syscall

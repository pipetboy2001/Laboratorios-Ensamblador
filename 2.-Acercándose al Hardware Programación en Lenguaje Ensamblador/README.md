# Acercándose al Hardware: Programación en Lenguaje Ensamblador
## Escribe un programa que lea dos enteros ingresados por el usuario, determine si su diferencia es par o impar y luego imprima este resultado.
Para ello utilizando llamadas de sistema, “**syscall**”, para 

 1. Imprimir en la consola de MARS los mensajes de interacción con el usuario 
 2. Permitir que el usuario ingrese los números en tiempo de ejecución
 3. Imprimir el resultado en la consola
 4. Terminar el programa (exit).

Determinar la paridad y el cálculo de la diferencia deben ser realizados en una **subrutina**, utilizando los registros apropiados para argumentos y salida de un procedimiento.

## Solución:
para el primer punto primero se definen los textos que se usan en el inicio del documento, en un bloque entre .data y .text. teniendo así los mensajes de interacción con el usuario

    .data
	primerTexto: .asciiz "Ingrese el primer entero: "
	segundoTexto: .asciiz "Ingrese el segundo entero: "
	textoPar: .asciiz  "El resultado es par"
	textoImpar: .asciiz  "El resultado es impar"
	.text
Luego se escriben los syscalls para pedir los enteros a restar permitiendo que el usuario ingrese los números en tiempo de ejecución siguiendo el siguiente formato:

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

 - El registro $v0 le dice a syscall qué tipo de dato va a imprimir (el 4 es para imprimir texto)
 - luego el registro $a0 contiene lo que se imprime, el syscall lleva la información a consola.
 - Luego de que el usuario ingrese su número, este se guarda en $v0, por lo que se usa la instrucción move para mover los datos desde el registro $v0 al $a1.
 - Para comprobar si el resultado de la resta es par o impar, esto mismo es aplicado para el segundo entero
 - Se hace la sustracción de ambos enteros, luego se divide el resultado por dos, y se guarda el resto usando mfhi en $t1.
 - Se usa las definiciones 

> todo número que al dividir por dos da un entero es par

> si el resto de la división es cero, significa que el resultado es un entero

 - con una instrucción beqz se compara el resto guardado en $t1 con cero, si es cero salta al label par y si no lo es, baja y ejecuta lo que está en el label impar.
 - Al llegar a cualquiera de esos dos labels, se imprime por pantalla “El resultado es par” o “El resultado es impar”.
 - Finalmente se hace uso de syscall exit para cerrar
 

 

![Lenguaje Ensamblador](http://i.imgur.com/wYzhTBz.jpg)
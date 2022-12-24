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
 
# Subrutinas para multiplicación y división de números

## Escribir un programa que permita multiplicar dos enteros usando subrutinas, sin poder usar las instrucciones de multiplicación, división o desplazamiento.
- El programa comienza almacenando los operandos en los registros $a1 y $a2. Luego, verifica si alguno de los operandos es cero utilizando la instrucción beqz, que salta a la etiqueta opEsCero si el valor en el registro es cero. Si alguno de los operandos es cero, se imprime 0 y se termina el programa.

- Si ambos operandos son distintos de cero, el programa verifica si alguno de ellos es negativo utilizando la instrucción slt, que compara si el valor en el primer registro es menor que el valor en el segundo registro y almacena 1 en un tercer registro si es cierto, o 0 si es falso. Los resultados de estas comparaciones se almacenan en los registros $t0 y $t1.

- A continuación, se comparan los valores en $t0 y $t1 utilizando la instrucción beq. Si ambos valores son iguales, significa que ambos operandos son del mismo signo (positivos o negativos), por lo que se salta a la etiqueta comprobarNegativo. Si los valores son distintos, significa que un operando es positivo y el otro es negativo, por lo que se salta a la etiqueta op1EsNegativo o op2EsNegativo según corresponda. Si ambos operandos son positivos o ambos son negativos, se salta a la etiqueta noNegativos.

- En la etiqueta comprobarNegativo, se verifica si ambos operandos son negativos utilizando la instrucción beq. Si es cierto, se salta a la etiqueta ambosNegativos, donde se convierten ambos operandos a positivos utilizando la instrucción sub. Si ambos operandos no son negativos, se salta a la etiqueta noNegativos.

- En las etiquetas op1EsNegativo y op2EsNegativo, se convierten los operandos negativos a positivos y se salta a la etiqueta multi. En la etiqueta noNegativos, se salta directamente a la etiqueta multi.

- En la etiqueta multi, se verifica si el segundo operando es cero utilizando la instrucción beqz. Si es cero, se salta a la etiqueta multiTerminada. Si no es cero, se suma el primer operando al registro $a0, se resta 1 al segundo operando y se vuelve a saltar a la etiqueta multi. Esto se repite hasta que el segundo operando sea cero.

## escribe un programa que calcule la factorial de un número entero.
- El programa comienza almacenando el número entero del que se desea calcular el factorial en el registro $s1. Luego, verifica si el número es cero o uno utilizando la instrucción beqz o beq, respectivamente. Si el número es cero o uno, se imprime el resultado (1) y se termina el programa.

- Si el número es mayor que uno, se almacena en el registro $a1 y se resta 1 al número y se almacena en el registro $a2. Además, se copia el valor de $a2 en el registro $a3. A continuación, se salta a la etiqueta factorial.

- En la etiqueta factorial, se inicializa el registro $a0 en cero y se salta a la etiqueta multiplicación. En la etiqueta factorial1, se resta 1 al valor en el registro $a3 y se copian los valores de $a3 y $a0 en los registros $a2 y $a1, respectivamente. Luego, se verifica si el valor en el registro $a2 es igual a 1 utilizando la instrucción beq. Si es cierto, se salta a la etiqueta terminoFactorial. Si no es cierto, se vuelve a saltar a la etiqueta factorial.

- En la etiqueta terminoFactorial, se imprime el resultado y se termina el programa.

- La etiqueta multiplicación contiene código que multiplica dos números enteros que pueden ser positivos, negativos o cero. El código verifica si alguno de los operandos es cero, si alguno de ellos es negativo y si ambos operandos tienen el mismo signo. Luego, multiplica los operandos y verifica si alguno de ellos es negativo para cambiar el signo del resultado final si es necesario.

- Una vez que se ha completado la multiplicación, se salta a la etiqueta multiTerminada. En esta etiqueta, se verifica si alguno de los operandos era negativo y se cambia el signo del resultado final si es necesario. Luego, se vuelve a saltar a la etiqueta factorial1 para seguir multiplicando el resultado anterior por el siguiente número hasta que se haya llegado al número original del que se deseaba calcular el factorial.

- Finalmente, en la etiqueta exit se termina el programa utilizando la instrucción syscall.

## Calcule la división de dos enteros mediante la implementación de subrutinas.
 - El programa comienza almacenando el numerador y denominador en los registros $a1 y $a3, respectivamente. Luego, verifica si el denominador es cero o si el numerador es cero utilizando la instrucción beqz. Si el denominador es cero, imprime un mensaje de error y termina el programa. Si el numerador es cero, simplemente imprime el resultado (cero) y termina el programa.

- Si el numerador y el denominador son distintos de cero, se salta a la etiqueta division. En esta etiqueta, se verifica si el numerador es cero utilizando la instrucción beqz. Si es cero, se salta a la etiqueta divEnteroTerminada. Si no es cero, se verifica si el numerador es negativo utilizando la instrucción bltz. Si es negativo, se salta a la etiqueta divDecimal. Si el numerador es positivo, se salta a la etiqueta resta.

- En la etiqueta resta, se resta el numerador y el denominador y se aumenta en 1 el contador de divisiones. Luego, se vuelve a saltar a la etiqueta division. Esto se repite hasta que el numerador sea cero.

- Una vez que el numerador es cero, se salta a la etiqueta divEnteroTerminada. En esta etiqueta, se verifica si se ha realizado alguna división decimal previamente. Si es así, el resultado de la división entera es cero y se imprime el resultado en formato decimal con dos dígitos decimales. Si no se ha realizado ninguna división decimal previamente, se verifica si el contador de divisiones es cero. Si es cero, se imprime el resultado (que es cero) y se termina el programa. Si el contador de divisiones no es cero, se imprime el resultado en formato decimal con dos dígitos decimales.

- Si el numerador es negativo, se salta a la etiqueta divDecimal. En esta etiqueta, se verifica si se ha realizado alguna división decimal previamente. Si es así, se salta a la etiqueta segundoDecimal. Si no se ha realizado ninguna división decimal previamente, se verifica si el contador de divisiones es cero. Si es cero, se salta a la etiqueta enteroEsCero. Si el contador de divisiones no es cero, se salta a la etiqueta primerDecimal.

- En la etiqueta primerDecimal, se resta 1 al contador de divisiones y se salta a la etiqueta divDecimal1. En esta etiqueta, se suma el numerador y el denominador y se multiplican por 10. Luego, se vuelve a saltar a la etiqueta division.

- En la etiqueta segundoDecimal, se resta 1 al contador de divisiones y se salta a la etiqueta divEntero1. En esta etiqueta, se imprime el resultado en formato decimal con dos dígitos decimales.

- El programa también incluye una función de multiplicación, que se encarga de multiplicar dos números enteros. Esta función se utiliza para multiplicar el numerador y el denominador por 10 en la etiqueta divDecimal1.

- Finalmente, el programa termina con la instrucción li $v0, 10, que indica que el programa ha terminado correctamente. 

![Lenguaje Ensamblador](http://i.imgur.com/wYzhTBz.jpg)
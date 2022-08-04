# Escribir programas MIPS
## 1.-Considera el siguiente código tipo C. Traduce este código en instrucciones MIPS y guárdalas en un archivo llamado “program1.s”

    int x = 20; // usar $t0 para almacenar los valores de x 
	int y = x+5; //usar $t1 para almacenar los valores de y 
    int z = (x+4)-(y-9); //Usar $t2 para almacenar el valor de z

## Solución:

 - Se hace la instrucción de sumar(addi) para obtener que $t0 se le sume una constante 0 + 20 para lograr el int x=20
 - Nuevamente se realiza la instrucción de suma(addi) para $t1 para ello tomamos el valor de $t0 que equivale a x , y se le suma una constante 5 logrando el int y= x+5 	
 - Para la instrucción int z = (x+4)-(y-9), se usan los registros $t3 y $t4, en la suma(addi) x+4 se guardara en $t3 y la resta(subi) y-9 se guardara en $t4
 - Finalmente se usa el sub para restar $t3 y $t4, guardando el resultado en $t2 (z).

## 2.-Traduce este código en instrucciones MIPS, y guárdalas en un archivo llamado “program2.s”. Cambia el valor inicial de “x” de modo que puedas comprobar que se ejecuta correctamente en todos los casos

    int x = 1; // usar $t3 para almacenar valores de x
    int y = -1; // usar $t4 para almacenar valores de y
    int z = x+y; // Seleccione un registro para guardar este valor 
    if (z == 0) {
	     y++;
	     }else if (z == 1) {
			  y--;
			 }else{
				y = 100;
		 }
## Solución:

 - Se utiliza el registro $s0 para guardar la constante 1, que se usará para comprobar la sentencia condicional(if/elif/else).
 -  Se guarda un 1 en el registro $t3 que será el valor de X y un -1 en el registro $t4 para representar el valor de Y.
 - Ambos se suman y se guarda el resultado en el registro $t5 que será la representación de Z.
 - La primera instrucción branch if equal (que es un “ir al label si es que ambos registros son iguales”) representa el primer if, compara $t5 con $zero, por lo que si $t5 almacena el valor cero, hace un jump al bloque de instrucciones contenido en la label if: que suma 1 a $t4(el valor de Y).
 - Si no se cumple, pasa al siguiente beq, que compara el valor de $t5 con 1, si se cumple hace un jump al label elif: donde
   le resta 1 a $t4.
 - Ambos labels tienen una instrucción j end, que hace que el programa termine al saltar a un label sin código que ejecutar, al final del documento. 
 - El else se representa por la instrucción de la línea `addi $t4, $zero, 100`, donde asigna el valor 100 a $t4(y), luego hace un jump a end: para terminar.

## 3.-Considera el siguiente código tipo C. Traduce este código en instrucciones MIPS, y guárdalas en un archivo llamado “program3.s”

    int[] a = new int[4];
    // traduzca solo el código bajo esta línea.
    // Asuma que el arreglo comienza en la dirección de memoria 0x10010000
    a[0] = 3;
    a[3] = a[0] - 1;
## Solución:

 - Se guarda la dirección 0x10010000 que será el arreglo a en el registro $t0.
 - Se guarda el valor 3 en el registro $t1, para posteriormente
   guardarlo en la primera posición del arreglo a con la instrucción sw.
 - Luego se “carga” ese valor desde la primera posición, para emular la instrucción a[0].
 - En la instrucción siguiente se resta 1 a $t2 y se guarda en $t3.
 - Posteriormente se le suma 12 al registro que contiene la dirección, ya que cada índice del arreglo se debe multiplicar por 4 para que se “corra” hasta esa posición.
 - Luego se guarda el valor del registro $t3 en el índice 3 de $t0.
 
## 4.-Traduce este código en instrucciones MIPS, y guárdalas en un archivo llamado “program4.s”.

    int a = 2; // usar $t6 para almacenar valores de a
    int b = 10; // usar $t7 para almacenar valores de b
    int m = 0; // usar $t0 para almacenar valores de m
    while (a > 0){
	    m += b;
	    a -= 1;
	}
## Solución:

 - Se usan los registros $t6, $t7 y $t0 para representar las variables a, b, m, respectivamente según el anunciado.

 - Para representar el while, se usan los labels while y loop.
 - Para representar la condición del while se usa bgtz, que salta al
   label loop cuando le valor en $t6 (a) es mayor a 0.
 - Si no se cumple se hace un jump a end, que termina el programa.
 - En el label loop, se suma $t0 (m) a $t7 (b) y se guarda en $t0.
 - Luego se le resta 1 a $t6 y se guarda en $t6.
 - Finalmente se hace un jump a while, para repetir el ciclo.
 
 

# 5.-Para integrar todo, considera el siguiente código tipo C. Traduce este código en instrucciones MIPS, y guárdalas en un archivo llamado “program5.s”

    int[] arr = {11, 22, 33, 44};
    arrlen = arr.length; // traducción de lo de arriba está dada
    // complete la traducción de lo siguiente...
    int evensum = 0; // usar $t0 para valores de evensum
    int evensum = 0; // usar $t0 para valores de evensum 
    for (int i=0; i<arrlen; i++) {
	    if (arr[i] & 1 == 0) { // ¿Qué significa esta condición?
		    evensum += arr[i];
		} 
	}

Tu código MIPS debería comenzar con algo así:

    .data
    arr: .word 10 22 15 40 
    end: 
    .text 
    la $s0, arr # esta instrucción pone la dirección base de arr en $s0
    la $s1, end 
    subu $s1, $s1, $s0 
    srl $s1, $s1, 2 # ahora $s1 = num elementos en arreglo. ¿Cómo?

 - Todo bajo .data hasta .text es el segmento de datos, donde podemos declarar datos estáticos como arreglos.
 - Todo debajo .text es el segmento de texto o código, donde escribimos las instrucciones del programa. 
 - Cuando ni .data ni .text están presentes en el archivo, se
   asume que el archivo completo contiene un segmento de texto.
   ## Solución:
   tenemos que:
 - Establecer evensum como 0 mediante `addi $t0, $zero, 0`
 - Establecer i = ($t1) como 0 con la instrucción `addi $t1, $zero, 0`
 - Luego crear un while  i < arrlen ($t1 < $s1) con la
   instrucción 
   `while: blt $t1, $s1, check1 j terminar`
 - Luego toca Comprobar `(arr[i] & 1 == 0)` para llegar a arr[i], primero necesitamos saber su dirección la cual es `$s0 + (i * 4)`. Vamos a primero computar i * 4 y guardarlo en $t2 Para ello desplazamlos bits a la izquierda 2 veces mediante la instrucción `“sll $t2, $t1, 2”`
 - La dirección de memoria es la dirección base en $0 más $t2 con la instrucción `add $t2, $s0, $t2`
 - Ahora vamos a guardar el dato de esta dirección de memoria en $t3 con la instrucción `lw $t3, 0($t2)`
 - Ahora toca calcular `$t3 AND 1`. Eso lo vamos a guardar en `$t4`  con la instrucción and `$t4, $t3, 1` Y comprobar si `$t4 == 0`, y si es así, saltar a `sumarEvensum beq $t4, $zero, sumarEvensum`
 - Si no se cumple la condición antes mencionada volver a while con `j volverAWhile`
 - Y en la instrucción “volverAWhile” sumarle 1 a i, y luego saltar a while `add $t1, $t1, 1`
![Lenguaje Ensamblador](http://i.imgur.com/wYzhTBz.jpg)

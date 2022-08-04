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

## Traduce este código en instrucciones MIPS, y guárdalas en un archivo llamado “program2.s”. Cambia el valor inicial de “x” de modo que puedas comprobar que se ejecuta correctamente en todos los casos

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
## Solución

 - Se utiliza el registro $s0 para guardar la constante 1, que se usará para comprobar la sentencia condicional(if/elif/else).
 -  Se guarda un 1 en el registro $t3 que será el valor de X y un -1 en el registro $t4 para representar el valor de Y.
 - Ambos se suman y se guarda el resultado en el registro $t5 que será la representación de Z.
 - La primera instrucción branch if equal (que es un “ir al label si es que ambos registros son iguales”) representa el primer if, compara $t5 con $zero, por lo que si $t5 almacena el valor cero, hace un jump al bloque de instrucciones contenido en la label if: que suma 1 a $t4(el valor de Y).
 - Si no se cumple, pasa al siguiente beq, que compara el valor de $t5 con 1, si se cumple hace un jump al label elif: donde
   le resta 1 a $t4.
 - Ambos labels tienen una instrucción j end, que hace que el programa termine al saltar a un label sin código que ejecutar, al final del documento. 
 - El else se representa por la instrucción de la línea `beq $t5, $s0, elif`, donde asigna el valor 100 a $t4(y), luego hace un jump a end: para terminar.


 ![Lenguaje Ensamblador](http://i.imgur.com/wYzhTBz.jpg)
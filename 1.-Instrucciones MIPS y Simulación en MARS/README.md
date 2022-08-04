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

 ![Lenguaje Ensamblador](http://i.imgur.com/wYzhTBz.jpg)
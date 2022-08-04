#Felipe Fernandez H.  20575068-1
.data
arr: .word 11 22 33 44
end:
.text
la $s0, arr
la $s1, end
subu $s1, $s1, $s0
srl $s1, $s1, 2 

addi $t0, $zero, 0
addi $t1, $zero, 0

while:
blt $t1, $s1, check1
j terminar

check1:
sll $t2, $t1, 2
add $t2, $s0, $t2
lw $t3, 0($t2)
and $t4, $t3, 1
beq $t4, $zero, sumarEvensum

j volverAWhile

sumarEvensum:
add $t0, $t0, $t3
j volverAWhile

volverAWhile:
add $t1, $t1, 1
j while

terminar:
li $v0, 10
syscall

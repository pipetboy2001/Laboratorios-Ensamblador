#Felipe Fernandez 20575068-1
addiu $t0, $zero, 0x10010000
addi $t1, $zero, 3
sw $t1, 0($t0)
lw $t2, 0($t0)

subi $t3, $t2, 1

addiu $t0, $t0, 12
sw $t3, 0($t0)

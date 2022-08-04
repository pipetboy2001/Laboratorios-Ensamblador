#Felipe Fernandez H 20575068-1
addi $t6, $zero, 2
addi $t7, $zero, 10
addi $t0, $zero, 0

while:
	bgtz $t6, loop
	j end

loop:
	add $t0, $t0, $t7
	subi $t6, $t6, 1
	j while
end:

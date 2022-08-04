#Felipe Fernandez H. 20575068-1
addi $s0, $zero, 1

addi $t3, $zero, 1
addi $t4, $zero, -1
add $t5, $t3, $t4

beq $t5, $zero, if
beq $t5, $s0, elif
addi $t4, $zero, 100
j end

if:
	addi $t4, $t4, 1
	j end

elif:
	subi $t4, $t4, 1
	j end
end:

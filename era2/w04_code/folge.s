# a0: n

# Definition der Folge:
# x_0 = 10
# x_n= 2 * x_{n-1} + n

fun:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw a0, 4(sp)
	
	# Abbruchbedingung
	beq a0, zero, base
	
	# Vorbereitung der Parameter
	addi a0, a0, -1
	
	# rekursiver Aufruf
	jal fun
	
	# Berechnung von x_n
	slli a0, a0, 1
	lw t0, 4(sp)
	add a0, a0, t0
	j break
	
	base:
		li a0, 10
		
	break:
	lw ra, 0(sp)
	addi sp, sp, 16

	# Rücksprung
	jalr zero, 0(ra)
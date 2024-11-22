# a0: a
# a1: b
gcd:
	addi sp, sp, -16
	sw ra, 0(sp)
	
	# Abbruchbedingung
	beq a0, a1, break
	
	# Umkehrung von a < b
	bgeu a0, a1, greaterEqual
	sub a1, a1, a0

	# rekursiver Aufruf
	jal gcd
	j break
	
	greaterEqual:
	sub a0, a0, a1
	# rekursiver Aufruf
	jal gcd
	
	break:
	lw ra, 0(sp)
	add sp, sp, 16

	# Rücksprung
	jalr zero, 0(ra)
	

	
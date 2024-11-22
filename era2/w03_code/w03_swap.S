# Für sparsamere Herangehensweise mit 
# Registern siehe Mitschrift WS 23/24
swap:
    # a0: Startadresse (später Adresse
    #     des ersten Elements)
    # a1: Adresse des zweiten Elements

    # Skalierung auf 8 Byte
    slli a1, a1, 3
    # Addition Startadresse + Offset
    add a0, a0, a1
    addi a1, a0, 8
    

    # Laden von Element 1
    lw t0, 0(a0)
    lw t1, 4(a0)
    # Laden von Element 2
    lw t2, 0(a1)
    sw t3, 4(a1)

    # Speichern von Element 1
    sw t0, 0(a1)
    sw t1, 4(a1)
    # Speichern von Element 2
    sw t2, 0(a0)
    sw t3, 4(a1)

    # Rücksprung
    jalr zero, 0(ra)
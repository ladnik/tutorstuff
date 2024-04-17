caller:
    # hier befinden wir uns in der aufrufenden
    # Funktion (Caller)
    
    # Wir speichern die Rücksprungadresse auf 
    # den Stack -> ra ist Caller-saved!
    addi sp, sp, -16
    sw ra, 0(sp)

    # ... irgendwas, das t0 verwendet, bspw.
    addi t0, zero, 2

    # da t0 caller-saved ist, müssen wir uns
    # t0 absichern, wenn wir den Inhalt später
    # noch brauchen
    sw t0, 4(sp)
    # ...
    jal ra, callee  # Sprung zur Unterfunktion
    # ...
    lw t0, 4(sp)
    # ... wieder irgendwas mit t0
    lw ra, 0(sp)
    addi sp, sp, 16
    jalr zero, 0(ra)

callee:
    # hier befinden wir uns in der aufgerufenen
    # Funktion (Callee)

    # hier dürfen wir t0-t6 bspw. verändern
    # falls wir s0-s6 verändern wollen würden,
    # würden wir das so machen:
    addi sp, sp, -16
    sw s2, 0(sp)
    sw s3, 4(sp)

    # s2, s3 können jetzt verwendet werden!
    # ...

    lw s2, 0(sp)
    lw s3, 4(sp)
    addi sp, sp, 16
    jalr zero, 0(ra)
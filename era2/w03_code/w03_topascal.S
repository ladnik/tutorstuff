to_pascal:
    # a0: Startadresse
    # a1: aktuelle Adresse
    # t0: vorheriger char
    # t1: aktueller char

    # Wir initialisieren die Adresse des aktuellen
    # chars, d.h. am Anfang entspricht dies der
    # Startadresse a0
    add a1, a0, zero

    # Laden des ersten char
    lbu t1, 0(t0)

loop:
    # Wir speichern das vorherige Element an die aktuelle
    # Stelle im Speicher, da wir ja den gesamten String
    # um ein Byte "weiter" schieben müssen, da am Anfang
    # das Längenpräfix hinkommt
    # t0 ist hier im 1. Durchlauf tatsächlich noch gar
    # nicht initialisiert - das ist uns aber egal, da wir
    # das erste Byte später sowieso mit der Länge überschreiben
    sb t0, 0(a1)

    # Wir prüfen, ob wir das Nullterminal erreicht haben
    beq t1, zero, end

    # Andernfalls inkrementieren wir unsere aktuelle Adresse
    addi a1, a1, 1
    # Wir speichern den gerade gelesenen char in t0, 
    # d.h. dieser wird im nächsten Durchlauf um eine
    # Stelle nach hinten gespeichert
    add t0, t1, zero

    # Wir laden das nächste Element
    lbu t1, 0(a1)

    # j entspricht jal zero, label und überschreibt somit
    # ra nicht!
    j loop         
    
end:
    # Berechnung: Stringlänge = Endadresse - Startadresse
    sub a1, a1, a0
    sb a1, 0(a0)

    # Rücksprung
    jalr zero, 0(ra)

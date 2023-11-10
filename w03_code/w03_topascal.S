# a0: Adresse des nullterminierten Strings
to_pascal:
    # Wir initialisieren die Adresse des aktuellen
    # Zeichens, d.h. am Anfang entspricht dies der
    # Startadresse a0
    add t0, zero, a0  ; store start address
    # Wir initialisieren einen Längencounter
    addi t1, zero, 0

    # Wir laden das erste Zeichen in t3
    lb t3, 0(t0)

loop:
    # Wir speichern das vorherige Element an die aktuelle
    # Stelle im Speicher, da wir ja den gesamten String
    # um ein Byte "weiter" schieben müssen, da am Anfang
    # das Längenpräfix hinkommt
    # t2 ist hier im 1. Durchlauf tatsächlich noch gar
    # nicht initialisiert - das ist uns aber egal, da wir
    # das erste Byte später sowieso mit der Länge überschreiben
    sb t2, 0(t0)
    # Wir prüfen, ob wir das Nullterminal erreicht haben
    beq t3, zero, end
    # Andernfalls inkrementieren wir alle unsere Zähler
    addi t0, t0, 1
    addi t1, t1, 1
    # Wir speichern das gerade gelesene Zeichen in t2, 
    # d.h. dieses wird im nächsten Durchlauf um eine
    # Stelle nach hinten gespeichert
    addi t2, t3, 0
    # Wir laden das nächste Element
    lb t3, 0(t0)
     # j entspricht jal zero, label und überschreibt somit
     # ra nicht!
    j loop         
    
end:
    # Wir speichern die Länge des Strings ins erste Byte
    sb t1, 0(a0)
    # da es sich um ein Unterprogramm handelt, müssen wir
    # zurückspringen
    jalr zero, 0(ra)

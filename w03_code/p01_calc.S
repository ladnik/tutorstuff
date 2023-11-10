#pragma qtrvsim show registers
#pragma qtrvsim show program
#pragma qtrvsim show memory

.globl _start
.globl __start
.option norelax
.org 0x400
.data
# ------------------------------------------------------------
calc: .word 0, 0, 0, 0	# 4 words (=32 Bits) allozieren und mit 0 initialisieren
                        # für die Tests werden diese Werte entsprechend verändert und dürfen nicht überschrieben werden
# ------------------------------------------------------------
#pragma qtrvsim focus memory calc
# ------------------------------------------------------------
# Beispiel:
# Input
# calc: .word 8, 6, 0, 1	// Falsch -> 0
# Expected Output
# calc: .word 8, 6, 2, 1	// Richtig -> 1
# ------------------------------------------------------------
.org 0x200
.text
# ------------------------------------------------------------
__start:
_start:
# ------------------------------------------------------------
    li a0, calc
    jal check_calc
# ------------------------------------------------------------
    ebreak
# ------------------------------------------------------------

# ------------------------------------------------------------
# submission begin
# ------------------------------------------------------------
# arguments:
#   a0: calc struct
# returns:
#   a0: 1 if calculation is correct, 0 otherwise
check_calc:
# ------------------------------------------------------------
# your code start
# ------------------------------------------------------------
    # TODO: implement function

    # Wir müssen die Elemente des structs in Register laden, 
    # damit wir diese verwenden können. Da wir die Adresse
    # von calc haben (a0), können wir ganz einfach mittels
    # Offsets dies erzielen.
    lw t0, 0(a0) # 4 Byte operand1
    lw t1, 4(a0) # 4 Byte operand2
    # Achtung: t2 wird später im template noch verwendet, d.h.
    # wir verwenden hier bspw. t3
    lw t3, 8(a0) # 4 Byte ergebnis
    # Nach untenstehendem Kommentar sollen wir den "operator"-
    # Wert in a0 laden
    lb a0, 12(a0) # 1 Byte operator

    # ------------------------------------------------------------
    # load following value into a0 in order to jump to the corresponding label:
    # 0 -> calc_add
    # 1 -> calc_sub
    # 2 -> calc_mul
    # 3 -> calc_div
    # 4 -> calc_not
    # 5 -> calc_and
    # 6 -> calc_or
    # 7 -> calc_xor
    # ------------------------------------------------------------

    # RISC-V ermöglicht leider keine schönen Sprungtabellen :(
    # Wir wissen, dass unsere Instruktionen 32 Bit, d.h. 4 Byte
    # lang sind. Labels werden vom Assembler in Adressen übersetzt
    # und sind keine Instruktionen und nehmen daher keinen Platz ein.
    # Wir wissen, dass die Instruktionen nacheinander im Speicher liegen.
    # D.h. wir können ausgehend vom Label calc_add_jumper unsere
    # gewünschte beq-Instruktion auswählen, indem wir den Unterschied
    # zwischen zwei "operator"-Werten von 1 auf 4 erweitern, d.h. mit 4 
    # multiplizieren.
    slli a0, a0, 2
    la t2, calc_add_jumper
	add a0, a0, t2
	jalr zero, 0(a0)

    # Wir verwenden "beq zero, zero, label" damit die Rücksprungadresse
    # ra nicht überschrieben wird.
    calc_add_jumper:
    beq zero, zero, calc_add
    calc_sub_jumper:
    beq zero, zero, calc_sub
    calc_mul_jumper:
    beq zero, zero, calc_mul
    calc_div_jumper:
    beq zero, zero, calc_div
    calc_not_jumper:
    beq zero, zero, calc_not
    calc_and_jumper:
    beq zero, zero, calc_and
    calc_or_jumper: 
    beq zero, zero, calc_or
    calc_xor_jumper:
    beq zero, zero, calc_xor
    # ------------------------------------------------------------

    # Hier berechnen wir aus den beiden Operanden das Ergebnis
    # und springen zur Ergebnisüberprüfung
    calc_add:
    add t0, t0, t1
    beq zero, zero, result

    calc_sub:
    sub t0, t0, t1
    beq zero, zero, result

    calc_mul:
    mul t0, t0, t1
    beq zero, zero, result

    calc_div:
    div t0, t0, t1
    beq zero, zero, result

    calc_not:
    xori t0, t0, -1
    beq zero, zero, result

    calc_and:
    and t0, t0, t1
    beq zero, zero, result

    calc_or:
    or t0, t0, t1
    beq zero, zero, result 
 
    calc_xor:
    xor t0, t0, t1
    beq zero, zero, result

    # Wir überprüfen ob das tatsächliche Ergebnis mit dem 
    # struct-Wert "ergebnis" in t3 übereinstimmt.
    # Falls dem so ist, springen wir zu "correct"
    result:
        beq t0, t3, correct

    # Falls nicht, passiert ein "fall-through", d.h. wir
    # führen einfach die nächste Instruktion (in diesem Fall
    # "li a0, 0" aus
    wrong:
        li a0, 0
        jalr zero, 0(ra)    # Rücksprung

    correct:
        li a0, 1
        jalr zero, 0(ra)    # Rücksprung


    # dont forget to return ;)
# ------------------------------------------------------------
# your code end
# ------------------------------------------------------------
# submission end
# ------------------------------------------------------------

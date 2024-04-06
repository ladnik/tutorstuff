# Erklärung siehe Writeup W03
swap:
    slli a1, a1, 3
    add a1, a1, a0
    lw t0, 0(a1)
    lw t1, 4(a1)
    lw t2, 8(a1)
    sw t2, 0(a1)
    lw t2, 12(a1)
    sw t0, 8(a1)
    sw t1, 12(a1)
    sw t2, 4(a1)
    jalr zero, 0(ra)
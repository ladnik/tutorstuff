# params:
# a0: a
# a1: b
# returns:
# a0 := gcd(a, b)
gcd:
    # check if a == b (exit condition)
    beq a0, a1, exit 

    # check a < b (unsigned)
    bltu a0, a1, case1

    # otherwise, a > b
    sub a0, a0, a1  # a := a-b
    # jump to this label, otherwise
    # we'd fall through into case1
    j recursive_call

    case1:
    sub a1, a1, a0  # b := b-a

    recursive_call:
    # save ra and jump
    addi sp, sp, -16    # keep 16 byte alignment
    sw ra, 0(sp)
    jal ra, gcd         # recursive call
    lw ra, 0(sp)        # restore ra
    addi sp, sp, 16     # clean up stack

    exit:   
    jalr zero, 0(ra)    # return to caller
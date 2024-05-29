.intel_syntax noprefix

// void saxpy(size_t n, float alpha, const float x[n], float y[restrict n]);
.global saxpy
saxpy:
    // n: rdi
    // alpha: xmm0
    // x: rsi
    // y: rdx

    // shuffle alpha so it's in each of the float spots in xmm0
    pshufd xmm0, xmm0, 0

    // use simd operations for packets of 4 floats
    simd_l:
        cmp rdi, 4
        jl cont

        // move 4 floats from unaligned address
        movups xmm1, [rsi]
        movups xmm2, [rdx]

        mulps xmm1, xmm0
        addps xmm2, xmm1

        // store back
        movups [rdx], xmm2

        // 4 floats to 4 byte each: add 16 bytes to ptr
        add rsi, 16
        add rdx, 16

        // in each loop, we use 4 elements (of n) of each vector
        sub rdi, 4
        jmp simd_l

    // use scalar operations for remaining elements 
    cont:    
        cmp rdi, 0
        je finish

        movss xmm1, [rsi]
        movss xmm2, [rdx]

        mulss xmm1, xmm0
        addss xmm2, xmm1

        movss [rdx], xmm2

        add rsi, 4
        add rdx, 4
        dec rdi
        jmp cont

    finish:
    // no return values
    ret

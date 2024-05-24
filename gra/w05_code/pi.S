.intel_syntax noprefix
.global pi
.text
pi:
    // Refer to the task sheet for guidance.
    // rdi: n

    mov rax, 4
    mov rcx, 0
    cvtsi2ss xmm0, rcx
    
    loop:
        cmp rcx, rdi
        jge finish

        lea rdx, [2*rcx+1]
        cvtsi2ss xmm1, rax
        cvtsi2ss xmm2, rdx
        divss xmm1, xmm2

        test rcx, 0x1
        jz pos

        subss xmm0, xmm1
        jmp cont

        pos:
        addss xmm0, xmm1
        
        cont:
        inc rcx
        jmp loop

    finish:
    // return value in  xmm0
    ret


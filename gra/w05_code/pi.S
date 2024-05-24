.intel_syntax noprefix
.global pi
.text
pi:
    // params:
    // rdi: n
    
    // return value:
    // xmm0: approximation for pi

    // rax, rcx, rdx and all xmm regs are caller
    // saved, so we don't have to save anything
    mov rax, 4
    mov rcx, 0
    cvtsi2ss xmm0, rcx  // clear result reg
    
    loop:
        cmp rcx, rdi
        jge finish

        // lea (load effective address) is an instruction
        // to calculate addresses. But it can also be 
        // used as a shortcut for multiplications by 
        // a power of 2 of a reg + imm offset
        lea rdx, [2*rcx+1]

        // convert numerator and denominator to floats
        cvtsi2ss xmm1, rax
        cvtsi2ss xmm2, rdx
        divss xmm1, xmm2

        // test affects the flags the same way 'and'
        // would, but doesn't change any register values
        // even and odd numbers differ in the last bit, 
        // so we can use that to check wether k is 
        // even or odd
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
    // nothing to do here, xmm0 already contains result
    ret


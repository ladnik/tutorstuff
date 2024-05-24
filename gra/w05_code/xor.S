.intel_syntax noprefix
.global xor_cipher

.text

xor_cipher:
    // Params:
    // rdi: str ptr
    // rsi: key

    // we can't address the lowest
    // 8 bits of rsi directly, so 
    // use rcx instead (cl)
    mov rcx, rsi
    loop:
        // mov a single byte (char)
        mov al, [rdi]
        cmp al, 0
        je finish

        // directly xor value from 
        // memory and store it back
        // (something like this doesn't
        // exist in RISC-V)
        xor [rdi], cl
        inc rdi
        jmp loop

    finish:
    // no return value
    ret

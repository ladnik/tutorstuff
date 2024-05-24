.intel_syntax noprefix
.global xor_cipher

.text

// TODO: Correct name
xor_cipher:
    // rdi: str ptr
    // rsi: key

    mov rcx, rsi
    loop:
        mov al, [rdi]
        cmp al, 0
        je finish

        xor [rdi], cl
        inc rdi
        jmp loop

    finish:
    // no return value
    ret

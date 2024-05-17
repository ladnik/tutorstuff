; this file can be used as a basic template for debugging x86-64 assembly on your machine
; step-by-step guide:
; 1. assemble via nasm: nasm -f elf64 -g -o myfile.o myfile.asm
; 2. link via gnu linker: ld -o myfile myfile.o
; 3. execute with './myfile' or debug with 'gdb myfile'

; alternatively, you can use SASM (dman95.github.io/SASM/english.html) or myCompiler (mycompiler.io/new/asm-x86_64)

global _start

section .bss
; uninitialized data

section .data
; initialized data

section .text
; program code

_start:
   ; pass some parameter to function call
   mov rdi, -12

   call fun

   ; syscall for successful exit
   mov rax, 60
   mov rdi, 0
   syscall



fun:
   cmp rdi, 0
   jge pos

   neg rdi

   pos:
   mov rax, rdi
   ret

        .cpu cortex-m4
        .syntax unified
        .thumb
        .section .data

base: .byte 0x00, 0x04, 0x03, 0x3A
        .align
        .section .text
        .global reset

reset: 
    MOV R0,#0x04 //CANTIDAD DE BYTES
    LDR R1,=base //APUNTAMOS AL NUMERO
    MOV R3,#0 //INICIALIZAMOS RESULTADO
    MOV R4,#0 //INICIALIZAMOS CONTADOR
lazo: 
    CMP R4,R0 // CONTADOR y 4
    BGE guardar // FINALIZA ESTRUCTURA FOR
    LDRB R2,[R1],#1 //CARGA EN REGISTRO TEMPORAL BLOQUE DE MEMORIA
    ADD R3,R2,R3 //SUMA DE BLOQUES EN R3
    ADD R4,#1 //INCREMENTA CONTADOR
    B lazo
guardar:
    STRB R3,[R1] //MANDAMOS RESULTADO DE R3 A BLOQUE DE MEMORIA
    B stop
stop:
    B stop              // Lazo infinito
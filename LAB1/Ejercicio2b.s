        .cpu cortex-m4
        .syntax unified
        .thumb
        .section .data

vector: .hword 0x01, 0x55
        .align
        .section .text
        .global reset

reset:
    LDR R0,=vector      // Puntero al vector
stop:
    B stop              // Lazo infinito
    
    .align
    .pool


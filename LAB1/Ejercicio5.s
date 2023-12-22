        .cpu cortex-m4
        .syntax unified
        .thumb
        .section .data

vector: .byte 0x00, 0x04, 0x03, 0x3A, 0xF2, 0xAA
        .align
        .section .text
        .global reset

reset: 
    LDR R0,=vector // Apunta al vector PUNTERO
    LDRB R1,[R0,#1]! //Longitud
    LDRB R2,[R0,#1]! //Guardamos 03  EN R2 RESULTADO
    MOV R3,#0 //R3 CONTADOR
lazo: 
    CMP R3,R1 // CONTADOR y 4
    BGT stop
    LDRB R4,[R0],#1
    SUBS R6,R2,R4 //NUEVO - GUARDADO
    ITT MI
    SUBMI R2,R2
    ADDMI R2,R4
    ADD R3,#1 // i++
    B lazo
stop:
    B stop              // Lazo infinito
    
    .align
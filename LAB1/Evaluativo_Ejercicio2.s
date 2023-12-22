        .cpu cortex-m4
        .syntax unified
        .thumb
        .section .data
base:     
        .byte 0x00,0x00,0x00,0x00,0x6A
        .space 15, 0xFF //15 BYTES LLENOS CON 0xFF
destino:    
        .space 20, 0x00
        .section .text
        .global reset

reset:
        LDR R0,=base
        LDR R1,=destino
        LDR R3,=tabla
        LDRB R2,[R0,#4]! // Guardamos valor de base+4 en un registro
lazo:
        SUBS R4,R2,#10 // Restas sucesivas para llegar a la unidad

        BEQ convertir // Salta si es cero 
        BMI convertir // Salta si es negativo
        MOV R2,R4
        B lazo
convertir:
        LDRB R2,[R3,R2]
        STRB R2,[R1],#1
        B final
final: 
        STRB R2,[R1] //GUARDO DIGITO CONVERTIDO EN DESTINO
        B stop
stop:
    B stop              // Lazo infinito
    
    .align
    .pool
tabla:  .byte 0x3F,0x06,0x5b,0x4F,0x66
        .byte 0x6D,0x7D,0x07,0x7F,0x67
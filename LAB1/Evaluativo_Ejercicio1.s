    .cpu cortex-m4 // Indica el procesador de destino
    .syntax unified // Habilita las instrucciones Thumb-2
    .thumb // Usar instrucciones Thumb y no ARM
    .section .data // Define la sección de variables (RAM)

vector:     
        .byte 0x02, 0x04, 0x03, 0x3A // Inicializamos vector con datos 2,4,3,59 => Solo 2 impar
        .space 15, 0xFF //15 BYTES LLENOS CON 0xFF
base:    
        .space 20, 0x00
        .section .text
        .global reset

    .section .text
    .global reset
reset: 
    MOV R0,#0x04 // La longitud del vector esta almacenada en R0
    LDR R1,=vector // Apunta R1 al vector

    MOV R3,#0 // Cantidad de numeros impares
    MOV R4,#0 // Contador
lazo: 
    CMP R4,R0 // Comparacion entre Contador y Longitud del vector
    BGE guardar // Salto para finalizar estructura For
    LDRB R2,[R1],#1 // Carga en un registro el contenido de la direccion de memoria
    
    TST  R2,0x01 //
    IT NE // Si R2 And 01 es igual a uno => El numero es impar
    ADDNE R3,#1
    ADD R4,#1 //INCREMENTA CONTADOR
    B lazo
guardar:
    LDR R5,=base // Apunta R5 a base
    LDR R1,=vector // Apunta R1 al vector
    STR R1,[R5] // Enviamos direccion de memoria del vector a base
    STRB R3,[R5,#4]! // Enviamos cantidad de numeros impares a Base+4
    B stop
stop:
    B stop              // Lazo infinito
    .cpu cortex-m4              // Indica el procesador de destino  
    .syntax unified             // Habilita las instrucciones Thumb-2
    .thumb                      // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"

/**
* Programa principal, siempre debe ir al principio del archivo
*/
    .section .data


    .section .text              // Define la seccion de codigo (FLASH)
    .global reset               // Define el punto de entrada del codigo

reset:
    BL configurar

lazo:
    
    // Prendido de todos bits gpio de los digitos
    LDR R4,=GPIO_PIN0 //PRENDIDO DE CELDA DISPLAY
    LDR R5,=0x8 //1ra celda prendida
    STR R5,[R4]     

    MOV R2,#0x38
    LDR R1,=GPIO_PIN2
    STR R2,[R1]

    LDR R4,=GPIO_PIN0 //PRENDIDO DE CELDA DISPLAY
    LDR R5,=0x4 //2ra celda prendida
    STR R5,[R4]

    MOV R2,#0x3E
    LDR R1,=GPIO_PIN2
    STR R2,[R1]

    LDR R4,=GPIO_PIN0 //PRENDIDO DE CELDA DISPLAY
    LDR R5,=0x2 //3ra celda prendida
    STR R5,[R4]

    MOV R2,#0x06
    LDR R1,=GPIO_PIN2
    STR R2,[R1]

    LDR R4,=GPIO_PIN0 //PRENDIDO DE CELDA DISPLAY
    LDR R5,=0x1 //4ra celda prendida
    STR R5,[R4]

    MOV R2,#0x6D
    LDR R1,=GPIO_PIN2
    STR R2,[R1]

    B stop


stop:
    B stop              // Lazo infinito para terminar la ejecucion

    .align
    .pool

/**
* Inclusion de las funciones para configurar los teminales GPIO del procesador
*/
    .include "ejemplos/digitos.s"

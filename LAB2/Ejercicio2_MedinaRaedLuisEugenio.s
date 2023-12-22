/* Autor: Medina Raed, Luis Eugenio
Fecha de creacion: 28/09/2022

Evaluación del Laboratorio Número 2
Sistemas con Microprocesadores y Microcontroladores*/

/*Apartados C*/

        .cpu cortex-m4 // Indica el procesador de destino
        .syntax unified // Habilita las instrucciones Thumb-2
        .thumb // Usar instrucciones Thumb y no ARM
        .section .data // Define la sección de variables (RAM)
        
num:   .byte 215
        .align

        .section .text // Define la sección de código (FLASH)
        .func main
        .global reset

reset:
    LDR R0,=num // Cargo direccion de memoria en R0
    BL convertirA7seg // Llamado a funcion
    B mostrarNumero
mostrarNumero:
    LDR R2,=num
    ADD R2,#1 
    LDRB R0,[R2],#1 // Cargo en R0 mapa de bits
    MOV R1,#0x4 //3ra Celda prendida
    BL mostrar
    BL demora
    LDR R2,=num
    ADD R2,#2
    LDRB R0,[R2],#1 // Cargo en R0 mapa de bits
    MOV R1,#0x2 //2da Celda prendida
    BL mostrar
    BL demora
    LDR R2,=num
    ADD R2,#3
    LDRB R0,[R2],#1 // Cargo en R0 mapa de bits
    MOV R1,#0x1 //1ra Celda prendida
    BL mostrar
    BL demora
    B mostrarNumero
stop:
    B stop              // Lazo infinito

.endfunc

.func convertira7seg
convertirA7seg:
    LDRB R1,[R0] // Cargo numero en R1
    B lazoSepararDigitos
lazoSepararDigitos:
    //While(R0>=10):
    CMP R1,#10
    BLO finSepararDigitos
    //----
    SUB R1,#10 // Resto 10 y sumo a las decenas
    ADD R2,#1 // En R2 se almacenan decenas
    CMP R2,#10 // Cuando llego a 10 en decenas sumo 1 a centenas, y pongo decenas en 0
    ITT EQ 
    MOVEQ R2,#0 // Reinicio decenas
    ADDEQ R3,#1 // En R3 almaceno centenas
    B lazoSepararDigitos
finSepararDigitos:
    STRB R3,[R0,#1]!    // Guardo la centena en la primera posicion de memoria
    STRB R2,[R0,#1]!    // Guardo la decena en la segunda posicion de memoria
    STRB R1,[R0,#1]!    // Guardo la unidad en la tercera posicion de memoria
    B convertirDigitos
convertirDigitos:
    LDR R0,=tabla
    LDRB R1,[R0,R1] // Cargo unidad
    LDRB R2,[R0,R2] // Cargo decena
    LDRB R3,[R0,R3] // Cargo centena
    LDR R0,=num
    STRB R3,[R0,#1]!    //Guardo la centena CONVERTIDA en la primera posicion de memoria
    STRB R2,[R0,#1]!   //Guardo la decena CONVERTIDA en la segunda posicion de memoria
    STRB R1,[R0,#1]!  //Guardo la unidad CONVERTIDA en la tercera posicion de memoria
    LDR R0,=num
    BX LR
.endfunc

    .align
    .pool // Almacenar las constantes fijas (FLASH)
tabla: 
        .byte 0x3F,0x06,0x5b,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67

.include "LABORATORIOS/LAB2/funciones.s" 
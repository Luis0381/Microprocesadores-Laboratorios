    .cpu cortex-m4 // Indica el procesador de destino
    .syntax unified // Habilita las instrucciones Thumb-2
    .thumb // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"

    /****************************************************************************/
    /* Definiciones de macros */
    /****************************************************************************/


    // -------------------------------------------------------------------------

    /****************************************************************************/
    /* Vector de interrupciones */
    /****************************************************************************/

    .section .isr // Define una seccion especial para el vector
    .word stack // 0: Initial stack pointer value
    .word reset+1 // 1: Initial program counter value
    .word handler+1 // 2: Non mascarable interrupt service routine
    .word handler+1 // 3: Hard fault system trap service routine
    .word handler+1 // 4: Memory manager system trap service routine
    .word handler+1 // 5: Bus fault system trap service routine
    .word handler+1 // 6: Usage fault system tram service routine
    .word 0 // 7: Reserved entry
    .word 0 // 8: Reserved entry
    .word 0 // 9: Reserved entry
    .word 0 // 10: Reserved entry
    .word handler+1 // 11: System service call trap service routine
    .word 0 // 12: Reserved entry
    .word 0 // 13: Reserved entry
    .word handler+1 // 14: Pending service system trap service routine
    .word systick_isr+1 // 15: System tick service routine
    .word handler+1 // 16: Interrupt IRQ service routine

    /****************************************************************************/
    /* Definicion de variables globales */
    /****************************************************************************/


    .section .data // Define la seccion de variables (RAM)
    espera:
    .zero 1 // Variable compartida con el tiempo de espera

    // -------------------------------------------------------------------------

    /****************************************************************************/
    /* Programa principal */
    /****************************************************************************/
    .global reset // Define el punto de entrada del codigo
    .section .text // Define la seccion de codigo (FLASH)
    .func main // Inidica al depurador el inicio de una funcion
reset:

    // Mueve el vector de interrupciones al principio de la segunda RAM
    LDR R1,=VTOR
    LDR R0,=#0x10080000
    STR R0,[R1]

    //Demas del programa principal    










stop: B stop

    .pool // Almacenar las constantes de codigo
    .endfunc

/************************************************************************************/
/* Subrutinas*/
/************************************************************************************/

    .func /* Nombre */
/*Nombre*/:



    .pool // Se almacenan las constantes de codigo
    .endfunc


 // -------------------------------------------------------------------------



    .func /* Nombre */
/*Nombre*/:



    .pool // Se almacenan las constantes de codigo
    .endfunc


 // -------------------------------------------------------------------------






/************************************************************************************/
/* Rutina de servicio generica para excepciones */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa. */
/* Se declara como una medida de seguridad para evitar que el procesador */
/* se pierda cuando hay una excepcion no prevista por el programador */
/************************************************************************************/
.func handler
handler:
LDR R1,=GPIO_SET0 // Se apunta a la base de registros SET
MOV R0,#LED_1_MASK // Se carga la mascara para el LED 1
STR R0,[R1,#LED_1_OFFSET] // Se activa el bit GPIO del LED 1
B handler // Lazo infinito para detener la ejecucion
.pool // Se almacenan las constantes de codigo
.endfunc


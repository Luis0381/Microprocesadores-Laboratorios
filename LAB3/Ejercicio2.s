    .cpu cortex-m4 // Indica el procesador de destino
    .syntax unified // Habilita las instrucciones Thumb-2
    .thumb // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"
 /****************************************************************************/
/* Definiciones de macros */
/****************************************************************************/
//DIGITOS

// Recursos utilizados por el digito1
.equ DIG_1_PORT, 0
.equ DIG_1_PIN, 0
.equ DIG_1_BIT, 0
.equ DIG_1_MASK, (1 << DIG_1_BIT)

// Recursos utilizados por el digito2
.equ DIG_2_PORT, 0
.equ DIG_2_PIN, 1
.equ DIG_2_BIT, 1
.equ DIG_2_MASK, (1 << DIG_2_BIT)

// Recursos utilizados por el digito3
.equ DIG_3_PORT, 1
.equ DIG_3_PIN, 15
.equ DIG_3_BIT, 2
.equ DIG_3_MASK, (1 << DIG_3_BIT)

// Recursos utilizados por el digito3
.equ DIG_4_PORT, 1
.equ DIG_4_PIN, 17
.equ DIG_4_BIT, 3
.equ DIG_4_MASK, (1 << DIG_4_BIT)

// Numero de puerto GPIO utilizado por todos los digitos
.equ DIG_NUM_GPIO, 0

// Recursos utilizados por el led RGB

// Desplazamiento para acceder a los registros GPIO de los leds
.equ DIG_OFFSET, ( 4 * DIG_NUM_GPIO )

// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ DIG_MASK, ( DIG_1_MASK | DIG_2_MASK | DIG_3_MASK | DIG_4_MASK )

// -------------------------------------------------------------------------

//SEGMENTOS

// Recursos utilizados por el SEGMENTO B
.equ SEG_B_PORT, 4
.equ SEG_B_PIN, 1
.equ SEG_B_BIT, 1
.equ SEG_B_MASK, (1 << SEG_B_BIT)

// Recursos utilizados por el SEGMENTO C
.equ SEG_C_PORT, 4
.equ SEG_C_PIN, 2
.equ SEG_C_BIT, 2
.equ SEG_C_MASK, (1 << SEG_C_BIT)

// Numero de puerto GPIO utilizado por todos los segmentos
.equ SEG_NUM_GPIO, 2

// Desplazamiento para acceder a los registros GPIO de los leds
.equ SEG_OFFSET, ( 4 * SEG_NUM_GPIO )

// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ SEG_MASK, ( SEG_B_MASK | SEG_C_MASK  )

// -------------------------------------------------------------------------

//BOTONES PONCHO

// Recursos utilizados por el BOTON 1 no me andaba asi que use el ACCEPTAR
.equ BTN_1_PORT, 3
.equ BTN_1_PIN, 1
.equ BTN_1_BIT, 8
.equ BTN_1_MASK, (1 << BTN_1_BIT)

// Recursos utilizados por el BOTON 2 no me andaba asi que use el CANCELAR
.equ BTN_2_PORT, 3
.equ BTN_2_PIN, 2
.equ BTN_2_BIT, 9
.equ BTN_2_MASK, (1 << BTN_2_BIT)

// Recursos utilizados por el BOTON 3
.equ BTN_3_PORT, 4
.equ BTN_3_PIN, 10
.equ BTN_3_BIT, 14
.equ BTN_3_MASK, (1 << BTN_3_BIT)

// Recursos utilizados por el BOTON 4
.equ BTN_4_PORT, 6
.equ BTN_4_PIN, 7
.equ BTN_4_BIT, 15
.equ BTN_4_MASK, (1 << BTN_4_BIT)


// Numero de puerto GPIO utilizado por todos los segmentos
.equ BTN_NUM_GPIO, 5

// Desplazamiento para acceder a los registros GPIO de los leds
.equ BTN_OFFSET, ( BTN_NUM_GPIO << 2 )

// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ BTN_MASK, ( BTN_1_MASK | BTN_2_MASK | BTN_3_MASK | BTN_4_MASK  )

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
    .word handler+1 // 15: System tick service routine
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

    CPSID I
    //INICIALIZACIONES
    BL inicializarDigitos
    BL inicializarBotones
    BL inicializarSegmentos
    //--------

// Define los punteros para usar en el programa

 // Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0
    LDR R5,=GPIO_NOT0

    LDR R0,[R4,#SEG_OFFSET] //Guardo en R0 PIN04
    ORR R0,SEG_MASK //Elijo segmentos
    STR R0,[R4,#SEG_OFFSET] //GUardo el coso actualizado
    

lazoPrincipal:
    LDR R0,[R4,#BTN_OFFSET] //GUARDO EN R0 PIN CON VALOR DE BOTONES
    MOV R8,0x00

    TST R0,#BTN_1_MASK
    IT NE
    ORRNE R8,#DIG_1_MASK
    
    TST R0,#BTN_2_MASK
    IT NE
    ORRNE R8,#DIG_2_MASK

    TST R0,#BTN_3_MASK
    IT NE
    ORRNE R8,#DIG_3_MASK

    TST R0,#BTN_4_MASK
    IT NE
    ORRNE R8,#DIG_4_MASK 

    STR R8,[R4,#DIG_OFFSET] //guardo digitos

    B lazoPrincipal

    .pool // Almacenar las constantes de codigo
    .endfunc

/************************************************************************************/
/* Subrutinas*/
/************************************************************************************/
.func inicializarDigitos
inicializarDigitos:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE
            
    MOV R1,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R1,[R0,#(DIG_1_PORT<<7|DIG_1_PIN<<2)]
    STR R1,[R0,#(DIG_2_PORT<<7|DIG_2_PIN<<2)]
    STR R1,[R0,#(DIG_3_PORT<<7|DIG_3_PIN<<2)]
    STR R1,[R0,#(DIG_4_PORT<<7|DIG_4_PIN<<2)]

    //Configuracion GPIO

    //Configuro como Salidas
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#DIG_OFFSET]
    ORR R1,#DIG_MASK            //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#DIG_OFFSET]
 
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

.func inicializarBotones
inicializarBotones:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE

    MOV R1,#(SCU_MODE_PULLDOWN | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4 )
    STR R1,[R0,#(BTN_1_PORT<<7|BTN_1_PIN<<2)]
    STR R1,[R0,#(BTN_2_PORT<<7|BTN_2_PIN<<2)]
    STR R1,[R0,#(BTN_3_PORT<<7|BTN_3_PIN<<2)]
    STR R1,[R0,#(BTN_4_PORT<<7|BTN_4_PIN<<2)]

    //Configuro como ENTRADAS
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#BTN_OFFSET]
    LDR R2,=BTN_MASK
    BIC R1, R2   //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#BTN_OFFSET]




    BX LR // Se retorna al programa principal
IT NE
IT NE
IT NE
IT NE
.func inicializarSegmentos
inicializarSegmentos:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE

    MOV R1,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R1,[R0,#(SEG_B_PORT<<7|SEG_B_PIN<<2)]
    STR R1,[R0,#(SEG_C_PORT<<7|SEG_C_PIN<<2)]

    //Configuro como Salidas
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#SEG_OFFSET]
    ORR R1,#SEG_MASK            //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#SEG_OFFSET]

    BX LR // Se retorna al programa principal

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
B handler // Lazo infinito para detener la ejecucion
.pool // Se almacenan las constantes de codigo
.endfunc

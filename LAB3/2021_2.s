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
// Recursos utilizados por el SEGMENTO A
.equ SEG_A_PORT, 4
.equ SEG_A_PIN, 0
.equ SEG_A_BIT, 0
.equ SEG_A_MASK, (1 << SEG_A_BIT)


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

// Recursos utilizados por el SEGMENTO D
.equ SEG_D_PORT, 4
.equ SEG_D_PIN, 3
.equ SEG_D_BIT, 3
.equ SEG_D_MASK, (1 << SEG_D_BIT)

// Recursos utilizados por el SEGMENTO E
.equ SEG_E_PORT, 4
.equ SEG_E_PIN, 4
.equ SEG_E_BIT, 4
.equ SEG_E_MASK, (1 << SEG_E_BIT)

// Recursos utilizados por el SEGMENTO F
.equ SEG_F_PORT, 4
.equ SEG_F_PIN, 5
.equ SEG_F_BIT, 5
.equ SEG_F_MASK, (1 << SEG_F_BIT)

// Recursos utilizados por el SEGMENTO G
.equ SEG_G_PORT, 4
.equ SEG_G_PIN, 6
.equ SEG_G_BIT, 6
.equ SEG_G_MASK, (1 << SEG_G_BIT)

// Numero de puerto GPIO utilizado por todos los segmentos
.equ SEG_NUM_GPIO, 2

// Desplazamiento para acceder a los registros GPIO de los leds
.equ SEG_OFFSET, ( 4 * SEG_NUM_GPIO )

// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ SEG_MASK,    (SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK | SEG_G_MASK)

// -------------------------------------------------------------------------

//BOTONES PONCHO

// Recursos utilizados por el BOTON ACCEPTAR
.equ BTN_ACCEPTAR_PORT, 3
.equ BTN_ACCEPTAR_PIN, 1
.equ BTN_ACCEPTAR_BIT, 8
.equ BTN_ACCEPTAR_MASK, (1 << BTN_ACCEPTAR_BIT)

// Recursos utilizados por el BOTON CANCELAR
.equ BTN_CANCELAR_PORT, 3
.equ BTN_CANCELAR_PIN, 2
.equ BTN_CANCELAR_BIT, 9
.equ BTN_CANCELAR_MASK, (1 << BTN_CANCELAR_BIT)

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
.equ BTN_MASK, ( BTN_3_MASK | BTN_4_MASK | BTN_ACCEPTAR_MASK | BTN_CANCELAR_MASK )

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
    .word SistyckIsr+1 // 15: System tick service routine
    .word handler+1 // 16: Interrupt IRQ service routine

    /****************************************************************************/
    /* Definicion de variables globales */
    /****************************************************************************/


    .section .data // Define la seccion de variables (RAM)
    cronometro: .byte 0x09
    contInt: .byte 0x00
    parada: .byte 0x00

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

    //INICIALIZACIONES
    BL inicializarDigitos
    BL inicializarSegmentos
    BL inicializarSysTick
    //--------

lazoPrincipal:

    LDR R4,=GPIO_PIN0 
    LDR R0,[R4,#BTN_OFFSET]

    TST R0,#BTN_ACCEPTAR_MASK
    BEQ aceptarPresionada

    aceptarPresionada:
    LDRB R0,=parada
    LDRB R1,=cronometro
    LDRB R2,[R1]
    STRB R1,[R0] //guardo numero en parada
    B lazoPrincipal:

    


    .pool // Almacenar las constantes de codigo
    .endfunc
TABLA: .byte 0x3F,0x06,0x5b,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67
/************************************************************************************/
/* Subrutinas*/
/************************************************************************************/

//SUBRUTINA INTERRUPCION
.func SistyckIsr
SistyckIsr:
    push {LR}
    BL refrescarPantalla
    BL actualizarCronometro
    POP {LR}
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//---------------------------------

//SUBRUTINA PARA INTERRUPCION

.func actualizarCronometro
actualizarCronometro:
    PUSH {LR}
    PUSH {R5}
    LDR R0,=cronometro
    LDRB R1,[R0]
    CMP R1,#0
    ITT EQ
    MOVEQ R1,#9
    STRBEQ R1,[R0]

    LDR R4,=contInt
    LDRB R5,[R4]
    CMP R5,#10
    ITTTT EQ    
    LDRBEQ R1,[R0] //cargo valor cronometro
    SUBEQ R1,R1,#1
    STRBEQ R1,[R0]
    MOVEQ R5,#0

    ADD R5,R5,#1
    STRB R5,[R4]

    POP {R5}
    POP {PC} // Se retorna al programa principal
.pool // Se almacenan las constantes de codigo
.endfunc

.func refrescarPantalla
refrescarPantalla:
    PUSH {LR}
    PUSH {R5}
    //----
    BL apagarDigitos
    
    LDR R2,=cronometro;
    LDRB R0,[R2]
    BL convertirBCDa7Segmentos //Devuelve en R0 el display 7 segmento

    BL prenderSegmento

    MOV R0,#4 //Pongo en R0 el numero de digito que quiero prender
    BL prenderDigito

    POP {R5}
    POP {PC} // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc


//----------------------

//SUBRUTINAS DE CONVERSION

.func convertirBCDa7Segmentos
convertirBCDa7Segmentos :
        LDR R1,=TABLA
        LDRB R0,[R1,R0]
        BX LR

.pool // Se almacenan las constantes de codigo
.endfunc

//----------------------


//SUBRUTINAS DE SEGMENTOS

//Recibe en R0 el segmento que se quiere prender
.func prenderSegmento
prenderSegmento:
    //Limpio lo que haya en el segmento (APAGO TODO)
    LDR R1,=GPIO_CLR0
    LDR R2,=SEG_MASK
    STR R2,[R1,#SEG_OFFSET]

    //Cargo el segmento
    LDR R1,=GPIO_PIN0
    LDR R2,[R1,#SEG_OFFSET] //TRAIGO LO QUE YA ESTA EN EL GPIO
    ORR R0,R2               //HAGO UN OR entre lo que quiero mostrar y lo que habia en el GPIO
    STR R0,[R1,#SEG_OFFSET] //Cargo el segmento que quiero que se vea

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//Apaga todo los digitos
.func apagarDigitos
apagarDigitos:
    LDR R0,=GPIO_CLR0
    LDR R1,=DIG_MASK
    STR R1,[R0,#DIG_OFFSET]
 
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//Recibe en R0 el numero de digito que debo prender
.func prenderDigito
prenderDigito:
    PUSH {LR}
    MOV R0,#DIG_4_MASK
    LDR R1,=GPIO_PIN0
    LDR R2,[R1,#DIG_OFFSET] //TRAIGO LO QUE YA ESTA EN EL GPIO
    ORR R0,R2               //HAGO UN OR entre la mask del digito que quiero y lo que habia en el prender digito
    STR R0,[R1,#DIG_OFFSET]

    POP {PC}  // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//---------------

//SUBRUTINAS DE INICIALIZACION

.func inicializarSysTick
inicializarSysTick:
    CPSID I // Se deshabilitan globalmente las interrupciones

    // Se configura prioridad de la interrupcion
    LDR R1,=SHPR3 // Se apunta al registro de prioridades
    LDR R0,[R1] // Se cargan las prioridades actuales
    MOV R2,#2 // Se fija la prioridad en 2
    BFI R0,R2,#29,#3 // Se inserta el valor en el campo
    STR R0,[R1] // Se actualizan las prioridades


    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x00
    STR R0,[R1] // Se quita el bit ENABLE

    // Se configura el desborde para un periodo de 100 ms
    LDR R1,=SYST_RVR
    LDR R0,=#(4800000 - 1)
    STR R0,[R1] // Se especifica el valor de RELOAD

    // Se inicializa el valor actual del contador
    LDR R1,=SYST_CVR
    MOV R0,#0

    // Escribir cualquier valor limpia el contador
    STR R0,[R1] // Se limpia COUNTER y flag COUNT

    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x07
    STR R0,[R1] // Se fijan ENABLE, TICKINT y CLOCK_SRC


   

    CPSIE I // Se habilitan globalmente las interrupciones

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

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

    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    LDR R1,=DIG_MASK
    STR R1,[R0,#DIG_OFFSET]
    //-----

    //Configuro como Salidas
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#DIG_OFFSET]
    ORR R1,#DIG_MASK            //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#DIG_OFFSET]
 
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

.func inicializarSegmentos
inicializarSegmentos:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE

    MOV R1,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R1,[R0,#(SEG_A_PORT<<7|SEG_A_PIN<<2)]
    STR R1,[R0,#(SEG_B_PORT<<7|SEG_B_PIN<<2)]
    STR R1,[R0,#(SEG_C_PORT<<7|SEG_C_PIN<<2)]
    STR R1,[R0,#(SEG_D_PORT<<7|SEG_D_PIN<<2)]
    STR R1,[R0,#(SEG_E_PORT<<7|SEG_E_PIN<<2)]
    STR R1,[R0,#(SEG_F_PORT<<7|SEG_F_PIN<<2)]
    STR R1,[R0,#(SEG_G_PORT<<7|SEG_G_PIN<<2)]

    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    LDR R1,=SEG_MASK
    STR R1,[R0,#SEG_OFFSET]
    //-----

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

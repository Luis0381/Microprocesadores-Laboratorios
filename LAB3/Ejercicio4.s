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
    cronometro: .byte 0x00,0x00,0x00,0x00 //MIDE SEGUNDOS Y MINUTOS
    refresco: .byte 0x00
    divisor: .hword 0x00
    digito: .word parada
    parada: .byte 0x00,0x00,0x00,0x00
    modo: .byte 0x00 //MODO 0 PARADO | MODO 1 CONTANDO 
    teclaAnterior: .word 0x00
    teclaActual: .word 0x00

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
    BL inicializarBotones
    BL inicializarSysTick
    //--------
    LDR R2,=cronometro
    LDR R3,=parada
    LDR R4,=GPIO_PIN0 
    LDR R5, =modo //direccion de modo
    LDR R7,=digito
    

    //BANDERA

lazoPrincipal:
    LDRB R6,[R5] //Conservo el ultimo estado leido en R6
    CMP R6,0x00 //Veo si estoy en modo normal
    BEQ pantallaParada

 pantallaContando:
    STR R2,[R7] //Guardo en digito la direccion de cronometro
    B pantallaFin
 pantallaParada:
    STR R3,[R7] //Guardo en digito la direccion de parada
    B pantallaFin
 pantallaFin:

    //LEO LA ENTRADA ACTUAL
    LDR R0,[R4,#BTN_OFFSET]
    //-----

    //MI intento de no "confundir al programa con toques multiples"
    LDR R8,=teclaAnterior
    LDR R8,[R8]

    CMP R0,R8
    BEQ fin
    LDR R8,=teclaAnterior
    STR R0,[R8]

    CMP R0,#0
    BEQ fin 
    //-------

    TST R0,#BTN_ACCEPTAR_MASK
    BEQ finTeclaAcceptar
    
 teclaAcceptar:
    CMP R6,0x00 //Veo si estoy en modo normal
    BNE pararCuenta
 comenzarCuenta:
    MOV R1,#1
    STRB R1,[R5] //Cambio a modo 1

    LDR R1,[R3]     //cargo el valor de parada 
    STR R1,[R2]     //Guardo el valor de parada en cronometro
    B finTeclaAcceptar
 pararCuenta:    
    MOV R1,#0
    STRB R1,[R5] //Cambio a modo 0

    LDR R1,[R2] //cargo en R1 el valor de cronometro
    STR R1,[R3] //Guardo el valor de cronometro en parada
    //B finTeclaAcceptar
 finTeclaAcceptar: 

    LDR R0,[R4,#BTN_OFFSET] 
    TST R0,#BTN_CANCELAR_MASK
    BEQ finTeclaCancelar  
 teclaCancelar:
    MOV R1,#0
    STRB R1,[R5] //Cambio a modo 0

    STR R1,[R3] //Guardo el valor de 0 en parada
    //B finTeclaCancelar lo pongo a modo informativo
 
 finTeclaCancelar:

 fin:


    

B lazoPrincipal

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

    BL actualizarHora
    BL refrescarPantalla
    
    POP {LR}
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//---------------------------------

//SUBRUTINA PARA INTERRUPCION

.func actualizarHora
actualizarHora:
    PUSH {LR}
    PUSH {R5}

    //CONTROL PARA SABER SI PASARON 1000 INTERRUPCIONES
    MOV R0,#0   //ESTABLEZCO EN 0 R0 
    
    LDR R1,=divisor  //Direccion al contador de cuantas interrupcionesPasaron
    LDRH R2,[R1]    //Cargo valor

    ADD R2,#1

    CMP R2,#1000//Aca va 1000
    ITT EQ
    MOVEQ R2,#0
    MOVEQ R0,#1

    STRH R2,[R1] //Guardo el valor en divisor
    //-----------
    //Actualizacion horas
    //Recibe en R0 si debe incrementar segundos y en R1 la direccion de los segundos
    LDR R1,=cronometro
    BL incrementarSegundos //Devuelve en R0 si hay desbordamiento de segundos
    LDR R1,=cronometro
    ADD R1,#2 //Dejo apuntando a la parte de las horas empezando por la parte menos sig
    BL incrementarMinutos

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
    BL refrescoDigito

    MOV R5,R0 //Salvo el numero de refresco
    LDR R1,=digito
    LDR R1,[R1]
    LDRB R0,[R1,R0] //Guardo en R0 el numero BCD que quiero convertir
    BL convertirBCDa7Segmentos //Devuelve en R0 el display 7 segmento

    BL prenderSegmento

    MOV R0,R5 //Pongo en R0 el numero de digito que quiero prender
    BL prenderDigito

    POP {R5}
    POP {PC} // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//---------------------------------


//SUBRUTINAS DE RELOJ

.func incrementarSegundos
incrementarSegundos:
        PUSH {R4-R5}
        //Recibe el valor numerico 1 en R0
        //EN R4 y R5 guardare el valor de los segundos(NO lo deseo conservar asi que no hay drama)
        LDRB R4,[R1] //Menos signif
        LDRB R5,[R1,#1] //Mas significativo

        //COndicion SI el valor de R0 es 1
        CMP R0,0x01
        IT EQ  
        ADDEQ R4,#1 //Sumo 01 seg
        //----

        MOV R0,#0 //Establezco por defecto la bandera R0 en 0

        //Condicion dig menos significativo mayor a 9
        CMP R4,0x09
        ITT HI
        MOVHI R4,#0 //Si el dig menos sig llega 9 vuelve a cero
        ADDHI R5,#1 //Sumo 1 al dig mas significativo
        //----

        CMP R5,0x05
        ITT HI
        MOVHI R5,#0
        MOVHI R0,#1 //Bandera en 1 para indicar desbordamiento

        //Realizo guardado de los segundos correspondientes
        STRB R4,[R1] //Menos signif
        STRB R5,[R1,#1] //Mas significativo

        POP {R4-R5}
        BX LR  //Salto colocando en el pc la instruccion en LR



.pool // Se almacenan las constantes de codigo
.endfunc

//Recibe en R0 si debo o no incrementar horas, R1 direccion a horas
.func incrementarMinutos
incrementarMinutos:
        PUSH {R4-R5}
        //Recibe el valor numerico 1 en R0
        //EN R4 y R5 guardare el valor de los segundos(NO lo deseo conservar asi que no hay drama)
        LDRB R4,[R1] //Menos signif
        LDRB R5,[R1,#1] //Mas significativo

        //COndicion SI el valor de R0 es 1
        CMP R0,0x01
        IT EQ  
        ADDEQ R4,#1 //Sumo 01 minuto
        //----

    primeraCondicion:
        CMP R5,#9
        BEQ segundaCondicion
        B FinSentencia
    segundaCondicion:
        CMP R4,#9
        BHI sentencia
        B FinSentencia
    sentencia:
        MOV R4,#0
        MOV R5,#0

    FinSentencia:

        //Condicion dig menos significativo mayor a 9
        CMP R4,0x09
        ITT HI
        MOVHI R4,#0 //Si el dig menos sig llega 9 vuelve a cero
        ADDHI R5,#1 //Sumo 1 al dig mas significativo
        //----------------

        //Realizo guardado de los segundos correspondientes
        STRB R4,[R1] //Menos signif
        STRB R5,[R1,#1] //Mas significativo

        POP {R4-R5}
        BX LR  //Salto colocando en el pc la instruccion en LR



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
    BL seleccionarDigito
    LDR R1,=GPIO_PIN0
    LDR R2,[R1,#DIG_OFFSET] //TRAIGO LO QUE YA ESTA EN EL GPIO
    ORR R0,R2               //HAGO UN OR entre la mask del digito que quiero y lo que habia en el prender digito
    STR R0,[R1,#DIG_OFFSET]

    POP {PC}  // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

.func seleccionarDigito
seleccionarDigito:
    MOV R1,R0
    CMP R1,0x00
    IT EQ
    MOVEQ R0,#DIG_1_MASK

    CMP R1,0x01
    IT EQ
    MOVEQ R0,#DIG_2_MASK

    CMP R1,0x02
    IT EQ
    MOVEQ R0,#DIG_3_MASK

    CMP R1,0x03
    IT EQ
    MOVEQ R0,#DIG_4_MASK

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//Devuelve en R0 el numero de refresco
.func refrescoDigito
refrescoDigito:
    MOV R2,#0
    LDR R1, =refresco //Cargo lo guardado en refresco
    LDRB R2,[R1] //GUARDO en R2 el valor del numero refresco
    MOV R0,R2   //Guardo el valor actual de refresco en R0 para devolver en la funcion

    ADD R2,#1 //Sumo 1 
    CMP R2,#4   //Si llegue al valor de 4, debo resetear el refresco
    IT EQ   
    MOVEQ R2,#0

    STRB R2,[R1] //Guardo el nuevo valor de refresco de digito

    //Devuelvo en R0 el valor de digito que corresponde prender
    BX LR // Se retorna al programa principal

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

    // Se configura el desborde para un periodo de 1 ms
    LDR R1,=SYST_RVR
    LDR R0,=#(48000 - 1)
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

.func inicializarBotones
inicializarBotones:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE

    MOV R1,#(SCU_MODE_PULLDOWN | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4 )
    STR R1,[R0,#(BTN_ACCEPTAR_PORT<<7|BTN_ACCEPTAR_PIN<<2)]
    STR R1,[R0,#(BTN_CANCELAR_PORT<<7|BTN_CANCELAR_PIN<<2)]
    STR R1,[R0,#(BTN_3_PORT<<7|BTN_3_PIN<<2)]
    STR R1,[R0,#(BTN_4_PORT<<7|BTN_4_PIN<<2)]

    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    MOV R1,#BTN_MASK
    STR R1,[R0,#BTN_OFFSET]
    //-----

    //Configuro como ENTRADAS
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#BTN_OFFSET]
    LDR R2,=BTN_MASK
    BIC R1, R2   //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#BTN_OFFSET]

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











.func inicializarTimer
inicializarTimer:

    //Esto se configuraria mejor dependiendo el caso
    // Configura el pin del punto como salida TMAT
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC5)
    STR R0,[R1,#(LED_PORT << 7 | LED_PIN << 2)]
    //-------------------


    // Cuenta con clock interno
    LDR R1,=TIMER2_BASE
    MOV R0,#0x00
    STR R0,[R1,#CTCR]

    //Se ajusta de acuerdo al caso
    // Prescaler de 9.500.000 para una frecuencia de 10 Hz
    LDR R0,=9500000
    STR R0,[R1,#PR]
    //----------------------


    // El valor del periodo para 1 Hz
    LDR R0,=5
    STR R0,[R1,#MR1]


    //LINEA OPCIONAL
    // El registro de match 3 provoca reset del contador e interrupcion
    MOV R0,#(MR3R | MR3I)
    STR R0,[R1,#MCR]



    //Linea opcional es para controlar la salida del pin debido a match
    // Define el estado inicial y toggle on match del led
    MOV R0,#(3 << (4 + (2 * LED_MAT))) //+4 porque esta pasando los 4 bits que serian el estado de cada pin que sale del match y la opcion 11 es el estado de toogle por eso el 3
    STR R0,[R1,#EMR]
    //-------------------



    // Limpieza del contador
    MOV R0,#CRST
    STR R0,[R1,#TCR]

    // Inicio del contador
    MOV R0,#CEN
    STR R0,[R1,#TCR]

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc



.func configurarInterrupcionTimer //EnNVIC
configurarInterrupcionTimer:
    // Limpieza del pedido pendiente en el NVIC
    LDR R1,=NVIC_ICPR0
    MOV R0,(1 << 12)
    STR R0,[R1]

    // Habilitacion del pedido de interrupcion en el NVIC
    LDR R1,=NVIC_ISER0
    MOV R0,(1 << 12)
    STR R0,[R1]
 
    //ACA TAMBIEN DEBERIA AGREGAR TEMA DE PRIORIDAD DE LA INTERRUPCION PARA EL NVIC Y TODO ESE ASUNTO CON IPR

    CPSIE I     // Rehabilita interrupciones


.pool // Se almacenan las constantes de codigo
.endfunc
